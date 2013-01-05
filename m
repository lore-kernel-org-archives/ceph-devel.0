From: Gregory Farnum <greg@inktank.com>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Fri, 4 Jan 2013 16:17:14 -0800
Message-ID: <CAPYLRzhVXSRKycxhM3rM2SkHFE6auPj5aES8Wtd6kdA7xw_itg@mail.gmail.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
	<alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
	<CAPYLRzj0=s117ahDOKRfm409Rusp4e7fQpvgjOWDJNrB9GUaog@mail.gmail.com>
	<F1501D1A-2C22-45FF-A4F4-3B1CD367B1BD@gmail.com>
	<CAPYLRzgJGB1944vjcWAnvAZmC3S5RhGvz3Ao4PuW-NVChJoKEA@mail.gmail.com>
	<CAPrxi59NpNrCfcW+NpHGAwuz+47T0nn2cpZCUjy3b7Lt-eDW5g@mail.gmail.com>
	<BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087B4B7@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:45681 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3AEAWj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 19:22:39 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so9249009qcq.14
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 16:22:38 -0800 (PST)
In-Reply-To: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087B4B7@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: Cameron Bahar <cbahar@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Noah Watkins <noah.watkins@inktank.com>, Joe Buck <joe.buck@inktank.com>, Mark Nelson <mark.nelson@inktank.com>

Sorry for the delay; I've been out on vacation...

On Fri, Dec 14, 2012 at 6:09 AM, Lachfeld, Jutta
<jutta.lachfeld@ts.fujitsu.com> wrote:
> I do not have the full output of "ceph pg dump" for that specific TeraSort run, but here is a typical output after automatically preparing CEPH for a benchmark run
>  (removed almost all lines in the long pg_stat table hoping that you do not need them):

Actually those were exactly what I was after; they include output on
the total PG size and the number of objects so we can check on average
size. :) If you'd like to do it yourself, look at some of the PGs
which correspond to your data pool (the PG ids are all of the form
0.123a, and the number before the decimal point is the pool ID; by
default you'll be looking for 0).


On Fri, Dec 14, 2012 at 6:53 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
> The large block size may be an issue (at least with some of our default
> tunable settings).  You might want to try 4 or 16MB and see if it's any
> better or worse.

Unless you've got a specific reason to think this is busted, I am
pretty confident it's not a problem. :)


Jutta, do you have any finer-grained numbers than total run time
(specifically, how much time is spent on data generation versus the
read-and-sort for each FS)? HDFS doesn't do any journaling like Ceph
does and the fact that the Ceph journal is in-memory might not be
helping much since it's so small compared to the amount of data being
written.
-Greg
