From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Reliability metrics in ceph-tools
Date: Tue, 24 Jun 2014 11:40:16 -0700
Message-ID: <CAFMfnwrcccX5+NUxB0f8ervCOSNQZ3Yo6HhKXXD08nueTTUf1w@mail.gmail.com>
References: <CACUN8h1G4Fy-vk6D0Pu6VFa3VJSr_5bEWpX+R-E3vWE=8xYauQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:55353 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbaFXSkR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 14:40:17 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so662491qgd.21
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jun 2014 11:40:16 -0700 (PDT)
In-Reply-To: <CACUN8h1G4Fy-vk6D0Pu6VFa3VJSr_5bEWpX+R-E3vWE=8xYauQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 2) RadosRely.py uses the following rebuild_time formula:
>
> seconds = float(self.disk.size * self.full) / (speed * self.pgs)
> with self.pgs(declustered factor)= number of PGs in OSD and
> speed=expected recovery rate (bytes/second)
>
> I think that the assumption is not realistic in large deployments with
> multiple failing nodes. Typically the replication bandwidth will reach
> a limit when too many nodes are recovering in parallel. I assume,
> however, that ignore that problem is enough to start. Do you agree?

I agree, in fact I have a card on my kanban board that's been sitting
in "next" for a while. Ceph is actually configurable in this respect
such that you can prioritize client operations over recovery
operations as well as control the concurrency of placement group
recovery. The actual configuration parameters that people tend to
adjust depending on their cluster configuration are:

osd recovery op priority
osd max backfills
osd recovery max active
osd recovery threads

You can read a little bit about them here:

https://ceph.com/docs/master/rados/configuration/osd-config-ref/

Any improvement that makes the model more realistic would be a great
contribution. A good first pass might be adding a configuration
setting that is be populated by the operator with osd_max_backfills
multiplied by the number of osds per host. This way you can divide the
restore bandwidth by the number of current restorations to get a per
placement group restoration rate. I'm not sure how best to track
placement groups that are waiting for a recovery slot.

> 3) The above formula doesn't say anything about the replication
> latency, the cost of encoding, etc. For the case of erasure, such
> values are significant. Furthermore, repairing means read k chunks and
> store again k+m chunks. What happen with previous chunks that are
> still available? Only the missing chunk is replaced? I wonder how to
> adapt the previous formula with the k and m.   I add the factor 2
> because the k chunks how to be fetch from somewhere else to do the
> re-coding and then k+m chunks have to be stored again.
> seconds = float(self.disk.size * self.full *(2k+m)) / (speed * self.pgs) ??

I'm curious how significant of a difference this would make, I'd be
interested in seeing some rough tests of encoding and decoding. With
the test data you could probably extrapolate the results and get a
rough idea of the impact it would have on recovery time.

> 4) Declustering: I am not sure if I understand how it works. From the
> reliability model "The number of OSDs read-from and written-to is
> assumed to be equal to the
> specified declustering factor, with each of those transfers happening
> at the specified recovery speed."  I also read sth written by Sage in
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
> But I am confused. Not clear for me how to use self.pgs (in the
> context of the tool) and k&m in the formula above.

I'll use the example of a Ceph block device, which will be striped
across many placement groups. In this example the number of placement
groups the block volume can be striped across would be the
declustering factor (4MB stripe boundary by default). If we limit the
number of placement groups then we decrease the likelihood that a lost
placement group will affect any given block device. I'm not sure how
erasure coding might affect this, so I'll defer that part to Loic or
Sam.

-- 

Kyle
