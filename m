From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0]  rbd: layered writes
Date: Fri, 19 Apr 2013 17:52:18 -0500
Message-ID: <5171CAA2.7000802@inktank.com>
References: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:56132 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965046Ab3DSWwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:52:22 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so3922821iah.31
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:52:21 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm4907562igb.10.2013.04.19.15.52.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 15:52:20 -0700 (PDT)
In-Reply-To: <5171C963.2050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 04/19/2013 05:46 PM, Alex Elder wrote:
> This set of patches culminates in providing layered
> write functionality for rbd clone images.  Until the
> feature bits get enabled, most of this code is not
> yet activated.  But it has been tested and it's
> ready for review.  The feature will be enabled soon,
> after a few more things get cleaned up to prepare
> for it.

These patches are available in the "review/wip-copyup"
of the ceph-client git repository.  They are based on
the branch "review/wip-4679-3" found there.

					-Alex
> 
> 					-Alex
> 
> [PATCH] libceph: fix two messenger bugs
>     Two bugs, two improvements.
> 
> [PATCH] libceph: support pages for class request data
>     This just defines a function that allows a page array
>     to be specified for the data to be written by an
>     object class method.
> 
> [PATCH 1/4] rbd: define separate read and write format funcs
> [PATCH 2/4] rbd: encapsulate submission of image object requests
> [PATCH 3/4] rbd: define zero_pages()
> [PATCH 4/4] rbd: support page array image requests
>     The first two of these are just cleanups.  The second two
>     add some functionality to allow image requests to use
>     page arrays for their object data.
> 
> [PATCH 1/2] rbd: implement full object parent reads
> [PATCH 2/2] rbd: issue a copyup for layered writes
>     These last two finally implement the layered copyup
>     functionality.  The first is sort of a half step, to
>     break up the review into smaller pieces.
> 

