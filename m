From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Mon, 17 Jan 2011 22:53:14 -0800
Message-ID: <AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
	<AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
	<AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60586 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab1ARGxQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 01:53:16 -0500
Received: by ewy5 with SMTP id 5so3089847ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jan 2011 22:53:14 -0800 (PST)
In-Reply-To: <AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Sun, Jan 16, 2011 at 8:04 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
> I find that the journal sizes are consistent up to about 2040, after
> things starts to get weird.
> So this is what I get when I set journal size
> size 1000 - 1 GB
> size 2000 - 2 GB
> size 2050 - 0 MB
> size 2500 - 0 MB
> size 3000 - 0 MB
> size 4000 - 0 MB
> size 5000 - 904 MB
> size 10000 - 1.8 GB
> when journal gets the 0 MB then I obviously get the 'unable to open
> superblock' error.
Hmmm, I'll try and look into this a bit, or get somebody else to do so.

> Even without the journal, there's no linear or alike improvements.
> If possible, I'd like to keep the journal in the same disk.. Using the
> 'extra' disk for the journal (or perhaps even using tmpfs) doesn't
> sound appealing as far as performance measurements are concerned, at
> least in some fair-testing sense.
> It's leveraging too much..?; then any other fs or disks can do this as
> well to improve, correct me please?
> I'm really mainly testing for a single, easy and reliable out-of-box
> setup, and would like to add more osds to see the clear increments of
> performance. But I haven't yet managed to get this.
Well, if I were testing performance on distributed systems I'd want to
get the most I could out of them all during my testing.
If you're concerned about lack of scaling, I guess I'd just say that
it seems like you're stacking the deck against it a bit, since you do
have a number of oddly interacting constraints that I don't think
anybody knows how to optimize for yet. :)

> The real major concern was the performance scalability, I was testing
> all x1, no replications.
> And as the ddplot and benchmark plot shows, there's just no evidence
> of any scalability,
> (and I did x2 as well)
Oh, this reminds me. How were you setting your replication levels?

> For the HDD osds, I should then use an extra dedicated SSD just for
> journal purpose? If so, then wouldn't the benchmark results be just
> the measurement of this SSD in the end?
Probably you'd want to run it in a configuration you could expect to
use if you decided to use Ceph. I know some people have done this and
been pleased, although I doubt it's worth it with a high-end RAID
card. :)

> The RAID card is quite a good one (512MB ddr2 ram with battery), I
> wanted to stay away from any RAID0/1 configuration, basically leaving
> up to ceph/osd to handle!.
> The only reason why all of the disks (SSDs and HDDs) are connected to
> RAID card is because of the typical server-grade environment (3U
> supporting 16 disks), and the internal SATAs are only limited to 6.
> I know there's a clear performance difference between the HW vs SW
> controllers (mainly the ram). Currently all of the disks are already
> advantaged by the RAID. so the previous plot results should already be
> 'better' than the internal SATA.
Mmmm. I don't know that much about RAID cards, but I suspect you'll
get better performance out of a RAID underlying the OSD than out of 3
OSDs running through the RAID card because if you're actually RAIDing
the disks the card can be a bit smarter about handling flushes and
stuff. :)


Also, one possibility I forgot to consider/mention is that we've seen
a lot of clusters where performance seems abnormally low and it turns
out some of the disks are significantly slower than the others, and
this ends up having a large performance cluster-wide. Dealing with
this isn't something we've started work on yet, but you can at least
check for it, as described here:
http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance

> Right, say if I have say 10 objects, how would this be written/read to
> the 2osds? for both 1x and 2x.
Well, CRUSH uses a pseudo-random mapping. Some of the objects will end
up on osd0 and some on osd1. In the large scale, it'll be 50% on each.
This is definitely not RAID0, though: it's possible (though unlikely)
that all 10 objects will go to osd0. With 2x replication....
> By default configuration, x2 with 2osds, will make the objects reside
> on each osd (basically identical to the mirrored)
Yep!
> If not, how to manually configure (OSDs) to behave like RAID 0 and 1 ?
You really can't get RAID0 out of RADOS using any reasonably means,
unless you want to take full responsibility for data placement in the
application layer. And at that point, you're better off with a
different storage solution.
> Can you give me an example please?
Maybe somebody else, but I'm just not that good with CRUSH maps. :/
> Seeing the crush example on the wiki 'A CRUSH map with 12 hosts, 4
> hosts per rack and 3 racks',
> It just shows the hierarchy and doesn't say which part will be used
> for e.g., 1x, 2x or 3x replc, and so on..
> and as I understand, 4 types of buckets are useful for adding/removing?
> Again, the cpus and ram usages are not the bottleneck when running the
> benchmark I see.
> I think Sage's crush talked about multiple take and emit, so do I need
> like take root1, and take root2 ?
Again, I'm not that good with CRUSH maps.
-Greg
