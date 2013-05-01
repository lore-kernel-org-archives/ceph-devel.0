From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] rbd: only set up Linux files for mapped devices
Date: Tue, 30 Apr 2013 18:15:03 -0700
Message-ID: <51806C97.5030707@inktank.com>
References: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55847 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347Ab3EABP6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 21:15:58 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so525280pbc.26
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 18:15:58 -0700 (PDT)
In-Reply-To: <517EB4F0.1070607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/29/2013 10:59 AM, Alex Elder wrote:
> This series does a few more things to separate the
> ceph and Linux side of rbd device initialization,
> and to make sure things get cleaned up in a sane
> way when errors occur.  The last patch makes it so
> only the rbd image getting mapped has Linux device
> and sysfs stuff associated with them.  The parent
> rbd devices for layered images never needed this
> stuff, and things have now been rearranged such
> that we can do away with that.
>
> These patches are available in the ceph-client git
> repository in the branch "review/wip-rbd-cleanup-5".
>
> 					-Alex
> [PATCH 1/5] rbd: drop module later
> [PATCH 2/5] rbd: don't destroy rbd_dev in device release function
> [PATCH 3/5] rbd: define rbd_dev_unprobe()
> [PATCH 4/5] rbd: don't have device release destroy rbd_dev
> [PATCH 5/5] rbd: set up devices only for mapped images

A couple notes on 3/5, otherwise looks good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

