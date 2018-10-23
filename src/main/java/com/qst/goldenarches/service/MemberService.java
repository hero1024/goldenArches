/**
 * FileName: MemberService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 13:34
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.VIP;

import java.util.List;
import java.util.Map;

public interface MemberService {
    List<VIP> getAll(Map<String, String> map);

    void editMemberBalance(VIP vip);
}
