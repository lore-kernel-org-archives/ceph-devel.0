From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: ceph-mds crash v12.0.3
Date: Thu, 15 Jun 2017 15:10:35 +0800
Message-ID: <CAAM7YAmGGoFXpqUNOtJnEt1qvcW4dUeie8y+mrM=5RYuJyrbCQ@mail.gmail.com>
References: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c05cdce8b03c90551fa5d9a"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34979 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdFOHKh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 03:10:37 -0400
Received: by mail-ua0-f169.google.com with SMTP id q15so3353384uaa.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 00:10:37 -0700 (PDT)
In-Reply-To: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jake Grimmett <jog@mrc-lmb.cam.ac.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jake Grimmett <jake.grimmett@gmail.com>

--94eb2c05cdce8b03c90551fa5d9a
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 14, 2017 at 11:49 PM, Jake Grimmett <jog@mrc-lmb.cam.ac.uk> wrote:
> Dear All,
>
> Sorry, but I need to add +1 to the mds crash reports with ceph
> 12.0.3-1507-g52f0deb
>
> This happened to me after updating from 12.0.2
> All was fairly OK for a few hours, I/O  around 500MB/s, then both MDS
> servers crashed, and have not worked since.
>
> The two MDS servers, are active:standby, both now crash immediately
> after being started.
>
> This cluster has been upgraded from Kraken, through several Luminous
> versions, so I did a clean install of SL7.3 on one MDS server, and still
> have crashes on this machine.
>
> Cluster has 40 x 8TB drives (EC 4+1), with dual replicated NVME
> providing a hotpool to drive the Cephfs layer. df -h /cephfs is/was
> 200TB. All OSD's are bluestore, and were generated on Luminous.
>
> I enabled snapshots a few days ago, and keep 144 snapshots (one taken
> every 10 minutes, each is kept for 24 hours only) about 30TB is copied
> into the fs each day. If snapshots caused the crash, I can regenerate
> the data, but they are very useful.
>
> One MDS gave this log...
>
> <http://www.mrc-lmb.cam.ac.uk/jog/ceph-mds.cephfs1.log>

It is a snapshot related bug. The Attached patch should prevent mds
from crashing.
Next time you restart mds, please set debug_mds=10 and upload the log.

Regards
Yan, Zheng

>
> many thanks for any suggestions, and it's great to see the experimental
> flag removed from bluestore!
>
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--94eb2c05cdce8b03c90551fa5d9a
Content-Type: application/octet-stream; name="ceph-mds.patch"
Content-Disposition: attachment; filename="ceph-mds.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j3y2zv4f0

ZGlmZiAtLWdpdCBhL3NyYy9tZHMvam91cm5hbC5jYyBiL3NyYy9tZHMvam91cm5hbC5jYwppbmRl
eCBmNzU3MGM2Li4xNzU0NjA4IDEwMDY0NAotLS0gYS9zcmMvbWRzL2pvdXJuYWwuY2MKKysrIGIv
c3JjL21kcy9qb3VybmFsLmNjCkBAIC0yMjA0LDcgKzIyMDQsNyBAQCB2b2lkIEVPcGVuOjpyZXBs
YXkoTURTUmFuayAqbWRzKQogICAgIENJbm9kZSAqaW4gPSBtZHMtPm1kY2FjaGUtPmdldF9pbm9k
ZSh2aW5vKTsKICAgICBpZiAoIWluKSB7CiAgICAgICBkb3V0KDApIDw8ICJFT3Blbi5yZXBsYXkg
aW5vICIgPDwgdmlubyA8PCAiIG5vdCBpbiBtZXRhYmxvYiIgPDwgZGVuZGw7Ci0gICAgICBhc3Nl
cnQoaW4pOworICAgICAgY29udGludWU7CiAgICAgfQogICAgIF9zZWdtZW50LT5vcGVuX2ZpbGVz
LnB1c2hfYmFjaygmaW4tPml0ZW1fb3Blbl9maWxlKTsKICAgfQo=
--94eb2c05cdce8b03c90551fa5d9a--
