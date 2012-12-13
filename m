From: Gregory Farnum <greg@inktank.com>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Thu, 13 Dec 2012 12:27:44 -0800
Message-ID: <CAPYLRzgJGB1944vjcWAnvAZmC3S5RhGvz3Ao4PuW-NVChJoKEA@mail.gmail.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
	<alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
	<CAPYLRzj0=s117ahDOKRfm409Rusp4e7fQpvgjOWDJNrB9GUaog@mail.gmail.com>
	<F1501D1A-2C22-45FF-A4F4-3B1CD367B1BD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50827 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab2LMU1o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 15:27:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4658968ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 12:27:44 -0800 (PST)
In-Reply-To: <F1501D1A-2C22-45FF-A4F4-3B1CD367B1BD@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cameron Bahar <cbahar@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Noah Watkins <noah.watkins@inktank.com>, Joe Buck <joe.buck@inktank.com>

On Thu, Dec 13, 2012 at 12:23 PM, Cameron Bahar <cbahar@gmail.com> wrote:
> Is the chunk size tunable in A Ceph cluster. I don't mean dynamic, but even statically configurable when a cluster is first installed?

Yeah. You can set chunk size on a per-file basis; you just can't
change it once the file has any data written to it.
In the context of Hadoop the question is just if the bindings are
configured correctly to do so automatically.
-Greg
