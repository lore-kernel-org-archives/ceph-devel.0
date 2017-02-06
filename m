From: liuchang0812 <liuchang0812@gmail.com>
Subject: need help about _ASSERT_H in dout
Date: Mon, 6 Feb 2017 19:00:37 +0800
Message-ID: <CACKY0b_diMsgocA=NLEG3+7mjno+w8ULcccGASYd62RamiE2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174]:35124 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdBFLAj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 06:00:39 -0500
Received: by mail-yb0-f174.google.com with SMTP id o65so24245919ybo.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 03:00:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

hi, Sage and Cephers

I tried to use boost::algorithm in os/bluefs.cc this afternoon. I got
such error when i included "boost/algorithm/string.hpp".

/home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
function =E2=80=98int BlueFS::add_block_device(unsigned int,
std::__cxx11::string)=E2=80=99:
/home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
operand of =E2=80=98->=E2=80=99 is not a pointer
   _ASSERT_H->_log->submit_entry(_dout_e);  \


I have found this commit[1] that includes _ASSERT_H. i can't
understand why replace _dout_cct with _ASSERT_H and what
boost::algorithm confilicts with _ASSERT_H=E3=80=82

thanks, any comments are appreciated.


[1]: https://github.com/ceph/ceph/commit/a30601a1b69c3f1ac5cfa592050877aec8=
b5be9d

[2]: more log as :

/home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
function =E2=80=98int BlueFS::add_block_device(unsigned int,
std::__cxx11::string)=E2=80=99:
/home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
operand of =E2=80=98->=E2=80=99 is not a pointer
   _ASSERT_H->_log->submit_entry(_dout_e);  \
            ^
/home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:65: note:
in expansion of macro =E2=80=98dendl=E2=80=99
   dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
                                                                 ^
/home/liuchang/WorkSpace/ceph/src/common/dout.h:62:18: warning: unused
variable =E2=80=98_dout_cct=E2=80=99 [-Wunused-variable]
     CephContext *_dout_cct =3D cct;     \
                  ^
/home/liuchang/WorkSpace/ceph/src/common/dout.h:66:24: note: in
expansion of macro =E2=80=98dout_impl=E2=80=99
 #define ldout(cct, v)  dout_impl(cct, dout_subsys, v) dout_prefix
                        ^
/home/liuchang/WorkSpace/ceph/src/common/debug.h:23:17: note: in
expansion of macro =E2=80=98ldout=E2=80=99
 #define dout(v) ldout((dout_context), v)
                 ^
/home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:3: note:
in expansion of macro =E2=80=98dout=E2=80=99
   dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
