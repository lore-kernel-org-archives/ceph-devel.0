From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: Higher OSD disk util due to RBD snapshots from Dumpling to Firefly
Date: Wed, 7 Jan 2015 17:51:27 +0100
Message-ID: <CABZ+qqmrpRS32i0oSvJ9W=0RVz8f-aSb+9tYYgW1GwqGDqJ18A@mail.gmail.com>
References: <54A42280.60607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:53844 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbbAGQwL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jan 2015 11:52:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id z12so1428404lbi.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jan 2015 08:52:07 -0800
 (PST)
In-Reply-To: <54A42280.60607@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido,
I've been trying to reproduce this but haven't been able yet.

What I've tried so far is use fio rbd with a 0.80.7 client connected
to a 0.80.7 cluster. I created a 10GB format 2 block device, then
measured the 4k randwrite iops before and after having snaps. I
measured around 2000 iops to the image before any snapshots, then
created 200 snapshots on the device and ran fio again. Initially the
iops were low (I guess this is from the 4MB CoW resulting from the
first 4k write to each underlying object). But eventually the speed
stabilized to around 2000 iops again. Actually the initial slowdown
was the same whether I created 1 snapshot or 200.

This was just quick subjective test so far, since from your report I
was expecting something obvious to stick out. But it appears pretty
OK, no? Would you have expected something different from these tests?

Cheers, Dan


On Wed, Dec 31, 2014 at 5:21 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Last week I upgraded a 250 OSD cluster from Dumpling 0.67.10 to Firefly
> 0.80.7 and after the upgrade there was a severe performance drop on the
> cluster.
>
> It started raining slow requests after the upgrade and most of them
> included a 'snapc' in the request.
>
> That lead me to investigate the RBD snapshots and I found that a rogue
> process had created ~1800 snapshots spread out over 200 volumes.
>
> One image even had 181 snapshots!
>
> As the snapshots weren't used I removed them all and after the snapshots
> were removed the performance of the cluster came back to normal level again.
>
> I'm wondering what changed between Dumpling and Firefly which caused
> this? I saw OSDs spiking to 100% disk util constantly under Firefly
> where this didn't happen with Dumpling.
>
> Did something change in the way OSDs handle RBD snapshots which causes
> them to create more disk I/O?
>
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
