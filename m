From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: linux 4.7.0 rbd client kernel panic when OSD process was killed
 by OOM
Date: Tue, 9 Aug 2016 11:02:47 +0200
Message-ID: <CAOi1vP-Jc9X+9isOHiMtSt9JrK26MmkqoQY7knMwsA_Vv9dOiw@mail.gmail.com>
References: <CALXUmNQ91fBrvKQJOeyfT_BZXLikEyDOA9tOMH54pt3NDU+taQ@mail.gmail.com>
 <CAOi1vP8_D6FwQPzGuqsiRv=be3Zv4U7kmO-HjcQEVehD8sYwHA@mail.gmail.com>
 <CALXUmNTVdqn3vBirg-=+a=bq=nAhV=LCR-eAAO4BRyyL6XYpQQ@mail.gmail.com> <CALXUmNSwd76iOF=z-TVSy=YX_v0Hv5sutUh6jgNi2iGzHqmfyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35452 "EHLO
	mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcHIJCt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 05:02:49 -0400
Received: by mail-ua0-f176.google.com with SMTP id n59so8925063uan.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 02:02:48 -0700 (PDT)
In-Reply-To: <CALXUmNSwd76iOF=z-TVSy=YX_v0Hv5sutUh6jgNi2iGzHqmfyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Payno <vpayno@gaikai.com>
Cc: Patrick McLean <patrickm@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 8, 2016 at 10:35 PM, Victor Payno <vpayno@gaikai.com> wrote:
> Ilya:
>
> I think it is the same error, I was confusing it with the 4.4 kernel error.

The kernel client shouldn't crash no matter what - I'll look into it
later this or next week.

>
> Do you have documentation on settings we can use to limit the memory
> growth of OSD processes?
>
> So far all I have is changing these from
>
> osd_min_pg_log_entries = 3000
> osd_max_pg_log_entries = 10000
>
> to
>
> osd_min_pg_log_entries = 300
> osd_max_pg_log_entries = 1000
>
> and now I'm trying  these settings
>
> osd_min_pg_log_entries = 150
> osd_max_pg_log_entries = 500
>
>
>
> The hosts have 12 OSDs (8TB HDDs with SSDs for journals) and 32 GB of
> RAM. We're having a hard time with getting more memory because Ceph
> documentation says 2GB per OSD (24 GB).

>
> The bigger problem I have is that once an OSD OOMs, I can't recover
> it, I have to destroy it and create it again. Unfortunately that
> starts a domino effect and other nodes start loosing 1 OSD to OOM.
> Eventually I end up destroying the cluster and starting over again.
>
>
> This cluster had 2 pools, the second pool had a single 100TB RBD with
> 3.6 TB of data (was currently mapped and mounted but idle).

How many PGs in each pool?

Was there a recovery underway?  I know from experience that during
recovery it can blow past the 2G mark, especially if more than a few
OSDs on the host are being rebalanced at the same time.

Do you have an idea on what leads to the OOM kill?  A test workload you
are running, general state of the cluster, etc.

To get out of  it, I'd add a big swapfile, set the flags to pause any
background operations (backfill, scrub, etc) and prevent OSD flapping
and just babysit it, monitoring memory usage.  You might want to search
ceph-users archive for more tricks.

Thanks,

                Ilya
