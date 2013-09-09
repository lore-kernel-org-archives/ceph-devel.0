From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 0/5] fix shutdown races and snapshot error handling
Date: Mon, 09 Sep 2013 08:50:58 -0500
Message-ID: <522DD242.6060200@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39276 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3IINux (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 09:50:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so6416255oag.5
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 06:50:53 -0700 (PDT)
In-Reply-To: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 02:16 AM, Josh Durgin wrote:
> Patches 1-3 fix races between device removal and notify processing.
> 
> Patch 2 has an improved summary, fixes reference counting, and
> renames the function as suggested by Alex.
> 
> Patch 3 is a reworked and simplified version that uses the existing
> rbd_dev->flags and lock instead of adding new ones. It also restricts
> where it holds the lock to avoid an inversion with bdev->lock.

I found all but this one were ready to go.

If you can, please just pull this patch out to be resolved
separately.  There's no sense in holding up the other four
until this one is perfect.

Nice work.

					-Alex

> Patch 4 is the same.
> 
> Patch 5 fixes an inconsistency noticed by Alex in his review of patch 4.
> 
> Josh Durgin (5):
>   rbd: complete notifies before cleaning up osd_client and rbd_dev
>   rbd: make rbd_obj_notify_ack() synchronous
>   rbd: fix use-after free of rbd_dev->disk
>   rbd: ignore unmapped snapshots that no longer exist
>   rbd: fix error handling from rbd_snap_name()
> 
>  drivers/block/rbd.c |   71 ++++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 53 insertions(+), 18 deletions(-)
> 

