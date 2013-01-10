From: Gregory Farnum <greg@inktank.com>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Thu, 10 Jan 2013 13:42:05 -0800
Message-ID: <CAPYLRzhWPOXjodsVr7h=SzrmoUsYSbd+mGisJQAUbnTNd8h9+A@mail.gmail.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
	<alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
	<CAPYLRzj0=s117ahDOKRfm409Rusp4e7fQpvgjOWDJNrB9GUaog@mail.gmail.com>
	<F1501D1A-2C22-45FF-A4F4-3B1CD367B1BD@gmail.com>
	<CAPYLRzgJGB1944vjcWAnvAZmC3S5RhGvz3Ao4PuW-NVChJoKEA@mail.gmail.com>
	<CAPrxi59NpNrCfcW+NpHGAwuz+47T0nn2cpZCUjy3b7Lt-eDW5g@mail.gmail.com>
	<BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F3363@ABGEX70E.FSC.NET>
	<CA+Hcz5-mj0pa7caSp+kRh0LNrdbUaKXqwe8aXLL0HOX_bZ+6fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:52684 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab3AJVmG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 16:42:06 -0500
Received: by mail-qc0-f171.google.com with SMTP id d1so701380qca.16
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 13:42:05 -0800 (PST)
In-Reply-To: <CA+Hcz5-mj0pa7caSp+kRh0LNrdbUaKXqwe8aXLL0HOX_bZ+6fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, Cameron Bahar <cbahar@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <joe.buck@inktank.com>

On Wed, Jan 9, 2013 at 8:00 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> Hi Jutta,
>
> On Wed, Jan 9, 2013 at 7:11 AM, Lachfeld, Jutta
> <jutta.lachfeld@ts.fujitsu.com> wrote:
>>
>> the current content of the web page http://ceph.com/docs/master/cephfs/hadoop shows a configuration parameter ceph.object.size.
>> Is it the CEPH equivalent  to the "HDFS block size" parameter which I have been looking for?
>
> Yes. By specifying ceph.object.size, the Hadoop will use a default
> Ceph file layout with stripe unit = object size, and stripe count = 1.
> This is effectively the same meaning as dfs.block.size for HDFS.
>
>> Does the parameter ceph.object.size apply to version 0.56.1?
>
> The Ceph/Hadoop file system plugin is being developed here:
>
>   git://github.com/ceph/hadoop-common cephfs/branch-1.0
>
> There is an old version of the Hadoop plugin in the Ceph tree which
> will be removed shortly. Regarding the versions, development is taking
> place in cephfs/branch-1.0 and in ceph.git master. We don't yet have a
> system in place for dealing with compatibility across versions because
> the code is in heavy development.

If you are using the old version in the Ceph tree, you should be
setting fs.ceph.blockSize rather than ceph.object.size. :)


>> I would be interested in setting this parameter to values higher than 64MB, e.g. 256MB or 512MB similar to the values I have used for HDFS for increasing the performance of the TeraSort benchmark. Would these values be allowed and would they at all make sense for the mechanisms used in CEPH?
>
> I can't think of any reason why a large size would cause concern, but
> maybe someone else can chime in?

Yep, totally fine.
-Greg
