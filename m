From: Gregory Farnum <greg@inktank.com>
Subject: Re: Lazy Erasure Coding for RADOS
Date: Mon, 6 Aug 2012 09:19:05 -0700
Message-ID: <CAPYLRzjnLtUuR0hL_XBKVyNCjtbrF=iRxBy4sB9je5Gpw9TWbw@mail.gmail.com>
References: <00b201cd73e2$d2cf5a60$786e0f20$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64578 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab2HFQTH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 12:19:07 -0400
Received: by lbbgm6 with SMTP id gm6so2917280lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 09:19:05 -0700 (PDT)
In-Reply-To: <00b201cd73e2$d2cf5a60$786e0f20$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Monday, August 6, 2012, Stephen Perkins wrote:
>
> Hi all,
>
> I would like to build a fully geo-redundant and highly available storage
> solution.  I read a research paper that describes the architecture of the
> Microsoft Azure deployment (looking to hit several hundred petabytes soon).
> This was presented at the 23rd ACM Symposium on Operating System Principles.
> Information and paper here:
>
> http://blogs.msdn.com/b/windowsazure/archive/2011/11/21/windows-azure-storag
> e-a-highly-available-cloud-storage-service-with-strong-consistency.aspx
>
> The thing I took away from it was that Microsoft considered 3 copies locally
> to be the minimum number required for protection.  However, they also
> realized that you cannot afford to scale to an Exabyte with a 3x overhead
> for storage.  So. they have a lazy process that goes around and behind the
> scenes and converts objects stored with 3X redundancy to an object that is
> erasure coded with Reed-Solomon having a 1.3 or 1.6 overhead.   At the same
> time, the RS coding provides a better long term availability than the 3x
> replication approach.
>
> Specifics of the RS coding are here (best paper award at Usenix):
>
> https://www.usenix.org/conference/usenixfederatedconferencesweek/erasure-cod
> ing-windows-azure-storage
>
> As far as I have found, there are two implementations of R-S coded object
> stores out there:
>                 Commercial - Cleversafe (http://www.cleversafe.com/)
>                 Open Source - Tahoe-LAFS (http://www.tahoe-lafs.org/)
>
> Given a certain availability metric, stronger erasure coding can make a HUGE
> difference in the cost of deployment.  See "Erasure Coding vs Replication: A
> Quantitative Comparison" here:
> http://oceanstore.cs.berkeley.edu/publications/papers/pdf/erasure_iptps.pdf
>
> Has any thought been given to implementing stronger erasure coding in RADOS
> (either directly or in a lazy fashion)?

It's been thought about in the "RADOS should support erasure codes
instead of just replication" sense, but not in the "we would do this
to implement it" sense. I don't know how Azure's storage system works
(will need to check out that paper!), but implementing erasure coding
in the OSDs would essentially require re-implementing or extending all
of their difficult code, which is obviously not something we're eager
to do at this time.
