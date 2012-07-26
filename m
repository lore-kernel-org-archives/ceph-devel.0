From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 00/12] rbd: cleanup series
Date: Thu, 26 Jul 2012 13:22:37 -0500
Message-ID: <50118AED.8070200@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46481 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2GZSWj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:22:39 -0400
Received: by ghrr11 with SMTP id r11so2309742ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:22:39 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 07/19/2012 03:58 PM, Alex Elder wrote:
> This series includes a bunch of relatively small cleanups.
> They're grouped a bit below, but they apply together in
> this sequence and the later ones may have dependencies on
> those earlier in the series.

None of these were reviewed, so I'm re-submitting them.  I
have a few more to add, and may have rearranged the order
a bit since last time.  In any case, if you intend to review
anything please disregard this series and look at the patches
I'm about to post instead.

					-Alex


> Summaries:
> [PATCH 01/12] rbd: drop extra header_rwsem init
> [PATCH 02/12] rbd: simplify __rbd_remove_all_snaps()
> [PATCH 03/12] rbd: clean up a few dout() calls
> [PATCH 04/12] ceph: define snap counts as u32 everywhere
>     These four are very simple and straightforward cleanups.
> 
> [PATCH 05/12] rbd: snapc is unused in rbd_req_sync_read()
> [PATCH 06/12] rbd: drop rbd_header_from_disk() gfp_flags parameter
> [PATCH 07/12] rbd: drop rbd_dev parameter in snap functions
> [PATCH 08/12] rbd: drop rbd_req_sync_exec() "ver" parameter
>     These four each drop an unused argument from a function.
> 
> [PATCH 09/12] rbd: have __rbd_add_snap_dev() return a pointer
> [PATCH 10/12] rbd: make rbd_create_rw_ops() return a pointer
>     These two each change a function so it returns a pointer
>     rather than filling in the address of a provided pointer.
> 
> [PATCH 11/12] rbd: always pass ops array to rbd_req_sync_op()
> [PATCH 12/12] rbd: fixes in rbd_header_from_disk()
>     These comprise slightly more involved refactoring of the
>     code, but as with the rest of the patches in this series,
>     there should be no functional difference as a result.
> 
> 					-Alex
> 

