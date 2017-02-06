From: kefu chai <tchaikov@gmail.com>
Subject: Re: need help about _ASSERT_H in dout
Date: Mon, 6 Feb 2017 19:15:39 +0800
Message-ID: <CAJE9aOPFTSMwvLT2zsQ4d_WsxGMOkYzbB9Q9V3dtfE2TXU4Y2w@mail.gmail.com>
References: <CACKY0b_diMsgocA=NLEG3+7mjno+w8ULcccGASYd62RamiE2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33433 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdBFLPk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 06:15:40 -0500
Received: by mail-ua0-f195.google.com with SMTP id d5so6901726uag.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 03:15:40 -0800 (PST)
In-Reply-To: <CACKY0b_diMsgocA=NLEG3+7mjno+w8ULcccGASYd62RamiE2VA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 6, 2017 at 7:00 PM, liuchang0812 <liuchang0812@gmail.com> wrote=
:
> hi, Sage and Cephers
>
> I tried to use boost::algorithm in os/bluefs.cc this afternoon. I got
> such error when i included "boost/algorithm/string.hpp".
>
> /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
> function =E2=80=98int BlueFS::add_block_device(unsigned int,
> std::__cxx11::string)=E2=80=99:
> /home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
> operand of =E2=80=98->=E2=80=99 is not a pointer
>    _ASSERT_H->_log->submit_entry(_dout_e);  \
>
>
> I have found this commit[1] that includes _ASSERT_H. i can't
> understand why replace _dout_cct with _ASSERT_H and what
> boost::algorithm confilicts with _ASSERT_H=E3=80=82

because boost/algorithm/string.hpp includes "assert.h" from libc. you
need to re-included "include/assert.h" to override the `assert()` from
libc.

>
> thanks, any comments are appreciated.
>
>
> [1]: https://github.com/ceph/ceph/commit/a30601a1b69c3f1ac5cfa592050877ae=
c8b5be9d
>
> [2]: more log as :
>
> /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
> function =E2=80=98int BlueFS::add_block_device(unsigned int,
> std::__cxx11::string)=E2=80=99:
> /home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
> operand of =E2=80=98->=E2=80=99 is not a pointer
>    _ASSERT_H->_log->submit_entry(_dout_e);  \
>             ^
> /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:65: note:
> in expansion of macro =E2=80=98dendl=E2=80=99
>    dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
>                                                                  ^
> /home/liuchang/WorkSpace/ceph/src/common/dout.h:62:18: warning: unused
> variable =E2=80=98_dout_cct=E2=80=99 [-Wunused-variable]
>      CephContext *_dout_cct =3D cct;     \
>                   ^
> /home/liuchang/WorkSpace/ceph/src/common/dout.h:66:24: note: in
> expansion of macro =E2=80=98dout_impl=E2=80=99
>  #define ldout(cct, v)  dout_impl(cct, dout_subsys, v) dout_prefix
>                         ^
> /home/liuchang/WorkSpace/ceph/src/common/debug.h:23:17: note: in
> expansion of macro =E2=80=98ldout=E2=80=99
>  #define dout(v) ldout((dout_context), v)
>                  ^
> /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:3: note:
> in expansion of macro =E2=80=98dout=E2=80=99
>    dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
