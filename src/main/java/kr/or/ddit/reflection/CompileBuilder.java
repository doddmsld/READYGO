package kr.or.ddit.reflection;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.HashMap;
import java.util.Map;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import kr.or.ddit.reflection.MethodExecutation;
import kr.or.ddit.reflection.ApiResponseResult;
import kr.or.ddit.util.UUIDUtil;

@Slf4j
@Component
public class CompileBuilder {
    private final String path = "C:/test/compile/";

    @SuppressWarnings({ "resource", "deprecation" })
    public Object compileCode(String body) throws Exception {
        String uuid = UUIDUtil.createUUID();
        String uuidPath = path + uuid + "/";
        // 디렉토리 및 파일 생성
        File newFolder = new File(uuidPath);
        if (!newFolder.mkdirs()) {
            log.error("디렉토리 생성 실패: {}", uuidPath);
            throw new IOException("디렉토리 생성 실패");
        }

        File sourceFile = new File(uuidPath + "DynamicClass.java");
        File classFile = new File(uuidPath + "DynamicClass.class");

        Class<?> cls = null;

        // System err console을 처리할 변수
        ByteArrayOutputStream err = new ByteArrayOutputStream();
        PrintStream origErr = System.err;

        try (FileWriter writer = new FileWriter(sourceFile)) {
            // Java 파일 작성
            writer.write(body);
            writer.flush();

            // 컴파일
            JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
            System.setErr(new PrintStream(err));

            int compileResult = compiler.run(null, null, null, sourceFile.getPath());
            if (compileResult != 0) {
                return "컴파일 실패: " + err.toString();
            }

            // 컴파일된 클래스 로드
            try (URLClassLoader classLoader = URLClassLoader.newInstance(new URL[] { new File(uuidPath).toURI().toURL() })) {
                cls = Class.forName("DynamicClass", true, classLoader);
                return cls.getDeclaredConstructor().newInstance();
            }

        } catch (Exception e) {
            log.error("[CompileBuilder] 소스 컴파일 중 에러 발생: {}", e.getMessage(), e);
            return "에러 발생: " + e.getMessage();
        } finally {
            // System err stream 원상태로 복원
            System.setErr(origErr);

            // 파일 및 디렉토리 정리
            if (sourceFile.exists()) sourceFile.delete();
            if (classFile.exists()) classFile.delete();
            if (newFolder.exists()) newFolder.delete();
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<String, Object> runObject(Object obj, Object[] params) throws Exception {
        Map<String, Object> returnMap = new HashMap<>();
        String methodName = "runMethod";
        Class arguments[] = new Class[params.length];
        for (int i = 0; i < params.length; i++) {
            arguments[i] = params[i].getClass();
        }

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ByteArrayOutputStream err = new ByteArrayOutputStream();
        PrintStream origOut = System.out;
        PrintStream origErr = System.err;

        try {
            System.setOut(new PrintStream(out));
            System.setErr(new PrintStream(err));

            Map<String, Object> result = MethodExecutation.timeOutCall(obj, methodName, params, arguments);

            // 결과 처리
            if ((Boolean) result.get("result")) {
                returnMap.put("result", ApiResponseResult.SUCEESS.getText());
                returnMap.put("return", result.get("return"));
                if (err.size() > 0) {
                    returnMap.put("SystemOut", err.toString());
                } else {
                    returnMap.put("SystemOut", out.toString());
                }
            } else {
                returnMap.put("result", ApiResponseResult.FAIL.getText());
                if (err.size() > 0) {
                    returnMap.put("SystemOut", err.toString());
                } else {
                    returnMap.put("SystemOut", "제한 시간 초과");
                }
            }
        } catch (Exception e) {
            log.error("메소드 실행 중 에러 발생: {}", e.getMessage(), e);
            throw e;
        } finally {
            // System out, err 스트림 원상태로 복원
            System.setOut(origOut);
            System.setErr(origErr);
        }

        return returnMap;
    }
}
