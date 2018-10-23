/**
 * FileName: MemberServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 13:34
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.MemberMapper;
import com.qst.goldenarches.pojo.VIP;
import com.qst.goldenarches.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;

    public List<VIP> getAll(Map<String, String> map) {
        return memberMapper.selectAll(map);
    }

    public void editMemberBalance(VIP vip) {
        memberMapper.updateMemberBalance(vip);
    }
}
