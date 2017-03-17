From: liuchang0812 <liuchang0812@gmail.com>
Subject: why do we delete target in RGWGetObjLayout constructed function?
Date: Fri, 17 Mar 2017 17:58:14 +0800
Message-ID: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34434 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdCQJ7X (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Mar 2017 05:59:23 -0400
Received: by mail-yw0-f171.google.com with SMTP id p77so49663077ywg.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Mar 2017 02:58:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I saw this problem when i read RGW source code. It seems that that
`delete` a nullptr will segment fault.

code[1]:

class RGWGetObjLayout : public RGWOp {
   protected:
        RGWRados::Object *target{nullptr};
        RGWObjManifest *manifest{nullptr};
        rgw_raw_obj head_obj;
    public:
         RGWGetObjLayout() {
             delete target;
   }


[1]. https://github.com/ceph/ceph/blob/master/src/rgw/rgw_op.h#L1777
