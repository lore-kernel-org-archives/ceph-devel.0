From: Christian Brunner <chb@muc.de>
Subject: Re: cosd dying after start
Date: Tue, 10 Aug 2010 17:42:46 +0200
Message-ID: <AANLkTimkkWjc6_NrtU2nYTB99c9v1fCuN-WUyTpCjqfa@mail.gmail.com>
References: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52024 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0HJPms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 11:42:48 -0400
Received: by wyb32 with SMTP id 32so836695wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Aug 2010 08:42:47 -0700 (PDT)
In-Reply-To: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is another log with debug_osd=10:

[...]
10.08.10_17:40:03.676037 7fdc2b3e3710 osd2 235 enqueue_op waiting for
pending_ops 11 to drop to 10
10.08.10_17:40:03.676067 7fdc294df710 osd2 235 dequeue_op 0x7fdbec001160 finish
10.08.10_17:40:03.676107 7fdc294df710 osd2 235 dequeue_op
osd_op(client845990.0:34 rb.0.1d6.00000000000e [write 0~1315841]
3.e7f2 RETRY) v1 pg pg[3.f2( v 174'52009 (174'52008,174'52009] n=204
ec=2 les=235 234/234/234) [2] r=0 lcod 0'0 mlcod 0'0 active+clean], 9
more pending
10.08.10_17:40:03.676154 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_op osd_op(client845990.0:34
rb.0.1d6.00000000000e [write 0~1315841] 3.e7f2 RETRY) v1
10.08.10_17:40:03.676194 7fdc2b3e3710 osd2 235 request for pool=3
(rbd) owner=0 perm=7 may_read=0 may_write=1 may_exec=0
require_exec_caps=0
10.08.10_17:40:03.676216 7fdc2b3e3710 osd2 235 handle_op
osd_op(client845990.0:50 rb.0.1d6.000000000018 [write 0~1051648]
3.36c0 RETRY) v1 in pg[3.c0( v 220'49392 (174'49389,220'49392] n=211
ec=2 les=235 234/234/234) [2] r=0 lcod 0'0 mlcod 0'0 active+clean]
10.08.10_17:40:03.676253 7fdc2b3e3710 osd2 235 enqueue_op waiting for
pending_ops 11 to drop to 10
10.08.10_17:40:03.676280 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] get_snapset_context rb.0.1d6.00000000000e 0 ->
1
10.08.10_17:40:03.676318 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] get_object_context rb.0.1d6.00000000000e/head
read rb.0.1d6.00000000000e/head(0'0 unknown0.0:0
wrlock_by=unknown0.0:0)
10.08.10_17:40:03.676369 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] find_object_context rb.0.1d6.00000000000e
@head
10.08.10_17:40:03.676403 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_op mode is idle(wr=0)
10.08.10_17:40:03.676429 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_op mode now rmw(wr=0)
10.08.10_17:40:03.676460 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_op rb.0.1d6.00000000000e/head [write
0~1315841] ov 0'0 av 235'52010 snapc 0=[] snapset 0=[]:[]
10.08.10_17:40:03.676495 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_osd_op rb.0.1d6.00000000000e/head [write
0~1315841]
10.08.10_17:40:03.676528 7fdc294df710 osd2 235 pg[3.f2( v 174'52009
(174'52008,174'52009] n=204 ec=2 les=235 234/234/234) [2] r=0 lcod 0'0
mlcod 0'0 active+clean] do_osd_op  write 0~1315841
terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'


2010/8/10 Christian Brunner <chb@muc.de>:
> Hi,
>
> we have a problem with one cosd instance (v0.21) in our test
> environment: It is dying 3 seconds after start with the message:
>
> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'
>
> When I run with debugging on, the output looks like this:
>
> [...]
> 10.08.10_17:25:33.187255 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).writer: state = 2 policy.server=1
> 10.08.10_17:25:33.187331 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).writer encoding 1 0x7fac980ff6e0 osd_map(210,210) v1
> 10.08.10_17:25:33.187396 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).writer sending 1 0x7fac980ff6e0
> 10.08.10_17:25:33.187448 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).write_message 0x7fac980ff6e0
> 10.08.10_17:25:33.187522 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).writer: state = 2 policy.server=1
> 10.08.10_17:25:33.187559 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> l=1).writer sleeping
> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'
> 10.08.10_17:25:33.188116 7faca9b34710 -- 10.165.254.22:6800/2773 -->
> client711674 10.165.254.131:0/1510 -- osd_map(210,210) v1 -- ?+0
> 0x7fac98002260
> 10.08.10_17:25:33.188162 7faca9b34710 -- 10.165.254.22:6800/2773
> submit_message osd_map(210,210) v1 remote, 10.165.254.131:0/1510, have
> pipe.
> Aborted
>
> Any ideas?
>
> Thank you,
>
> Christian
>
