From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 00/11] rbd: another set of patches
Date: Thu, 06 Sep 2012 10:34:29 -0500
Message-ID: <5048C285.1030202@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57791 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab2IFPec (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 11:34:32 -0400
Received: by iahk25 with SMTP id k25so2176819iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 08:34:32 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/24/2012 11:26 AM, Alex Elder wrote:
> I keep moving simple and simplifying patches to the front of
> my patch queue.  This is my latest set of things that are
> ready to get reviewed and committed.
> 
> 					-Alex

I'm about to send updates to two patches in this series, based
on comments from Yehuda's review.  I'm not going to re-send the
entire series.

Updated are patches 03 and 06.  I also am still awaiting
confirmation of review for patch 05 (which has not changed
and I am not re-sending).

					-Alex

> 
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

