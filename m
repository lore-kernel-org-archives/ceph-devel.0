From: Sage Weil <sage@newdream.net>
Subject: Re: Is there any way to collect object-level I/O access traces in
 Ceph?
Date: Fri, 16 Jan 2015 16:45:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501161644520.15918@cobra.newdream.net>
References: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com> <CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57928 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbAQApX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 19:45:23 -0500
In-Reply-To: <CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Lipeng Wan <lipengwan86@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 16 Jan 2015, Gregory Farnum wrote:
> On Fri, Jan 16, 2015 at 11:28 AM, Lipeng Wan <lipengwan86@gmail.com> wrote:
> > Dear all,
> >
> > Does Ceph provide a way to collect object-level I/O access traces?
> > Specifically, can we collect the traces to record how many times each
> > object has been accessed (read, write, etc.) during a fixed period of
> > time?
> 
> I don't think we have any programmatic access, but depending on what
> you need it for you could enable messenger logging (or filestore
> logging, depending on what exactly you want) and count the references
> there.

There are new librados lttng tracepoints queued up for hammer... see

	https://github.com/ceph/ceph/blob/master/src/tracing/librados.tp

for the tracepoints.

sage
