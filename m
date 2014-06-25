From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Re: Reliability metrics in ceph-tools
Date: Wed, 25 Jun 2014 02:30:18 +0200
Message-ID: <CACUN8h2gbDYJbQpeHX-jgAEF-ggRDCmVCFNrdv1ajz9mmu_-kw@mail.gmail.com>
References: <CACUN8h1G4Fy-vk6D0Pu6VFa3VJSr_5bEWpX+R-E3vWE=8xYauQ@mail.gmail.com>
	<CAFMfnwrcccX5+NUxB0f8ervCOSNQZ3Yo6HhKXXD08nueTTUf1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f193.google.com ([209.85.223.193]:64166 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaFYAaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 20:30:19 -0400
Received: by mail-ie0-f193.google.com with SMTP id rd18so231176iec.4
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jun 2014 17:30:18 -0700 (PDT)
In-Reply-To: <CAFMfnwrcccX5+NUxB0f8ervCOSNQZ3Yo6HhKXXD08nueTTUf1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi,

> recovery. The actual configuration parameters that people tend to
> adjust depending on their cluster configuration are:
> osd recovery op priority

Simple question, priority 1 is the highest in this context?

> osd max backfills
> osd recovery max active
> osd recovery threads
>
> You can read a little bit about them here:
>
> https://ceph.com/docs/master/rados/configuration/osd-config-ref/

Actually, this page talks about recovery when the OSD crashes and
restarts again. In that case, the data is not lost, but some may be
outdated. In a way, we can say that  partial data is missing. I assume
that updating data is equivalent to repairing (recode) data? The
estimation of data to be updated can be proportional to the time that
the OSD was gone and the write ratio to mutable data? Does it have
sense at all to consider that kind of recovery in a cold storage tier?
The page does not say anything regarding recovery when OSD crashes and
never starts again. I understand that such kind of recovery is trigger
when the primary OSD does scrubbing. I think this is the only type of
recovery we are interested. Are the above configuration parameters
applicable to this case too?

>
> Any improvement that makes the model more realistic would be a great
> contribution. A good first pass might be adding a configuration
> setting that is be populated by the operator with osd_max_backfills
> multiplied by the number of osds per host. This way you can divide the
> restore bandwidth by the number of current restorations to get a per
> placement group restoration rate. I'm not sure how best to track
> placement groups that are waiting for a recovery slot.
>

Backfilling is a special type of recovery, I was not aware until today...
Is there any diagram to help understand the transitions between the pg
states specified in
http://ceph.com/docs/master/rados/operations/pg-states/ ? That would
be great to understand the behavior, if not I will try to do one.

>> 3) The above formula doesn't say anything about the replication
>> latency, the cost of encoding, etc. For the case of erasure, such
>> values are significant. Furthermore, repairing means read k chunks and
>> store again k+m chunks. What happen with previous chunks that are
>> still available? Only the missing chunk is replaced? I wonder how to
>> adapt the previous formula with the k and m.   I add the factor 2
>> because the k chunks how to be fetch from somewhere else to do the
>> re-coding and then k+m chunks have to be stored again.
>> seconds = float(self.disk.size * self.full *(2k+m)) / (speed * self.pgs) ??
>
> I'm curious how significant of a difference this would make, I'd be
> interested in seeing some rough tests of encoding and decoding. With
> the test data you could probably extrapolate the results and get a
> rough idea of the impact it would have on recovery time.

But is my initial though correct? Repairing in erasure coding is much
more expensive than in replication. In the first one, the primary OSD
needs to fetch k blocks and generate k+m blocks and upload only the
missing blocks. Maybe, some simple assumption is assuming that the
recovery rate (speed) for erasure coding is much slower and use the
same formula as replication. How much slower is not clear yet. Loic
did some benchmarks and publish them in http://dachary.org/?p=2594:
Recovering the loss of one OSD: 10GB/s
Recovering the loss of two OSD: 3.2GB/s

But this is cpu related and not networking and that actually baffles
me. Maybe Loic can help me to understand this benchmarks. if you did
erasure code (k=6,m=2) and you are not considering the network, why
you get different recovery ratio? I understand that repairing is a
dummy process and you have to regenerate all 6+2 blocks always to
repair the loss of 1 or 2 OSD. Do you have some improve library where
you can indicate the erasures?

>> 4) Declustering: I am not sure if I understand how it works. From the
>> reliability model "The number of OSDs read-from and written-to is
>> assumed to be equal to the
>> specified declustering factor, with each of those transfers happening
>> at the specified recovery speed."  I also read sth written by Sage in
>> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
>> But I am confused. Not clear for me how to use self.pgs (in the
>> context of the tool) and k&m in the formula above.
>
> I'll use the example of a Ceph block device, which will be striped
> across many placement groups. In this example the number of placement
> groups the block volume can be striped across would be the
> declustering factor (4MB stripe boundary by default). If we limit the
> number of placement groups then we decrease the likelihood that a lost
> placement group will affect any given block device. I'm not sure how
> erasure coding might affect this, so I'll defer that part to Loic or
> Sam.
>
Loic, do you have any words on point 4?

Best,
koleosfuscus
