From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Thu, 13 Dec 2012 12:33:08 -0800
Message-ID: <CAPrxi59NpNrCfcW+NpHGAwuz+47T0nn2cpZCUjy3b7Lt-eDW5g@mail.gmail.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
	<alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
	<CAPYLRzj0=s117ahDOKRfm409Rusp4e7fQpvgjOWDJNrB9GUaog@mail.gmail.com>
	<F1501D1A-2C22-45FF-A4F4-3B1CD367B1BD@gmail.com>
	<CAPYLRzgJGB1944vjcWAnvAZmC3S5RhGvz3Ao4PuW-NVChJoKEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63455 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372Ab2LMUdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 15:33:09 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so2897277vby.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 12:33:08 -0800 (PST)
In-Reply-To: <CAPYLRzgJGB1944vjcWAnvAZmC3S5RhGvz3Ao4PuW-NVChJoKEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Cameron Bahar <cbahar@gmail.com>, Sage Weil <sage@inktank.com>, "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Noah Watkins <noah.watkins@inktank.com>, Joe Buck <joe.buck@inktank.com>

The bindings use the default Hadoop settings (e.g. 64 or 128 MB
chunks) when creating new files. The chunk size can also be specified
on a per-file basis using the same interface as Hadoop. Additionally,
while Hadoop doesn't provide an interface to configuration parameters
beyond chunk size, we will also let users fully configure for any Ceph
striping strategy. http://ceph.com/docs/master/dev/file-striping/

-Noah

On Thu, Dec 13, 2012 at 12:27 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Dec 13, 2012 at 12:23 PM, Cameron Bahar <cbahar@gmail.com> wrote:
>> Is the chunk size tunable in A Ceph cluster. I don't mean dynamic, but even statically configurable when a cluster is first installed?
>
> Yeah. You can set chunk size on a per-file basis; you just can't
> change it once the file has any data written to it.
> In the context of Hadoop the question is just if the bindings are
> configured correctly to do so automatically.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
