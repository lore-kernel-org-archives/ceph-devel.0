From: Sage Weil <sage@newdream.net>
Subject: =?ISO-8859-7?Q?Re=3A_=C9nstrumenting_RADOS_with_Zipkin_+_LTTng?=
Date: Fri, 7 Nov 2014 02:32:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411070230091.15135@cobra.newdream.net>
References: <20141030184938.GA10197@radon.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45038 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaKGKcw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 05:32:52 -0500
In-Reply-To: <20141030184938.GA10197@radon.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Shewmaker <agshew@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Andrew!

On Thu, 30 Oct 2014, Andrew Shewmaker wrote:
> Hi everyone,
> 
> I'm Andrew, a new Ceph intern, and I'll be working to get Marios'
> Zipkin + LTTng repo into a merge-able state, as Sam asked about
> (http://www.spinics.net/lists/ceph-devel/msg20024.html).

Awesome!

> I've exchanged email with Marios, and he is interested in 
> helping me with it in his spare time. One of the important 
> things he mentioned is that his blkin library only works 
> with LTTng 2.4. Other versions experience deadlocks, and 
> he'll work to resolve them in 2.5.
> 
> I'm still working on getting a ceph development environment 
> set up, so I haven't tested the tracepoints Marios added.
> I have built an RPM spec file for blkin, tested it against 
> lttng-ust 2.3 and 2.4, and built (but not tested) Marios'
> ceph branch.
> 
> Should I put effort into adding a "--with-blkin" or "--with-zipkin"
> option to autoconf?

Is it statically or dynamically linked?

Probably a first step is to get it in the gitbuilder (test/qa) builds.  

> I've made a first attempt at dividing the changes into
> logically grouped patches: common blkin infrastructure, 
> osd, and rados. Does that sound reasonable? Or should 
> I not bother separating osd and rados changes?

Separate patches is good for review etc.

> I saw a couple instances of extraneous whitespace/newlines
> I'll clean up. What other issues should I look for?
> 
> After they're cleaned up, would it be best for me to submit these 
> patches to the list, or just point to a github repo?

A github pull request is best as that captures the review nicely and is 
how most of the code is going into ceph.git.

Thanks!
sage
