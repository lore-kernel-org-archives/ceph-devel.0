From: Sage Weil <sweil@redhat.com>
Subject: Re: [wip-addr-features] make sure I am doing the right thing
Date: Mon, 16 May 2016 04:50:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605160446150.30956@cpach.fuggernut.com>
References: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46363 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194AbcEPIuZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 May 2016 04:50:25 -0400
In-Reply-To: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junwang Zhao <zhjwpku@gmail.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Junwang,

On Mon, 16 May 2016, Junwang Zhao wrote:
> Hi Sage, Haomai,
> 
> I am working on the require-features-patch, I use 'make' to see the conflicts,
> and change the code to fit the required-feature-patch, [1] is a huge patch
> that I am still working on, it has not been finished. I really need to check
> with you whether I am doing it right, since it seems the errors are endless.
> 
> There are some comments where I am not sure in the patch, like 'not sure'.

I skimmed through this and it looks mostly right, but I see a few cases 
where features aren't needed, e.g. cls_refcount_get in 
cls_refcount_client.cc (there's no addr being encoded in 
cls_refcount_get_op, so no need to make the encoding featureful).
 
> I didn't split this huge patch into small ones, I am not sure is that a 
> must, if yes, I will split it into small ones.

The end result needs to be a series of small patches, but that doesn't 
have to happen right away.  I think it might be useful to do a few small 
sets of changes first just to show what the goal is, though.

I will take the patch below and pull a few sample changes out so you can 
see.  Traveling at the moment, but I'll have something pushed today (that 
is also rebased on top of the latest wip-addr-cleanup branch).

Are you on IRC in #ceph-devel?  What is your nick?

Thanks!
sage

