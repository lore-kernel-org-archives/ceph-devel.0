From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 16:36:12 +0200
Message-ID: <1602699.FNKvkklAzR@pc10>
References: <4FDB9FBB.9000807@inktank.com> <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:34363 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932953Ab2FVOgO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 10:36:14 -0400
In-Reply-To: <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Am Montag, 18. Juni 2012, 10:00:32 schrieben Sie:
> On Fri, Jun 15, 2012 at 1:48 PM, Josh Durgin <josh.durgin@inktank.com> 
wrote:
> >    $ rbd unpreserve pool/image@snap
> >    Error unpreserving: child images rely on this image
> 
> UX nit: this should also say what image it found.
> 
> rbd: Cannot unpreserve: Still in use by pool2/image2

What if it's in use by a lot of images? Should it print them all, or should it 
print something like "Still in use by pool2/image2 and 50 others, use 
list_children to see them all"?

	Guido
