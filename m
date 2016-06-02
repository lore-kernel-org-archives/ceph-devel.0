From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: rgw: object null version delete
Date: Thu, 2 Jun 2016 17:21:34 +0800
Message-ID: <574FFA9E.7060100@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m109-177.yeah.net ([123.58.177.109]:44056 "EHLO
	m109-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbcFBJVp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 05:21:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Javen Wu <javen.wu@xtaotech.com>

Hello,

Radosgw version Hammer (0.94.5) can not delete a null version key which 
created before
turn on bucket versioning[1]. And its value can still be accessed. In 
order to
solve this problem, I applied the changes of [2]. But sometimes the test 
case
can pass, sometimes not.

For all my osd daemons, I set breakpoints at 
rgw_bucket_unlink_instance/rgw_bucket_read_olh_log.
I noticed that a failed case's unlink/read_olh_log requests never 
reached osd side.

How to fix this problem? Any suggestions?

Thx,

joseph

ref:

[1] How to reproduce the bug:

     - create bucket
     - put key AAA
     - turn on bucket versioning
     - read AAA // expect 404
     - delete AAA
     - delete bucket

[2] hammer: rgw: convert plain object to versioned (with null version) 
when removing #8755 
https://github.com/ceph/ceph/pull/8755/commits/12cf255eb2ae666afb29df40d61de754257f7f28?diff=split

[3] bilog

# radosgw-admin bilog list --bucket=4e00f488-28a1-11e6-a9e6-002590ae43ca 
--cluster rgwltt
[
     {
         "op_id": "00000000001.77.2",
         "op_tag": "rgwltt-rgwltt.6547.113",
         "op": "write",
         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
         "instance": "",
         "state": "pending",
         "index_ver": 1,
         "timestamp": "0.000000",
         "ver": {
             "pool": -1,
             "epoch": 0
         },
         "versioned": false
     },
     {
         "op_id": "00000000002.78.3",
         "op_tag": "rgwltt-rgwltt.6547.113",
         "op": "write",
         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
         "instance": "",
         "state": "complete",
         "index_ver": 2,
         "timestamp": "2016-06-02 09:06:34.000000Z",
         "ver": {
             "pool": 15,
             "epoch": 17
         },
         "versioned": false
     },
     {
         "op_id": "00000000003.79.5",
         "op_tag": "00000000574ff71azhrp4zx1y11qcsv2",
         "op": "unlink_instance",
         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
         "instance": "",
         "state": "complete",
         "index_ver": 3,
         "timestamp": "2016-06-02 09:06:34.787122Z",
         "ver": {
             "pool": -1,
             "epoch": 2
         },
         "versioned": true
     },
     {
         "op_id": "00000000004.80.5",
         "op_tag": "00000000574ff71cgeeopd12arjscnds",
         "op": "unlink_instance",
         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
         "instance": "",
         "state": "complete",
         "index_ver": 4,
         "timestamp": "2016-06-02 09:06:36.760707Z",
         "ver": {
             "pool": -1,
             "epoch": 3
         },
         "versioned": true
     }

]


