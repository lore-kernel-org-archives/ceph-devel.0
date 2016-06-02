From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: rgw: object null version delete
Date: Thu, 2 Jun 2016 15:17:19 +0200
Message-ID: <CABo9giRBZKOBER1p83gwNjA_6E20XJuGcmrpdn+QPPkNKNug=A@mail.gmail.com>
References: <574FFA9E.7060100@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37698 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbcFBNRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 09:17:21 -0400
Received: by mail-wm0-f42.google.com with SMTP id z87so69352344wmh.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 06:17:20 -0700 (PDT)
In-Reply-To: <574FFA9E.7060100@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yang Joseph <joseph.yang@xtaotech.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Javen Wu <javen.wu@xtaotech.com>

The fix is being backported to hammer:
http://tracker.ceph.com/issues/15254

On Thu, Jun 2, 2016 at 11:21 AM, Yang Joseph <joseph.yang@xtaotech.com> wrote:
> Hello,
>
> Radosgw version Hammer (0.94.5) can not delete a null version key which
> created before
> turn on bucket versioning[1]. And its value can still be accessed. In order
> to
> solve this problem, I applied the changes of [2]. But sometimes the test
> case
> can pass, sometimes not.
>
> For all my osd daemons, I set breakpoints at
> rgw_bucket_unlink_instance/rgw_bucket_read_olh_log.
> I noticed that a failed case's unlink/read_olh_log requests never reached
> osd side.
>
> How to fix this problem? Any suggestions?
>
> Thx,
>
> joseph
>
> ref:
>
> [1] How to reproduce the bug:
>
>     - create bucket
>     - put key AAA
>     - turn on bucket versioning
>     - read AAA // expect 404
>     - delete AAA
>     - delete bucket
>
> [2] hammer: rgw: convert plain object to versioned (with null version) when
> removing #8755
> https://github.com/ceph/ceph/pull/8755/commits/12cf255eb2ae666afb29df40d61de754257f7f28?diff=split
>
> [3] bilog
>
> # radosgw-admin bilog list --bucket=4e00f488-28a1-11e6-a9e6-002590ae43ca
> --cluster rgwltt
> [
>     {
>         "op_id": "00000000001.77.2",
>         "op_tag": "rgwltt-rgwltt.6547.113",
>         "op": "write",
>         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
>         "instance": "",
>         "state": "pending",
>         "index_ver": 1,
>         "timestamp": "0.000000",
>         "ver": {
>             "pool": -1,
>             "epoch": 0
>         },
>         "versioned": false
>     },
>     {
>         "op_id": "00000000002.78.3",
>         "op_tag": "rgwltt-rgwltt.6547.113",
>         "op": "write",
>         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
>         "instance": "",
>         "state": "complete",
>         "index_ver": 2,
>         "timestamp": "2016-06-02 09:06:34.000000Z",
>         "ver": {
>             "pool": 15,
>             "epoch": 17
>         },
>         "versioned": false
>     },
>     {
>         "op_id": "00000000003.79.5",
>         "op_tag": "00000000574ff71azhrp4zx1y11qcsv2",
>         "op": "unlink_instance",
>         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
>         "instance": "",
>         "state": "complete",
>         "index_ver": 3,
>         "timestamp": "2016-06-02 09:06:34.787122Z",
>         "ver": {
>             "pool": -1,
>             "epoch": 2
>         },
>         "versioned": true
>     },
>     {
>         "op_id": "00000000004.80.5",
>         "op_tag": "00000000574ff71cgeeopd12arjscnds",
>         "op": "unlink_instance",
>         "object": "4e1274ec-28a1-11e6-a9e6-002590ae43ca",
>         "instance": "",
>         "state": "complete",
>         "index_ver": 4,
>         "timestamp": "2016-06-02 09:06:36.760707Z",
>         "ver": {
>             "pool": -1,
>             "epoch": 3
>         },
>         "versioned": true
>     }
>
> ]
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
