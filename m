From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 19:41:03 -0500
Message-ID: <CAOx6V3bex4EEd8Y6hzwiWnAUkpxUvJ2xQHh0exxSwx+XmbnooA@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
 <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
 <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
 <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <48082542-C93C-4732-8307-8D6F42C1D915@gmail.com>
 <50FB0BBC.3080309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:63411 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab3ATAlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 19:41:24 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2745271pad.25
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 16:41:23 -0800 (PST)
In-Reply-To: <50FB0BBC.3080309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Peter Smith <peterfruits@gmail.com>, Sage Weil <sage@inktank.com>, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I'd recommend qemu 1.2+. You'll probably need a newer libvirt than Centos 6
> has as well. libvirt 0.10+ is ideal. Ubuntu has an older
> version, but with important fixes backported.

Your guys' most supported/tested platform is Precise, according to
http://ceph.com/docs/master/install/os-recommendations/ -- so is it
more ideal to run Precise (with your packages) with the older +
patched versions of libvirt and qemu, or better to run e.g. Quantal
with newer libvirt + qemu but a less tested platform?

Thanks,
Jeff
