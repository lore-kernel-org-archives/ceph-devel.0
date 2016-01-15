From: Sage Weil <sage@newdream.net>
Subject: Re: Compiling for FreeBSD, Bluestore requires AIO
Date: Fri, 15 Jan 2016 12:30:01 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601151229030.17315@cpach.fuggernut.com>
References: <565B3999.3050302@digiware.nl> <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com> <565B4A7F.60301@digiware.nl> <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com> <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net> <5698CF58.7020206@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59228 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbcAOR35 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 12:29:57 -0500
In-Reply-To: <5698CF58.7020206@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Mykola Golub <mgolub@mirantis.com>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 15 Jan 2016, Willem Jan Withagen wrote:
> On 30-11-2015 14:21, Sage Weil wrote:
> > The problem with all of the porting code in general is that it is doomed
> > to break later on if we don't have (at least) ongoing build tests.  In
> > order for a FreeBSD or OSX port to continue working we need VMs that run
> > either gitbuilder or a jenkins job or similar so that we can tell when it
> > breaks.
> > 
> > If someone is willing to run a VM somewhere to do this we can pretty
> > easily stick it on the gitbuilder page at
> > 
> > 	http://ceph.com/gitbuilder.cgi
> 
> Well this is real nice case of such an incident.
> 
> I'm verifying my changes to the C/C++ code, after having forwarded to HEAD.
> And now I get bluestore complaining that it requires AIO.
> Something I've thusfar excluded in the build.
> 
> Does Bluestore really require AIO??
> FreeBSD does have AIO, but to take simple steps one at the time, I excluded it
> with configure. Mainly because it bombs at compile time. Probably due to
> different include files, or function nameing.....
> 
> So, in order of preference:
> - Can I disable AIO for Bluestore
> - Can I disable bluestore being build?

AIO is currently required.  The good news is it is confined (mostly) to 
os/bluestore/BlockDevice.h, so providing an alternative (or non-aio) 
implementaiton shouldnt' be difficult.. in fact it is mostly there.

sage
