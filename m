From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Hadoop on ceph
Date: Thu, 15 Mar 2012 13:43:03 -0700
Message-ID: <47609024FD6B4AC589371C096D845842@dreamhost.com>
References: <4F623EB9.1000901@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41732 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161383Ab2COUnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 16:43:07 -0400
Received: by yenl12 with SMTP id l12so3499322yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 13:43:06 -0700 (PDT)
In-Reply-To: <4F623EB9.1000901@genome.wustl.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org, Noah Watkins <jayhawk@cs.ucsc.edu>

On Thursday, March 15, 2012 at 12:10 PM, Matt Weil wrote:
> > http://ceph.newdream.net/wiki/Using_Hadoop_with_Ceph
> 
> 
> 
> What are the plans going forward.
Going forward we want to switch to use the Java libceph bindings that Noah Watkins has been working on. I suspect we'll do the conversion locally if he or somebody else hasn't done it in the next 2-3 months.
Once that conversion is complete and people have reviewed it we'll start running some real benchmarks and try to push the bindings upstream to Apache. If we can't make that happen we'll at least package it up a little better than it is right now.
 
> Are there any benchmarks out there between HDFS and ceph?

We don't have any local ones of substance, although I think Noah's group did some recently? I did some several years ago that showed rough parity, but they were all single-machine instances and short tests.

Although honestly until somebody reviews the Hadoop bindings and we go through some proper tuning and semantics checks I wouldn't trust numbers either way too much.
-Greg

