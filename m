From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/4] rbd: don't use snapc->seq that way
Date: Thu, 19 Jul 2012 14:02:41 -0700
Message-ID: <500875F1.2030303@inktank.com>
References: <50083F65.5030104@inktank.com> <50083FC5.3050902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49694 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2GSVCp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:02:45 -0400
Received: by pbbrp8 with SMTP id rp8so4935549pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:02:45 -0700 (PDT)
In-Reply-To: <50083FC5.3050902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/19/2012 10:11 AM, Alex Elder wrote:
> We now use rbd_dev->snap_id to record the snapshot id--using
> the special value SNAP_NONE to indicate the rbd_dev is not mapping
> a snapshot at all.

That's CEPH_NOSNAP, not SNAP_NONE, right? In any case,

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
