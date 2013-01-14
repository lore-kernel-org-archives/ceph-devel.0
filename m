From: Florian Haas <florian@hastexo.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Mon, 14 Jan 2013 15:09:49 +0100
Message-ID: <CAPUexz9X5rZGG6epWPj1qEUcM_ZNyEbDWizUVCGkqY=4btvQqA@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:54494 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab3ANOJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 09:09:49 -0500
Received: by mail-ia0-f179.google.com with SMTP id i9so3308482iad.24
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 06:09:49 -0800 (PST)
In-Reply-To: <50F40C4B.6000301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark,

thanks for the comments.

On Mon, Jan 14, 2013 at 2:46 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> Hi Florian,
>
> Couple of comments:
>
> "OSDs use a write-ahead mode for local operations: a write hits the journal
> first, and from there is then being copied into the backing filestore."
>
> It's probably important to mention that this is true by default only for
> non-btrfs file systems.  See:
>
> http://ceph.com/wiki/OSD_journal

I am well aware of that, but I've yet to find a customer (or user)
that's actually willing to entrust a production cluster with several
hundred terabytes of data to btrfs. :) Besides, the whole post is
about whether or not to use dedicated SSD block devices for OSD
journals, and if you're tossing everything into btrfs you've already
made the decision to use in-filestore journals.

> "Thus, for best cluster performance it is crucial that the journal is fast,
> whereas the filestore can be comparatively slow."
>
> This is a bit misleading.  Having a faster journal is helpful when there are
> short bursts of traffic.  So long as the journal doesn't fill up and there
> are periods of inactivity for the data to get flushed, having slow filestore
> disk may be ok.  With lots of traffic, reality eventually catches up with
> you and you've gotta get all of that data flushed out to the backing file
> system.

I agree that the wording is non-optimal. What I meant was to equate
"fast" with SSDs, and "comparatively slow" with spinners. And to
combine spinners with SSDs is one of the most interesting points about
Ceph in terms of cost effectiveness. Pretty much every other storage
technology would require you to either go all-SSD or to look into
rather sophisticated HSM in order to achieve similar performance at a
comparable scale.

Suggestions for better wording?

> Have you ever seen ceph performance bouncing around with periods of really
> high throughput followed by periods of really low (or no!) throughput?
> That's usually the result of having a very fast journal paired with a slow
> data disk.  The journal writes out data very quickly, hits it's max ops or
> max bytes limit, then writes are stalled for a period while data in the
> journal gets flushed out to the data disk.

Sure, essentially the equivalent, on a different level, of an NFS
server with lots of RAM and a high vm.dirty_ratio suddenly doing a
massive writeout.

> Another thing to remember is that writes to the journal happen without
> causing a lot of seeks.  Ceph doesn't have to do metadata or dentry
> lookups/writes to write data to the journal.  Because of this, it's been my
> experience that journals are primarily throughput bound rather than being
> random IOPS bound.  Just putting the journals on any old SSD isn't enough,
> you need to choose ones that get really high throughput like the Intel
> S3700s or other high performance models.

Yup.

> "By and large, try to go for a relatively small number of OSDs per node,
> ideally not more than 8. This combined with SSD journals is likely to give
> you the best overall performance."
>
> The advice that I usually give people is that if performance is a big
> concern, try to match filestore disk and journal performance is nearly
> matched.  In my test setup, I use 1 intel 520 SSD to host 3 journals for
> 7200rpm enterprise SATA disks.  A 1:4 ratio or even 1:6 ratio may also work
> fine depending on various factors.  So far the limits I've hit with very
> minimal tuning seem to be around 15 spinning disks and 5 SSDs for around
> 1.4GB/s (2.8GB/s including journal writes) to one node.

Yes, I realize that there's no hard number here. I could also have put
"ideally not more than 6". The point I was trying to make is that
people need to get off their thinking of what an ideal storage box is,
and that more disks per host isn't necessarily better. We had a user
in #ceph last week thinking that an OSD node with 36 spinners was a
stellar idea. It probably isn't.

> "If you do go with OSD nodes with a very high number of disks, consider
> dropping the idea of an SSD-based journal. Yes, in this kind of setup you
> might actually do better with journals on the spinners."
>
> If your SSD(s) is/are slow you very well may be better off with putting the
> journals on the same spinning disks as the OSD data.  It's all a giant
> balancing act between write throughput, read throughput, and capacity.

And people generally prefer simple heuristics (a.k.a. rules of thumb)
over giant balancing acts. So I think if we tell them something like,

Got more that 8 spinners?
* No? Toss your journals on SSDs,
* Yes? At least consider not to.

... then I am hoping that will lead more people on the right path,
than when we tell them:

* Here's two dozen performance graphs, a pivot table, and a crystal ball.

I am obviously jesting and exaggerating, but you get my point. :)

Cheers,
Florian

-- 
Helpful information? Let us know!
http://www.hastexo.com/shoutbox
