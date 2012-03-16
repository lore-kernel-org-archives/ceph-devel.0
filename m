From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Hadoop on ceph
Date: Fri, 16 Mar 2012 14:35:34 -0700
Message-ID: <F0C7EFD2944442DFBB761475E0133398@dreamhost.com>
References: <4F623EB9.1000901@genome.wustl.edu>
 <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
 <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net>
 <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu>
 <CAADCt4LBvF-oKpWRx9WO1zFnCqPRr_8EPmnv-qZqWY4jLq0-AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63821 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161134Ab2CPVfi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 17:35:38 -0400
Received: by obbuo6 with SMTP id uo6so273178obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Mar 2012 14:35:37 -0700 (PDT)
In-Reply-To: <CAADCt4LBvF-oKpWRx9WO1zFnCqPRr_8EPmnv-qZqWY4jLq0-AQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@newdream.net>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

On Friday, March 16, 2012 at 2:24 PM, Andrey Stepachev wrote:
> 2012/3/16 Noah Watkins <jayhawk@cs.ucsc.edu (mailto:jayhawk@cs.ucsc.edu)>:
> > 
> > On Mar 16, 2012, at 8:37 AM, Sage Weil wrote:
> > 
> > > Hi Andrey,
> > > 
> > > On Fri, 16 Mar 2012, Andrey Stepachev wrote:
> > > 
> > > possible). I take it TestDSFIO is a standard hadoop benchmark?
> > 
> > Yes, this is. There are a number of benchmarks that ship with Hadoop. Although this is untested, one reason you might be seeing throughput issues is with the standard read/write interface that copies bytes across the JNI interface. On the short list of stuff for the next Java wrapper set is to use the ByteBuffer interface (NIO) to avoid this copying.
> 
> I'm not sure, that problem on java side. All disks loaded at 100%, so
> I think, that problem clearly on osd part. But i want to test your new
> integration and see, if something changes. You maybe right, but I'm not.


Those are some awfully slow disks. I don't know exactly what this test measures, but if you're write-constrained on the HDFS side then Ceph will definitely be slower due to little things like the journaling that it does. And that is a data safety issue where Ceph is paying much higher costs than HDFS does.
But it doesn't mean that Ceph is necessarily slower on good hardware. :)
-Greg


