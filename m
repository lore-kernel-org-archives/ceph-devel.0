From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Fri, 16 Oct 2015 13:09:53 +0200
Message-ID: <CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com>
References: <201510151850.48348.ronny.hegewald@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32797 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbbJPLJz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 07:09:55 -0400
Received: by wijp11 with SMTP id p11so5089622wij.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 04:09:53 -0700 (PDT)
In-Reply-To: <201510151850.48348.ronny.hegewald@online.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ronny Hegewald <ronny.hegewald@online.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Thu, Oct 15, 2015 at 8:50 PM, Ronny Hegewald
<ronny.hegewald@online.de> wrote:
> rbd requires stable pages, as it performs a crc of the page data before they
> are send to the OSDs.
>
> But since kernel 3.9 (patch 1d1d1a767206fbe5d4c69493b7e6d2a8d08cc0a0 "mm: only
> enforce stable page writes if the backing device requires it") it is not
> assumed anymore that block devices require stable pages.
>
> This patch sets the necessary flag to get stable pages back for rbd.
>
> In a ceph installation that provides multiple ext4 formatted rbd devices "bad
> crc" messages appeared regularly (ca 1 message every 1-2 minutes on every OSD
> that provided the data for the rbd) in the OSD-logs before this patch. After
> this patch this messages are pretty much gone (only ca 1-2 / month / OSD).
>
> This patch seems also to fix data and filesystem corruptions on ext4 formatted
> rbd devices that were previously seen on pretty much a daily basis. But it is
> unknown at the moment why this is the case.
>
> Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>
>
> ---
>
> That the mentioned corruption issue is really affected through this patch
> i could verify through the system logs. Since installation of this patch i
> have seen only a 2-3 filesystem corruptions. But these could be also just
> leftovers of corruptions that happened before the installation but got noticed
> from ext4 only later after the patched kernel was installed. This seems even
> more likely as i have seen not a single data corruption issue since the patch.
>
> --- linux/drivers/block/rbd.c.org       2015-10-07 01:32:55.906666667 +0000
> +++ linux/drivers/block/rbd.c   2015-09-04 02:21:22.349999999 +0000
> @@ -3786,6 +3786,7 @@
>
>         blk_queue_merge_bvec(q, rbd_merge_bvec);
>         disk->queue = q;
> +       disk->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
>
>         q->queuedata = rbd_dev;

Hmm...  On the one hand, yes, we do compute CRCs, but that's optional,
so enabling this unconditionally is probably too harsh.  OTOH we are
talking to the network, which means all sorts of delays, retransmission
issues, etc, so I wonder how exactly "unstable" pages behave when, say,
added to an skb - you can't write anything to a page until networking
is fully done with it and expect it to work.  It's particularly
alarming that you've seen corruptions.

Currently the only users of this flag are block integrity stuff and
md-raid5, which makes me wonder what iscsi, nfs and others do in this
area.  There's an old ticket on this topic somewhere on the tracker, so
I'll need to research this.  Thanks for bringing this up!

                Ilya
