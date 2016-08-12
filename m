From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS: slow log trimming
Date: Fri, 12 Aug 2016 08:10:04 -0700
Message-ID: <CAJ4mKGZVCW_31xjSoYQFeGh+bjKLX_ppvek0Et8GT5_bn14vHw@mail.gmail.com>
References: <CY4PR02MB2487A848AE06BE15484F73EAE91F0@CY4PR02MB2487.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34679 "EHLO
	mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcHLPQl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 11:16:41 -0400
Received: by mail-ua0-f174.google.com with SMTP id k90so46731419uak.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 08:16:40 -0700 (PDT)
In-Reply-To: <CY4PR02MB2487A848AE06BE15484F73EAE91F0@CY4PR02MB2487.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 12, 2016 at 3:26 AM, Vishal Kanaujia
<Vishal.Kanaujia@sandisk.com> wrote:
> Hi,
>
> I am getting following errors while running a small file creation test:
>
> 2016-08-11 08:10:45.358127 7fc3d8c35700  0 log_channel(cluster) log [WRN] : slow request
>  45.400021 seconds old, received at 2016-08-11 08:09:59.957972:
> client_request(client.26308:5130031 create #10000423cc0/_11_11512_
> 2016-08-11 08:09:59.952255) currently submit entry: journal_and_reply
>
> 2016-08-11 08:10:45.358130 7fc3d8c35700  0 log_channel(cluster) log [WRN] : slow request
>  45.718211 seconds old, received at 2016-08-11 08:09:59.639783:
>  client_request(client.26308:5129520 create #10000422c54/_09_9037_
> 2016-08-11 08:09:59.636259) currently submit entry: journal_and_reply

So this is the point where it sends an operation off to the OSDs. I
think this means it's actually waiting on them, but we might have
logic to prevent the journal from getting too long...

>
> Ceph health also shows a problem:
>
> $ ceph -s
>     cluster 40377bf4-75fd-4474-b4c1-4926f2b53638
>      health HEALTH_WARN
>             mds0: Behind on trimming (196/50) <----------------
>      monmap e1: 1 mons at {iflab12=10.10.10.101:6789/0}
>             election epoch 9, quorum 0 iflab12
>       fsmap e1466: 1/1/1 up {0=iflab12=up:active}
>      osdmap e925: 16 osds: 16 up, 16 in
>             flags sortbitwise
>       pgmap v165880: 2112 pgs, 3 pools, 8046 GB data, 2025 kobjects
>             16093 GB used, 98178 GB / 111 TB avail
>                 2112 active+clean
>   client io 1319 MB/s wr, 0 op/s rd, 1312 op/s wr
>
>
> The ceph.conf has following MDS conf:
> [mds]
> mds_log_max_expiring = 200
> mds_cache_size = 10000000
> mds_log_max_segments = 50

...and you're creating problems for yourself here: expiring segments
are still included in the count; your max_segments value should be
larger than max_expiring.

So fix that config option, and check to see what is happening with
your OSDs if you still have trouble.
-Greg

>
> Test:
> Create ~260K files of size 4k, each. It uses 16 threads, and files/thread are 16384.
>
> Kernel version:  4.4.0-28-generic
> Ubuntu 14.04
>
> $ ceph --version
> ceph version 10.2.2-CEPH-1.4.0.9 (45107e21c568dd033c2f0a3107dec8f0b0e58374)
>
> How could I better MDS performance?
>
> Thanks,
> Vishal
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
