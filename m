From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Hadoop on ceph
Date: Fri, 16 Mar 2012 10:44:04 +0400
Message-ID: <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
References: <4F623EB9.1000901@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52895 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965298Ab2CPGo1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 02:44:27 -0400
Received: by wibhr17 with SMTP id hr17so372398wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 23:44:25 -0700 (PDT)
In-Reply-To: <4F623EB9.1000901@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

Ceph has a several problems right now:
a) due of strict posix sematics ceph can't handle high throughput.
it very eays to hit max iops (even if we on tmpfs with journal)
b) broken timestamps.  in my case it affected HBase HLog functionality,
so it is possible to not recover after fail.

=46or 6 nodes cluster (I use xfs, because btrfs degrades on high volume=
s)

Ceph 0.43 (from my github)
------------------------------------------------------------------
           Date & time: Thu Mar 01 18:38:16 MSK 2012
       Number of files: 36
Total MBytes processed: 360000
     Throughput mb/sec: 2.8411840839866644
Average IO rate mb/sec: 2.8668723106384277
 IO rate std deviation: 0.29681573660544924
    Test exec time sec: 3991.457


Original hadoop
------------------------------------------------------------------
----- TestDFSIO ----- : write
           Date & time: Thu Mar 01 14:08:53 MSK 2012
       Number of files: 36
Total MBytes processed: 360000
     Throughput mb/sec: 4.59152733368745
Average IO rate mb/sec: 4.596996784210205
 IO rate std deviation: 0.16118933245583172
    Test exec time sec: 2313.589

2012/3/15 Matt Weil <mweil@genome.wustl.edu>:
>> http://ceph.newdream.net/wiki/Using_Hadoop_with_Ceph
>
>
> What are the plans going forward.
>
> Are there any benchmarks out there between HDFS and ceph?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
