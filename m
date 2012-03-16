From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop on ceph
Date: Fri, 16 Mar 2012 08:43:53 -0700
Message-ID: <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu>
References: <4F623EB9.1000901@genome.wustl.edu> <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com> <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:34658 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032937Ab2CPPnz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 11:43:55 -0400
In-Reply-To: <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andrey Stepachev <octo47@gmail.com>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org


On Mar 16, 2012, at 8:37 AM, Sage Weil wrote:

> Hi Andrey,
> 
> On Fri, 16 Mar 2012, Andrey Stepachev wrote:
> 
> possible).  I take it TestDSFIO is a standard hadoop benchmark?

Yes, this is. There are a number of benchmarks that ship with Hadoop. Although this is untested, one reason you might be seeing throughput issues is with the standard read/write interface that copies bytes across the JNI interface. On the short list of stuff for the next Java wrapper set is to use the ByteBuffer interface (NIO) to avoid this copying.

- Noah