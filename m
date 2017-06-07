From: zengran zhang <z13121369189@gmail.com>
Subject: tracker issue 19605
Date: Wed, 7 Jun 2017 20:24:52 +0800
Message-ID: <CALi+v19jWpSQ9Uy3fLsCkM7G+wbhp=Hm=Qd-ASDY3iBvdH=tiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33627 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdFGMYx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jun 2017 08:24:53 -0400
Received: by mail-io0-f181.google.com with SMTP id b184so6045553ioe.0
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jun 2017 05:24:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai <haomai@xsky.com>
Cc: ceph-devel@vger.kernel.org

hi Sage & Haomai:

here we hit a assert the same as reported in
tracker.(http://tracker.ceph.com/issues/19605)

its hard to reproduce, and now only have limited logs, post useful
info as follow.
line#1 2017-05-19 22:58:05.142005 7f14f1c1e700  0 --
10.10.133.1:6823/2019 >> 10.10.133.1:6813/19500 conn(0x55e70327c000
:6823 s=3DSTATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=3D0 cs=3D0
l=3D0).handle_connect_msg accept we reset (peer sent cseq 1), sending
RESETSESSION
line#2 2017-05-19 22:58:05.142720 7f14f1c1e700  0 --
10.10.133.1:6823/2019 >> 10.10.133.1:6813/19500 conn(0x55e70327c000
:6823 s=3DSTATE_OPEN_MESSAGE_READ_FOOTER_AND_DISPATCH pgs=3D20 cs=3D1
l=3D0).process missed message?  skipped from seq 0 to 1934764039
line#3 2017-05-19 22:58:05.142834 7f14de2a2700  0 osd.0 pg_epoch:
78440 pg[9.10cs0( v 78440'6350 (78438'4241,78440'6350] local-les=3D78440
n=3D8 ec=3D77949 les/c/f 78440/78440/0 78439/78439/78372)
[0,2147483647,6,7,10,1] r=3D0 lpr=3D78439 luod=3D78440'6348 crt=3D78440'631=
9
lcod 78440'6319 mlcod 78440'6319 active+undersized+degraded]  removing
repgather(0x55e708089000 78440'6348 rep_tid=3D26665 committed?=3D1
applied?=3D1 r=3D0)
line#4 2017-05-19 22:58:05.142849 7f14de2a2700  0 osd.0 pg_epoch:
78440 pg[9.10cs0( v 78440'6350 (78438'4241,78440'6350] local-les=3D78440
n=3D8 ec=3D77949 les/c/f 78440/78440/0 78439/78439/78372)
[0,2147483647,6,7,10,1] r=3D0 lpr=3D78439 luod=3D78440'6348 crt=3D78440'631=
9
lcod 78440'6319 mlcod 78440'6319 active+undersized+degraded]    q
front is repgather(0x55e6f92c9980 78440'6343 rep_tid=3D26656
committed?=3D0 applied?=3D0 r=3D0)
line#5 2017-05-19 22:58:05.149253 7f14de2a2700 -1
/build/ceph-12.0.2/src/osd/PrimaryLogPG.cc: In function 'void
PrimaryLogPG::eval_repop(PrimaryLogPG::RepGather*)' thread
7f14de2a2700 time 2017-05-19 22:58:05.142856
line#6 /build/ceph-12.0.2/src/osd/PrimaryLogPG.cc: 8615: FAILED
assert(repop_queue.front() =3D=3D repop)

we can see that, the connection got something wrong(line#1 remote
reconnect but conn_seq=3D=3D1), and sent session-reset to remote osd. then
remote osd
goto AsyncConnection::was_session_reset() and discard_out_queue() !
maybe this cause the ordered op-reply message be discard, then remote
send follower op's
reply when session reconnected. i checked the
OSD::ms_handle_remote_reset(), it do nothing, so remote will not
resend the reply-op,right? if not assert here, primary pg's osd will
requeue the client op after reconnect in Objecter::ms_handle_reset().

so the problem here is the remote reconnect with conn_seq=3D1?

will check reply tomorrow=EF=BC=8Csorry!
