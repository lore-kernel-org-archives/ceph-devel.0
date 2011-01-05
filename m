From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: CEPH production readyness
Date: Wed, 5 Jan 2011 09:30:53 -0800
Message-ID: <AANLkTimOAmDa4N=oiR+Z4zYEbBRvCHMe=Znvbw6KgzHY@mail.gmail.com>
References: <AANLkTi=JGqKApqpJJCf_ejxiA=F1VZ2eNxr7ANxxSRgN@mail.gmail.com>
	<AANLkTinxpnbvc17FP_9r+XQMJvXTaBwdR8w5L5oeWY0b@mail.gmail.com>
	<AANLkTimpSrTVgT61uCkn0Zk4NdpcMZZ5bfK73Kt82SqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43637 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1AERay convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jan 2011 12:30:54 -0500
Received: by eye27 with SMTP id 27so6837563eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jan 2011 09:30:53 -0800 (PST)
In-Reply-To: <AANLkTimpSrTVgT61uCkn0Zk4NdpcMZZ5bfK73Kt82SqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 5, 2011 at 12:55 AM, Roland Rabben <roland@jotta.no> wrote:
> Thanx for your answers. It is not very clear from the documentation
> what ammount of data that is moved around in the background after I
> add new OSD's.
>
> I store very large ammounts of data, and each of my storage servers
> holds about 64 TB =A0(36 X 2 TB configured in two RAID-6 sets. Each R=
AID
> set holds two EXT4 partitions). I store many files in all sizes.
>
> Moving 30-40 TB of data around each time I add a new storage node can
> be very painful for my network, and it takes a long time. I guess wha=
t
> I am trying to find out is what the nature and performance of the
> rebalance of data is, and what ammount we are talking about.
Ah. Well, Ceph places data by hashing it into a "placement group" (or
PG), there are optimally about 100 PGs per OSD, and those placement
groups are then mapped to OSDs. Rebalancing is done on a per-PG basis
and data should remain available for read/write during most all of the
rebalancing process. (Although based on other emails there may be some
issues with that at the moment, they're bugs and it will be fixed.)

> Lets say I have 10 OSD in an existing Ceph file system. Each OSD has
> 50 TB capacity. Lets say the total Ceph filesystem usage is 50 % orf
> 250 TB. If I add one more node with 50 TB capacity, how much data wil=
l
> be moved around?
>
> Is it just a matter of dividing 250 TB by 11? Approx 22,72 TB.
Well, 22.72TB is definitely the ideal. We haven't run real-world tests
recently, but Sage did some for his thesis (which you can find on the
ceph.newdream.net website) which you can look at.
Since the distribution is probabilistic, the larger the addition the
closer to optimal the data movement will be. In his previous tests, it
looks like adding ~10% storage capacity will result in 15-20% of the
data being migrated, depending on configuration.

> Can I configure how rebalancing works?
Yes and no. There are a number of configurables to control timeouts,
rate-limiting, etc; and the CRUSH map you use for your system defines
where data goes (so it configures rebalancing), but there's no way to
configure rebalancing data placement separately from regular data
placement.

> Will loss of an entire server or RAID set trigger a rebalance?
Eventually, yes. Exactly how long the system waits between determining
that an OSD is "down" and setting it to "out" (which triggers a
rebalance) is a configurable, though, and if you get the OSD back up
in that time interval rebalancing won't occur.

I should note that from Ceph's point of view there is little
difference between servers and RAID sets. Ceph handles data placement
on the level of an OSD daemon, and OSDs only handle one logical disk.
If you have multiple RAIDs to a server, you can either make a single
btrfs partition that covers them both, or run one OSD daemon per RAID.
(You can set up your data mapping to make sure that data replicas are
on separate physical servers even if there are multiple OSD daemons
per server.)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
