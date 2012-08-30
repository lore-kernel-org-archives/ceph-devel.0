From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 00/11] rbd: another set of patches
Date: Thu, 30 Aug 2012 07:32:43 -0500
Message-ID: <503F5D6B.9030509@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53106 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2H3Mcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 08:32:47 -0400
Received: by yenl14 with SMTP id l14so318585yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 05:32:46 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/24/2012 11:26 AM, Alex Elder wrote:
> I keep moving simple and simplifying patches to the front of
> my patch queue.  This is my latest set of things that are
> ready to get reviewed and committed.

Anyone have time to review these?  They're mostly very simple.
Thanks.

					-Alex

> [PATCH 01/11] rbd: handle locking inside __rbd_client_find()
>     This simplifies a little code.
> [PATCH 02/11] rbd: don't over-allocate space for object prefix
>     Don't allocate the max required space for the object prefix.
>     This also ensures that the object prefix is either terminated
>     with '\0' or else is maximally-sized.
> [PATCH 03/11] rbd: kill incore snap_names_len
>     Eliminate an unnecessary field in struct rbd_image_header.
> [PATCH 04/11] rbd: more cleanup in rbd_header_from_disk()
>     Rearrange some code, for better logical grouping.
> [PATCH 05/11] rbd: move rbd_opts to struct rbd_device
>     Tie rbd-specific options to the rbd_device, not the client.
> [PATCH 06/11] rbd: add read_only rbd map option
> [PATCH 07/11] rbd: kill notify_timeout option
>     These two were done together, in this order, to preserve the
>     argument parsing code.  The first adds the ability to map an
>     rbd image read-only.  The second eliminates the only other
>     rbd option, which is otherwise unused.
> [PATCH 08/11] rbd: bio_chain_clone() cleanups
>     Simple refactoring.
> [PATCH 09/11] rbd: drop needless test in rbd_rq_fn()
>     Trivial.
> [PATCH 10/11] rbd: check for overflow in rbd_get_num_segments()
>     Make sure we don't exceed 64-bit maximum when adding offset
>     and length.
> [PATCH 11/11] rbd: split up rbd_get_segment()
>     Refactor rbd_get_segment() into three separate functions,
>     which return a segment name, offset, and length.
> 

