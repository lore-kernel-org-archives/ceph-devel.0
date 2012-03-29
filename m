From: Sage Weil <sage@newdream.net>
Subject: Re: Question about the implementation of bucket_straw_choose in
 src/crush/mapper.c
Date: Thu, 29 Mar 2012 08:52:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203290850020.32695@cobra.newdream.net>
References: <CALwGbP+0xWC=-zZYdx_D6ikgEq6NRYYfweEDn7z5WceCypPRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47323 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608Ab2C2Pw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Mar 2012 11:52:57 -0400
In-Reply-To: <CALwGbP+0xWC=-zZYdx_D6ikgEq6NRYYfweEDn7z5WceCypPRNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 29 Mar 2012,  wrote:
> Hi everyone, i'm proceeding reading source code of crush
> 
> i'm reading src/crush/mapper.c which is describing the core
> implementation of crush alg.
> in reading function bucket_straw_choose, i compare the implementation
> with the idea written in the thesis and have some problem
> understanding it.
> 
> in the thesis, it said that the length of straw should multiply the
> weight of bucket item so that heavier items are more likely to be
> selected.
> in bucket_straw_choose, i see bucket->straws multiplying the hash value only.
> 
> next, i referred to crush.h to take a look at the data structure of
> crush_bucket_straw, and found two members named 'straws' and
> 'item_weights'.
> 
> i just don't know whether 'weight' and 'straw' in the implementation
> mean the same thing as in thesis. if so, why item_weights is not used
> in bucket_straw_choose.

The length of the straw is not directly proportional to the weight, and is 
non-trivial.  When the bucket is built/adjusted, the straw lengths are 
calculated so that the actual choose/placement calculation is fast and 
simple.

See crush_calc_straw() in src/crush/builder.c for the straw calculation.  
I needed to draw a picture for it to make any sense.

sage
