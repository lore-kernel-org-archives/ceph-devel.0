From: Sage Weil <sweil@redhat.com>
Subject: Re: C++11 and librados C++
Date: Tue, 4 Aug 2015 05:51:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508040550250.22099@cobra.newdream.net>
References: <CAN=+7FX9Va+rxRr87E6bn6djjHSvXtVZTd+f576g=n01TJ5cRA@mail.gmail.com> <55C09812.8000704@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867AbbHDMvh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 08:51:37 -0400
In-Reply-To: <55C09812.8000704@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "Durgin, Josh" <jdurgin@redhat.com>, Casey Bodley <cbodley@redhat.com>

On Tue, 4 Aug 2015, Wido den Hollander wrote:
> On 03-08-15 22:25, Samuel Just wrote:
> > It seems like it's about time for us to make the jump to C++11.  This
> > is probably going to have an impact on users of the librados C++
> > bindings.  It seems like such users would have to recompile code using
> > the librados C++ libraries after upgrading the librados library
> > version.  Is that reasonable?  What do people expect here?
> 
> Well, some people use Qemu build by their distro, but they use librados
> / librbd from ceph.com
> 
> So if they suddenly have to rebuild Qemu that would hurt them I think.

Qemu fortunately is using the C bindings, so it would not be affected.  
It is only the C++ ABI (or lack thereof) that is problematic.

What users of the C++ bindings are there out there?

sage
