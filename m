From: Sage Weil <sage@newdream.net>
Subject: RE: Implementing bitmap based space allocator for BlueStore
Date: Tue, 10 May 2016 08:37:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605100827490.15518@cpach.fuggernut.com>
References: <BLUPR0201MB1809B0B51FF640A10869E0A285790@BLUPR0201MB1809.namprd02.prod.outlook.com> <CY1PR0201MB1820941DBBE1FB7927F42D2185710@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47889 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcEJMhQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 08:37:16 -0400
In-Reply-To: <CY1PR0201MB1820941DBBE1FB7927F42D2185710@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ramesh!

On Tue, 10 May 2016, Ramesh Chander wrote:
> Hi Ceph Developers,
> 
> This is request to review PR:
> 
> https://github.com/ceph/ceph/pull/9031
> 
> is for below mentioned bitmap based allocator in BlueStore.
> 
> In short please review the code.
> 
> 
> Details: (same mentioned in pull request)
> ------------------------------------------------
> This is Bitmap based allocator for BlueStore.
> Motivation:
> 1. Reduction of memory by using just one bit for single block (as compared to 8 + 8 byes in case of extent based allocator).
> 2. Concurrent allocations via multiple threads.
> 
> It exposes mainly these interfaces:
> 1. Allocate contiguous blocks.
> 2. Allocate non-contiguous blocks.

Note that we only need one more, more like #2; there isn't anywhere in the 
code that needs a single contiguous allocation. The only exception is that 
the allocate is expected to respect the currently configured 
min_alloc_size.  I think this means the dueling alloc_blocks vs 
alloc_blocks_dis implementations can be collapsed into one that takes a 
alloc_unit and desired size for the allocation.

I did a quick high-level review just for the integration points and style; 
see PR comments.

Thanks!
sage
