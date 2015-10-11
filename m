From: Milosz Tanski <milosz@adfin.com>
Subject: MDS stuck in a crash loop
Date: Sun, 11 Oct 2015 13:09:17 -0400
Message-ID: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35952 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbJKRJT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 13:09:19 -0400
Received: by lbcao8 with SMTP id ao8so123410047lbc.3
        for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 10:09:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

About an hour ago my MDSs (primary and follower) started ping-pong
crashing with this message. I've spent about 30 minutes looking into
it but nothing yet.

This is from a 0.94.3 MDS

   -25> 2015-10-11 17:01:23.585220 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90496 300.0000e19b [write 2834681~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x3092aa00 con
0x4b3a3c0
   -24> 2015-10-11 17:01:23.585258 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244863415~1194 : EUpdate scatter_writebehind
[metablob 100014affd5, 2 dirs]
   -23> 2015-10-11 17:01:23.585291 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90497 300.0000e19b [write 2835895~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x3092a780 con
0x4b3a3c0
   -22> 2015-10-11 17:01:23.585329 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244864629~1194 : EUpdate scatter_writebehind
[metablob 100014b61f8, 2 dirs]
   -21> 2015-10-11 17:01:23.585363 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90498 300.0000e19b [write 2837109~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x3092a500 con
0x4b3a3c0
   -20> 2015-10-11 17:01:23.585401 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244865843~1194 : EUpdate scatter_writebehind
[metablob 100014b6b17, 2 dirs]
   -19> 2015-10-11 17:01:23.585435 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90499 300.0000e19b [write 2838323~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x3092a280 con
0x4b3a3c0
   -18> 2015-10-11 17:01:23.585473 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244867057~1194 : EUpdate scatter_writebehind
[metablob 100014ed078, 2 dirs]
   -17> 2015-10-11 17:01:23.585507 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90500 300.0000e19b [write 2839537~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x3092a000 con
0x4b3a3c0
   -16> 2015-10-11 17:01:23.585547 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244868271~1194 : EUpdate scatter_writebehind
[metablob 100014afa63, 2 dirs]
   -15> 2015-10-11 17:01:23.585581 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90501 300.0000e19b [write 2840751~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc3c00 con
0x4b3a3c0
   -14> 2015-10-11 17:01:23.585622 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244869485~1194 : EUpdate scatter_writebehind
[metablob 100014b1d83, 2 dirs]
   -13> 2015-10-11 17:01:23.585661 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90502 300.0000e19b [write 2841965~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc3980 con
0x4b3a3c0
   -12> 2015-10-11 17:01:23.585702 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244870699~1194 : EUpdate scatter_writebehind
[metablob 100014b2792, 2 dirs]
   -11> 2015-10-11 17:01:23.585736 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90503 300.0000e19b [write 2843179~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc3700 con
0x4b3a3c0
   -10> 2015-10-11 17:01:23.585775 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244871913~1194 : EUpdate scatter_writebehind
[metablob 100015e4b10, 2 dirs]
    -9> 2015-10-11 17:01:23.585807 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90504 300.0000e19b [write 2844393~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc3480 con
0x4b3a3c0
    -8> 2015-10-11 17:01:23.585847 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244873127~1194 : EUpdate scatter_writebehind
[metablob 100016101d5, 2 dirs]
    -7> 2015-10-11 17:01:23.585883 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90505 300.0000e19b [write 2845607~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc3200 con
0x4b3a3c0
    -6> 2015-10-11 17:01:23.585923 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244874341~1194 : EUpdate scatter_writebehind
[metablob 10000000001, 2 dirs]
    -5> 2015-10-11 17:01:23.585956 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90506 300.0000e19b [write 2846821~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc2f80 con
0x4b3a3c0
    -4> 2015-10-11 17:01:23.585996 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244875555~1194 : EUpdate scatter_writebehind
[metablob 100015cb082, 2 dirs]
    -3> 2015-10-11 17:01:23.586029 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90507 300.0000e19b [write 2848035~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc2d00 con
0x4b3a3c0
    -2> 2015-10-11 17:01:23.590077 7fd4f1fa4700  5 mds.0.log
_submit_thread 242244876769~1194 : EUpdate scatter_writebehind
[metablob 100015cb8b1, 2 dirs]
    -1> 2015-10-11 17:01:23.590125 7fd4f1fa4700  1 --
10.0.5.31:6802/2743 --> 10.0.5.57:6804/32341 --
osd_op(mds.0.3800:90508 300.0000e19b [write 2849249~1214] 1.99e72fa5
ondisk+write+known_if_redirected e21243) v5 -- ?+0 0x46fc2a80 con
0x4b3a3c0
     0> 2015-10-11 17:01:23.596008 7fd4f52ad700 -1 mds/SessionMap.cc:
In function 'virtual void C_IO_SM_Save::finish(int)' thread
7fd4f52ad700 time 2015-10-11 17:01:23.594089
mds/SessionMap.cc: 120: FAILED assert(r == 0)

 ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0x94cc1b]
 2: /usr/bin/ceph-mds() [0x7c7df1]
 3: (MDSIOContextBase::complete(int)+0x81) [0x7c83b1]
 4: (Finisher::finisher_thread_entry()+0x1a0) [0x87f490]
 5: (()+0x8182) [0x7fd4fd031182]
 6: (clone()+0x6d) [0x7fd4fb7a047d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.


-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
