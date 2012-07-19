From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/4] rbd: don't use snapc->seq that way
Date: Thu, 19 Jul 2012 16:10:13 -0500
Message-ID: <500877B5.3030306@inktank.com>
References: <50083F65.5030104@inktank.com> <50083FC5.3050902@inktank.com> <500875F1.2030303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43022 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2GSVKP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:10:15 -0400
Received: by yenl2 with SMTP id l2so3304312yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:10:15 -0700 (PDT)
In-Reply-To: <500875F1.2030303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/19/2012 04:02 PM, Josh Durgin wrote:
> On 07/19/2012 10:11 AM, Alex Elder wrote:
>> We now use rbd_dev->snap_id to record the snapshot id--using
>> the special value SNAP_NONE to indicate the rbd_dev is not mapping
>> a snapshot at all.
> 
> That's CEPH_NOSNAP, not SNAP_NONE, right? In any case,

Yes.  I'll fix the description before I commit it...

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> 

