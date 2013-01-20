From: Sage Weil <sage@inktank.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 19:56:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301191955230.29915@cobra.newdream.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
 <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <48082542-C93C-4732-8307-8D6F42C1D915@gmail.com> <50FB0BBC.3080309@inktank.com> <CAOx6V3bex4EEd8Y6hzwiWnAUkpxUvJ2xQHh0exxSwx+XmbnooA@mail.gmail.com>
 <CAPrNTu=_s+Dbhi4-gVcmRqPf8GwcztBQVLvrax2mxyxUtXjTTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34984 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab3ATD4S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 22:56:18 -0500
In-Reply-To: <CAPrNTu=_s+Dbhi4-gVcmRqPf8GwcztBQVLvrax2mxyxUtXjTTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Smith <peterfruits@gmail.com>
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 20 Jan 2013, Peter Smith wrote:
> Or upgrade to 3.7.3 kernel on Precise? Does Inktank test on Ubuntu
> 12.04 with old kernel or 3.7.3 kernel?

We test mostly mainline development kernels in the course of testing our 
own work and ensuring there aren't upstream regressions.

sage

> 
> 
> On Sun, Jan 20, 2013 at 8:41 AM, Jeff Mitchell
> <jeffrey.mitchell@gmail.com> wrote:
> >> I'd recommend qemu 1.2+. You'll probably need a newer libvirt than Centos 6
> >> has as well. libvirt 0.10+ is ideal. Ubuntu has an older
> >> version, but with important fixes backported.
> >
> > Your guys' most supported/tested platform is Precise, according to
> > http://ceph.com/docs/master/install/os-recommendations/ -- so is it
> > more ideal to run Precise (with your packages) with the older +
> > patched versions of libvirt and qemu, or better to run e.g. Quantal
> > with newer libvirt + qemu but a less tested platform?
> >
> > Thanks,
> > Jeff
> 
> 
