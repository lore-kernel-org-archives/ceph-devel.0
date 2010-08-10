From: Christian Brunner <chb@muc.de>
Subject: cosd dying after start
Date: Tue, 10 Aug 2010 17:39:33 +0200
Message-ID: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34033 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572Ab0HJPjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 11:39:35 -0400
Received: by wyb32 with SMTP id 32so833339wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Aug 2010 08:39:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we have a problem with one cosd instance (v0.21) in our test
environment: It is dying 3 seconds after start with the message:

terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'

When I run with debugging on, the output looks like this:

[...]
10.08.10_17:25:33.187255 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).writer: state = 2 policy.server=1
10.08.10_17:25:33.187331 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).writer encoding 1 0x7fac980ff6e0 osd_map(210,210) v1
10.08.10_17:25:33.187396 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).writer sending 1 0x7fac980ff6e0
10.08.10_17:25:33.187448 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).write_message 0x7fac980ff6e0
10.08.10_17:25:33.187522 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).writer: state = 2 policy.server=1
10.08.10_17:25:33.187559 7fac762e1710 -- 10.165.254.22:6800/2773 >>
10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
l=1).writer sleeping
terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'
10.08.10_17:25:33.188116 7faca9b34710 -- 10.165.254.22:6800/2773 -->
client711674 10.165.254.131:0/1510 -- osd_map(210,210) v1 -- ?+0
0x7fac98002260
10.08.10_17:25:33.188162 7faca9b34710 -- 10.165.254.22:6800/2773
submit_message osd_map(210,210) v1 remote, 10.165.254.131:0/1510, have
pipe.
Aborted

Any ideas?

Thank you,

Christian
