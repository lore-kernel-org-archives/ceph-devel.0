From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: [ceph-users] who is using nfs-ganesha and cephfs?
Date: Thu, 16 Nov 2017 11:29:28 -0500
Message-ID: <CAKOnarkeD=OtK+f8XGG6TzCMs1k8fudTygWrDPcJSY+g1W5-iQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal> <CAGpUQW0guADd12HryXum9ZnB+VYorymimgtBurWRTwL2aQkKvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:44850 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934113AbdKPQ3a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Nov 2017 11:29:30 -0500
Received: by mail-io0-f172.google.com with SMTP id w127so5794868iow.11
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 08:29:29 -0800 (PST)
In-Reply-To: <CAGpUQW0guADd12HryXum9ZnB+VYorymimgtBurWRTwL2aQkKvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rafael Lopez <rafael.lopez@monash.edu>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi Rafael,

Thanks for taking the time to report your results.

The similarity to Ceph fuse performance is to be expected, because
both Ceph fuse and the nfs-ganesha FSAL driver use libcephfs, as Jeff
Layton noted.  It's worth noting that nfs-ganesha does not appear to
be adding i/o or metadata operation latency.

The interesting questions, pushing further on Jeff's point, I think are

1. libcephfs vs kernel cephfs performance delta, and in particular
2. the portion of that delta NOT accounted for by the direct OSD data
path available to the kernel mode ceph client--the latter can
eventually be made available to nfs-ganesha via pNFS as Jeff hinted,
but the former is potentially available for performance improvement

The topic of the big client lock is an old one.  I experimented with
removing it in 2014, branch api-concurrent here
git@github.com:linuxbox2/linuxbox-ceph.git.  I'm not confident that
just removing the client lock bottleneck will bring visible
improvements, though, especially until MDS concurrency improvements
are in place, but it may be worth revisiting.

Matt

On Thu, Nov 16, 2017 at 3:17 AM, Rafael Lopez <rafael.lopez@monash.edu> wrote:
> We are running RHCS2.3 (jewel) with ganesha 2.4.2 and cephfs fsal, compiled
> from srpm. experimenting with CTDB for controlling ganesha HA since we run
> samba on same servers.
>
> Haven't done much functionality/stress testing but on face value basic stuff
> seems to work well (file operations).
>
> In terms of performance, last time I tested ganesha it seemed comparable to
> ceph-fuse (RHCS2.x/jewel, i think luminous ceph-fuse is better). Though I
> haven't done rigorous metadata tests or multiple client tests. Also our
> ganesha servers are quite small, as we are thus far only serving cephfs
> natively. eg 4G ram 1 core. Here are some FIO results:
>
> jobs in order are:
> 1. async 1M
> 2. sync 1M
> 3. async 4k
> 4. sync 4k
> 5. seq read 1M
> 6. rand read 4k
>
> Ceph cluster is RHCS 2.3 (10.2.7)
>
> CEPH-FUSE (10.2.x)
>   WRITE: io=143652MB, aggrb=490328KB/s, minb=490328KB/s, maxb=490328KB/s,
> mint=300002msec, maxt=300002msec
>   WRITE: io=14341MB, aggrb=48947KB/s, minb=48947KB/s, maxb=48947KB/s,
> mint=300018msec, maxt=300018msec
>   WRITE: io=9808.2MB, aggrb=33478KB/s, minb=33478KB/s, maxb=33478KB/s,
> mint=300001msec, maxt=300001msec
>   WRITE: io=424476KB, aggrb=1414KB/s, minb=1414KB/s, maxb=1414KB/s,
> mint=300003msec, maxt=300003ms
>    READ: io=158069MB, aggrb=539527KB/s, minb=539527KB/s, maxb=539527KB/s,
> mint=300008msec, maxt=300008msec
>    READ: io=1881.2MB, aggrb=6420KB/s, minb=6420KB/s, maxb=6420KB/s,
> mint=300001msec, maxt=300001msec
>
> ganesha (nfs3)
>   WRITE: io=157891MB, aggrb=538923KB/s, minb=538923KB/s, maxb=538923KB/s,
> mint=300006msec, maxt=300006msec
>   WRITE: io=38700MB, aggrb=132093KB/s, minb=132093KB/s, maxb=132093KB/s,
> mint=300006msec, maxt=300006msec
>   WRITE: io=3072.0MB, aggrb=10148KB/s, minb=10148KB/s, maxb=10148KB/s,
> mint=309957msec, maxt=309957msec
>   WRITE: io=397516KB, aggrb=1325KB/s, minb=1325KB/s, maxb=1325KB/s,
> mint=300001msec, maxt=300001msec
>    READ: io=82521MB, aggrb=281669KB/s, minb=281669KB/s, maxb=281669KB/s,
> mint=300002msec, maxt=300002msec
>    READ: io=1322.2MB, aggrb=4513KB/s, minb=4513KB/s, maxb=4513KB/s,
> mint=300001msec, maxt=300001msec
>
> cephfs kernel client
>   WRITE: io=471041MB, aggrb=1568.8MB/s, minb=1568.8MB/s, maxb=1568.8MB/s,
> mint=300394msec, maxt=300394msec
>   WRITE: io=50005MB, aggrb=170680KB/s, minb=170680KB/s, maxb=170680KB/s,
> mint=300006msec, maxt=300006msec
>   WRITE: io=169092MB, aggrb=577166KB/s, minb=577166KB/s, maxb=577166KB/s,
> mint=300000msec, maxt=300000msec
>   WRITE: io=530548KB, aggrb=1768KB/s, minb=1768KB/s, maxb=1768KB/s,
> mint=300003msec, maxt=300003msec
>    READ: io=121501MB, aggrb=414720KB/s, minb=414720KB/s, maxb=414720KB/s,
> mint=300002msec, maxt=300002msec
>    READ: io=3264.6MB, aggrb=11142KB/s, minb=11142KB/s, maxb=11142KB/s,
> mint=300001msec, maxt=300001msec
>
> happy to share fio job file if anyone wants it.
>
>
> On 9 November 2017 at 08:41, Sage Weil <sweil@redhat.com> wrote:
>>
>> Who is running nfs-ganesha's FSAL to export CephFS?  What has your
>> experience been?
>>
>> (We are working on building proper testing and support for this into
>> Mimic, but the ganesha FSAL has been around for years.)
>>
>> Thanks!
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Rafael Lopez
> Research Devops Engineer
> Monash University eResearch Centre
>
> T: +61 3 9905 9118
> M: +61 (0)427682670
> E: rafael.lopez@monash.edu
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
