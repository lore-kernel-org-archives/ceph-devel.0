From: Sage Weil <sage@newdream.net>
Subject: Re: Shall we remove static libraries from *-dev debian pacakges?
Date: Fri, 3 Jun 2016 13:43:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606031342460.6221@cpach.fuggernut.com>
References: <CAJE9aOMma9roYzaTnPE7WdSf4s93QDqTvy6N87YcMgRuyQiR4w@mail.gmail.com> <20160603173953.GA27895@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51907 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426AbcFCRnC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 13:43:02 -0400
In-Reply-To: <20160603173953.GA27895@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 3 Jun 2016, Adam C. Emerson wrote:
> On 04/06/2016, kefu chai wrote:
> > Hi Cephers,
> >
> > As your know, we are trying to ditch autotools and moving to the cmake
> > building system. Currently, we ship both static (.a) and shared
> > libraries (.so) and their .la files in
> > lib{rbd,rgw,rados,cephfs,radosstriper}-dev debian packages, but only
> > package the shared libraries in rpm packages. When working on the
> > cmake, I find it's a little bit tricky to prepare both static and
> > shared libraries in cmake, see [1].
> > 
> > So questions:
> > 
> > - Is it fine if we don't ship static libraries any more in the *-dev
> > .deb packages just like .rpms?
> 
> Debian policy does not, to my understanding, require us to provide
> static libraries. It demands only that if we have them they should be
> in the -devel package.
> 
> All other things being equal I have a soft preference to ship static
> libraries.
> 
> All other things are not equal.

I'm also happy to drop the static libraries if it makes life easier.  We 
can also do the work to add them back later if there is a compelling need.  
That seems pretty unlikely!

sage
