From: Sage Weil <sweil@redhat.com>
Subject: Re: regenerating man pages
Date: Tue, 17 Mar 2015 10:11:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503171011020.3716@cobra.newdream.net>
References: <55085911.9060800@redhat.com> <55085B32.9000305@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361AbbCQRL5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 13:11:57 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2HHBuon026627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 13:11:57 -0400
In-Reply-To: <55085B32.9000305@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 17 Mar 2015, Josh Durgin wrote:
> On 03/17/2015 09:40 AM, Ken Dreyer wrote:
> > I had a question about the way that we're handling man pages.
> > 
> > In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regenerate rbd(8)
> > man page", it looks like man/rbd.8 was regenerated from doc/man/8/rbd.rst
> > 
> > It seems like it would be more efficient to avoid storing man pages in
> > Git and generate them dynamically at build time instead?
> 
> Yes, that'd be great!
> 
> > https://github.com/ceph/ceph/blob/master/admin/manpage-howto.txt
> > 
> > "admin/build-doc" does a lot of things (including man page generation).
> > Could we simply run the "sphinx-build -b man" part at build time as a
> > part of "make"?
> 
> I don't see a reason not to. It's just a matter of making it work on all
> the platforms we're building packages for. That might be annoying for
> the entirety of build-doc, but for just building man pages it should
> be simple.

I think the original reason we didn't was just because there are a lot of 
dependencies for building the docs, so this inflates Build-Depends.  That 
doesn't particularly bother me, though, if the deps do in fact exist.

sage
