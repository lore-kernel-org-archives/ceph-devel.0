From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/3] __remove_osd() vs lingering requests
Date: Wed, 05 Nov 2014 11:49:54 -0600
Message-ID: <545A6342.4000404@ieee.org>
References: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35356 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaKERt4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 12:49:56 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so9962417iga.9
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 09:49:55 -0800 (PST)
In-Reply-To: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 11/05/2014 11:33 AM, Ilya Dryomov wrote:
> Hello,
> 
> These are fixes for the problem I found while trying to reproduce
> recently reopened http://tracker.ceph.com/issues/5429.  I'm pretty sure
> this is what was reported in http://tracker.ceph.com/issues/8568 too.
> The exact BUG_ON() it points to is no longer there, but I checked with
> an older kernel and the reproducer I have for this triggered it.
> 
> Thanks,
> 
>                 Ilya

All three of these look good to me.  The interactions with
these lists has always been a bit too tricky; you've done a
lot to make sense of them.

And I'm sure there are other BUG_ON() (or rbd_assert()) calls
that can be tamed--either removed, changed to warnings, or
changed to simply return errors where possible.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> 
> Ilya Dryomov (3):
>   libceph: unlink from o_linger_requests when clearing r_osd
>   libceph: clear r_req_lru_item in __unregister_linger_request()
>   libceph: change from BUG to WARN for __remove_osd() asserts
> 
>  net/ceph/osd_client.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

