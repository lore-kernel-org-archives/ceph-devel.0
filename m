From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 16:41:55 +0200
Message-ID: <13965457.S14qi4B5iq@pc10>
References: <4FDB9FBB.9000807@inktank.com> <4FDFB4A4.1080107@inktank.com> <loom.20120622T035754-492@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:53062 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762247Ab2FVOl4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 10:41:56 -0400
In-Reply-To: <loom.20120622T035754-492@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

Am Freitag, 22. Juni 2012, 02:02:38 schrieb Alex Elsayed:
> Dan Mick <dan.mick <at> inktank.com> writes:
> > On 06/18/2012 11:01 AM, Sage Weil wrote:
> > > On Mon, 18 Jun 2012, Josh Durgin wrote:
> > >>>>      $ rbd copyup pool2/child1
> > 
> > "disown" and "adopt"?  :)  (actually I started as a joke, but really I
> > kinda like that; fits with the parent-child name)
> 
> The issue I see with that is that the argument refers to the child rather
> than the parent, so it doesn't match. I personally like 'unshare' since
> it'll also work in the dedup case, but if we stick with the parent/child
> terminology 'emancipate' might work (although it lacks a good reverse).

AFAIK the word started in ancient Rome as meaning to release slaves into 
freedom, so I suppose the opposite would be enslave?

	Guido
