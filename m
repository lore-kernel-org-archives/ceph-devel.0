From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Hadoop on ceph
Date: Sat, 17 Mar 2012 21:50:29 +0400
Message-ID: <CAADCt4LfqtZ4_70TtBnwsXE+2WMBae1TLFXM86mzRFqx2zN9PQ@mail.gmail.com>
References: <4F623EB9.1000901@genome.wustl.edu> <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
 <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net> <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu>
 <CAADCt4LBvF-oKpWRx9WO1zFnCqPRr_8EPmnv-qZqWY4jLq0-AQ@mail.gmail.com> <F0C7EFD2944442DFBB761475E0133398@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35259 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757081Ab2CQRuu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Mar 2012 13:50:50 -0400
Received: by wejx9 with SMTP id x9so4800316wej.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Mar 2012 10:50:49 -0700 (PDT)
In-Reply-To: <F0C7EFD2944442DFBB761475E0133398@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@newdream.net>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

2012/3/17 Greg Farnum <gregory.farnum@dreamhost.com>:
> On Friday, March 16, 2012 at 2:24 PM, Andrey Stepachev wrote:
>> 2012/3/16 Noah Watkins <jayhawk@cs.ucsc.edu (mailto:jayhawk@cs.ucsc.edu)>:
>> >
>> > On Mar 16, 2012, at 8:37 AM, Sage Weil wrote:
>> >
>> > > Hi Andrey,
>> > >
>> > > On Fri, 16 Mar 2012, Andrey Stepachev wrote:
>> > >
>> > > possible). I take it TestDSFIO is a standard hadoop benchmark?
>> >
>> > Yes, this is. There are a number of benchmarks that ship with Hadoop. Although this is untested, one reason you might be seeing throughput issues is with the standard read/write interface that copies bytes across the JNI interface. On the short list of stuff for the next Java wrapper set is to use the ByteBuffer interface (NIO) to avoid this copying.
>>
>> I'm not sure, that problem on java side. All disks loaded at 100%, so
>> I think, that problem clearly on osd part. But i want to test your new
>> integration and see, if something changes. You maybe right, but I'm not.
>
>
> Those are some awfully slow disks.
Replication was 3.

> I don't know exactly what this test measures, but if you're write-constrained on the HDFS side then Ceph will definitely be slower due to little things like the journaling that it does. And that is a data safety issue where Ceph is paying much higher costs than HDFS does.

This test runs 36 mappers on 6 hosts. Each mapper writes its own file
in parallel.
All that hosts host ceph filesystem. 6 osd, 1 mds  + 2 standby, 3 mons. Mappers
was executed on that hosts.

> But it doesn't mean that Ceph is necessarily slower on good hardware. :)

I don't mean, that Ceph is somewhat slower at general.
Test shows, that hadoop on ceph is x1.5 times slower, then hdfs.
Hadoop has specific write workload and on that workload hadoop shines
right now.
Hadoop read also better. Hadoop can read locally from replica.

> -Greg
>
>



-- 
Andrey.
