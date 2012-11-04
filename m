From: Sage Weil <sage@inktank.com>
Subject: Re: BUG: kvm crashing in void
 librbd::AioCompletion::complete_request
Date: Sun, 4 Nov 2012 11:19:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211041119090.8980@cobra.newdream.net>
References: <50967583.8000109@profihost.ag> <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net> <509676B9.1040505@profihost.ag> <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net> <5096BF5A.1090803@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44683 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab2KDTTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 14:19:46 -0500
In-Reply-To: <5096BF5A.1090803@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 4 Nov 2012, Stefan Priebe wrote:
> Am 04.11.2012 15:12, schrieb Sage Weil:
> > On Sun, 4 Nov 2012, Stefan Priebe wrote:
> > > Can i merge wip-rbd-read into master?
> > 
> > Yeah.  I'm going to do a bit more testing first before I do it, but it
> > should apply cleanly.  Hopefully later today.
> 
> Any other branches to merge locally while benchmarking / testing?

Nope, although you get the latest wip-rbd-read (I fixed an issue with 
glibc's random_r sucking).

sage
