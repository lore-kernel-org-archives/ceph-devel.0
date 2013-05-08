From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/7] rbd: use common code for probe and refresh
Date: Wed, 08 May 2013 12:29:12 -0700
Message-ID: <518AA788.7000801@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:62196 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3EHTaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 15:30:19 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so1161088dae.2
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 12:30:18 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/06/2013 06:51 PM, Alex Elder wrote:
> This is some work I had nearly done a long time ago.  It didn't even
> have a bug associated with it.  I resurrected it over the weekend
> and ported it to the new code.
>
> It's basically cleanup though.  For format 1 rbd images, when
> probing an image, header information for it is read in and
> translated directly into the rbd_dev->header structure.
>
> For an image refresh, instead, we use a stack structure to
> hold the translated header, and then in a second step we
> copy that into rbd_dev->header.
>
> This series gets rid of the local variable, and always just
> puts things directly into rbd_dev->header.  It also simplifies
> probe and refresh for both format 1 and format 2, using a
> common rbd_dev_vX_header_info() function for both purposes.
>
> This set of patches, as well as the two single patches
> and series of six I just posted, are available in the
> "review/wip-rbd-cleanup-1" branch of the ceph-client git
> repository.
>
> 					-Alex
>
> [PATCH 1/7] rbd: set the mapping size and features later
> [PATCH 2/7] rbd: zero format 1 header structure earlier
> [PATCH 3/7] rbd: refactor rbd_header_from_disk()
> [PATCH 4/7] rbd: update in-core header directly
> [PATCH 5/7] rbd: simplify rbd_dev_v1_probe()
> [PATCH 6/7] rbd: get rid of trivial v1 header wrappers
> [PATCH 7/7] rbd: define rbd_dev_v1_header_info()

These all look good.
The last one leaves the only call to rbd_dev_v2_parent_info() in
rbd_dev_v2_header_onetime(), but I'm guessing you already moved it
in your upcoming flatten-handling patches.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
