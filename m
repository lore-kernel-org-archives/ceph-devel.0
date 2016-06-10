From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Understanding mon space usage during recovery
Date: Fri, 10 Jun 2016 10:58:28 +0200
Message-ID: <575A8134.5020808@corp.ovh.com>
References: <5757E47A.2010203@corp.ovh.com>
 <CAJ4mKGZTHQYXXgRgWaoiLViX6Z6x0NtjE9-N3tJdR8M2BUvqQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo175.mail-out.ovh.net ([46.105.47.107]:34197 "EHLO
	6.mo175.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcFJJeZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 05:34:25 -0400
In-Reply-To: <CAJ4mKGZTHQYXXgRgWaoiLViX6Z6x0NtjE9-N3tJdR8M2BUvqQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks for hints, replied inline.

On 06/08/2016 05:33 PM, Gregory Farnum wrote:
> On Wed, Jun 8, 2016 at 2:25 AM, Bart=C5=82omiej =C5=9Awi=C4=99cki
> <bartlomiej.swiecki@corp.ovh.com> wrote:
>> Hi,
>>
>> I was recently trying to understand the growth of mon disk space usa=
ge
>> during recovery in one of our clusters,
>> wanted to know whether we could reduce disk usage somehow or if we j=
ust have
>> to prepare more space for our mons.
>> Cluster is 0.94.6, just over 300 OSDs. Leveldb compaction does reduc=
e space
>> usage but it quickly grows back
>> to the previous usage. What I found out is that most of the leveldb =
data is
>> used by osdmap history.
>>
>> For each osdmap version leveldb contains both full and incremental e=
ntry so
>> I was thinking if we really need to
>> store full osdmaps for all versions? If we're having incremental cha=
nges for
>> every version anyway, wouldn't it be
>> sufficient to keep first full version only and then recover any futu=
re ones
>> by applying incrementals?
> Maybe not; we've gone back and forth on this but I think we ended up
> learning that reconstructing them was just annoying in terms of
> needing to read all the extra keys.
I think we can't get away reserving more space to mons then.
>> I was also trying to understand how ceph figures out the range of os=
dmap
>> versions to keep. After analyzing the code
>> I thought the obvious answer was in PGMap::calc_min_last_epoch_clean=
() - In
>> case of our production cluster,
>> the difference between min and max clean epochs was around 30k durin=
g
>> recovery, size of one full osdmap blob
>> in leveldb is around 250k.
> Yeah, there's not a lot that can be done about this directly. 30k map=
s
> is an awful lot though; you probably have other issues happening in
> your OSDs (or monitors?).
There were no other issues but it takes more than a day to finish=20
rebalancing
the cluster. That would mean new osdmap would have to get created once =
every
3 seconds - is that possible? What events could cause upgrade of osdmap=
?
The cluster had noscrub and nodeep-scrub set to speedup the recovery.
>> I also tried to test this on my dev cluster where I could run gdb (1=
5 OSD, 4
>> OSD nearfull and lots of misplaced objects).
>> What I found out is that execution in OSDmonitor::get_trim_to() almo=
st never
>> jumped inside the first 'if'.
>> mon->pgmon()->is_readable() returns false, I did debug it once and i=
t was a
>> result of false returned by Paxos::is_lease_valid().
> Okay, that's bad. If your lease isn't valid, then the monitors are
> getting so bogged down that they're timing out the leases and
> temporarily breaking quorum. You should figure out if this is a load
> issue or a result of clock skew issues or something.
> -Greg
I'll try to get some more details on that. I'm running dedicated NTP=20
server to
sync all nodes so I guess clock skew is not an issue here.

Bartek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
