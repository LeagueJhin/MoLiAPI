package com.bingchunmoli.api.down.init;

import com.bingchunmoli.api.down.bean.OSInfo;
import com.bingchunmoli.api.down.service.InitUtilService;
import com.bingchunmoli.api.down.task.RefreshFav;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.util.Locale;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author bingchunmoli
 */
@Slf4j
@Component
@Profile("prod")
@RequiredArgsConstructor
public class DownloadCommandLineRunner implements CommandLineRunner {
    //备用
//    private static final String RSS_URL = "https://rsshub.app/bilibili/fav/150330096/56939296";
    private final RefreshFav refreshFav;
    private final Map<String, InitUtilService> initUtilServiceMap;

    private static OSInfo getOSInfo() {
        String name = System.getProperty("os.name").toLowerCase(Locale.US);
        String arch = System.getProperty("os.arch").toLowerCase(Locale.US);
        String version = System.getProperty("os.version").toLowerCase(Locale.US);
        OSInfo osInfo = OSInfo.builder().name(name).arch(arch).version(version).build();
        if (name.contains("windows")) {
            osInfo.setServiceName("initWindowsUtilServiceImpl");
        } else {
            osInfo.setServiceName("initLinuxUtilServiceImpl");
        }
        return osInfo;
    }

    @Override
    public void run(String... args) throws Exception {
//        if (SystemConfig.getInit()) {
//            initUtil();
//        }else {
        refreshFav.refreshInterface();
//        }
    }

    private void initUtil() {
        log.info("目前只支持windows和linuxX64获取, 只根据osName判断是否含有windows");
        OSInfo osInfo = getOSInfo();
        log.debug("initUtil: osInfo: {}", osInfo);
        InitUtilService initUtilService = initUtilServiceMap.get(osInfo.getServiceName());
        CountDownLatch countDownLatch = new CountDownLatch(4);
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(2, 4, 10, TimeUnit.MINUTES, new LinkedBlockingDeque<>(4), new ThreadPoolExecutor.AbortPolicy());
        threadPoolExecutor.execute(() -> initUtilService.initBaiduPCS(countDownLatch));
        threadPoolExecutor.execute(() -> initUtilService.initBBDown(countDownLatch));
        threadPoolExecutor.execute(() -> initUtilService.initRclone(countDownLatch));
        threadPoolExecutor.execute(() -> initUtilService.initYouGet(countDownLatch));
        while (countDownLatch.getCount() != 0) {
        }
    }

}
