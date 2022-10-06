package com.bingchunmoli.api.daily.controller;

import com.bingchunmoli.api.bean.ResultVO;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author MoLi
 */
@RestController
@RequestMapping("daily")
@RequiredArgsConstructor
public class DailyController {

    Map<String, Collection<String>> map = new HashMap<>();

    @GetMapping
    public ResultVO<Object> getDailys(String key) {
        return ResultVO.ok(map.get(key) == null ? null : map.get(key));
    }

    @PutMapping
    public ResultVO<Boolean> addDaily(@RequestBody Daily daily){
        if (map.containsKey(daily.getKey())) {
            map.get(daily.getKey()).add(daily.getValue());
        }else {
            map.put(daily.getKey(), Stream.of(daily.getValue()).collect(Collectors.toList()));
        }
        return ResultVO.ok(true);
    }

}

@Data
class Daily{
    private String key;
    private String value;
}
