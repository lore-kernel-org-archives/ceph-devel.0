From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 09:00:39 -0700
Message-ID: <CADvuQRFdpy4G=jQJ0_QnY9F3Q6kSM_MkftN3iD6fbwx8Zx+HKg@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com> <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
 <1602699.FNKvkklAzR@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51919 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab2FVQBA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 12:01:00 -0400
Received: by dady13 with SMTP id y13so2506292dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 09:01:00 -0700 (PDT)
In-Reply-To: <1602699.FNKvkklAzR@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 22, 2012 at 7:36 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
>> rbd: Cannot unpreserve: Still in use by pool2/image2
>
> What if it's in use by a lot of images? Should it print them all, or should it
> print something like "Still in use by pool2/image2 and 50 others, use
> list_children to see them all"?

As walking through all the (potential) clones is an expensive
operation, this should abort as soon as possible, and just complain
about the one encountered so far. That could easily be a difference of
a few seconds vs tens of seconds. We don't even know the count,
without paying that cost, so that can't be printed either.
