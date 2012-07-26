From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/6] ceph: simple cleanups (mostly rbd)
Date: Thu, 26 Jul 2012 12:31:06 -0700
Message-ID: <50119AFA.8080409@inktank.com>
References: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47257 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab2GZTbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:31:10 -0400
Received: by pbbrp8 with SMTP id rp8so3671033pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:31:09 -0700 (PDT)
In-Reply-To: <50118F33.7080502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 11:40 AM, Alex Elder wrote:
> This series includes a set of fairly minor code cleanups in rbd.
> I won't bother summarizing them here.  They are all simple nad
> their descriptions ought to be sufficient.
>
> 					-Alex
>
> [PATCH 1/6] rbd: drop extra header_rwsem init
> [PATCH 2/6] rbd: simplify __rbd_remove_all_snaps()
> [PATCH 3/6] rbd: clean up a few dout() calls
> [PATCH 4/6] ceph: define snap counts as u32 everywhere
> [PATCH 5/6] rbd: encapsulate header validity test
> [PATCH 6/6] rbd: rename rbd_device->id

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

It looks like there are still several dout() calls using
%lld when they should be %llu after these cleanups.
