From: huang jun <hjwsm1989@gmail.com>
Subject: bad CRC in data error on ARM
Date: Fri, 15 May 2015 07:51:46 +0800
Message-ID: <CABAwU-Y8-fV6cFza0oHt8yJ4+-nYs51b0rQ5qDqQCfpJUk2kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36575 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161102AbbENXvr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 19:51:47 -0400
Received: by lagv1 with SMTP id v1so92384461lag.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 16:51:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all

We run ceph cluster on ARM platform (arm64, linux kernel 3.14, OS
ubuntu 14.10), and use "dd if=/dev/zero of=/mnt/test bs=4M count=125"
to write data.  On the osd side, we got bad data CRC error.

The kclient log: (tid=6)
May 14 17:21:08 node103 kernel: [  180.194312] CPU[0] libceph:
send_request ffffffc8d252f000 tid-6 to osd0 flags 36 pg 1.9aae829f req
data size is 4194304
May 14 17:21:08 node103 kernel: [  180.194316] CPU[0] libceph: tid-6
----- ffffffc0702f66c8 to osd0 42=osd_op len 197+0+4194304 -----
libceph: tid-6 front_crc is 388648745 middle_crc is 0 data_crc is 3036014994

The OSD-0 log:
2015-05-13 08:12:50.049345 7f378d8d8700  0 seq  3 tid 6 front_len 197
mid_len 0 data_len 4194304
2015-05-13 08:12:50.049348 7f378d8d8700  0 crc in front 388648745 exp 388648745
2015-05-13 08:12:50.049395 7f378d8d8700  0 crc in middle 0 exp 0
2015-05-13 08:12:50.049964 7f378d8d8700  0 crc in data 0 exp 3036014994
2015-05-13 08:12:50.050234 7f378d8d8700  0 bad crc in data 0 != exp 3036014994

some considerations:
1) we use ceph 0.80.7 realse version and compile it on ARM, did this
works? or  does ceph's code has ARM branch?

2) as we have write 125 objects, only few of them report CRC error,
and the right object's data_crc is 0 both on osd and kclient. the
wrong object's data_crc is not 0 on kclient, but osd calculate result
0. the object data came from /dev/zero, i think the data_crc should be
0, am i right?

-- 
thanks
huangjun
