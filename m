From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: scaling issues
Date: Tue, 10 Apr 2012 10:22:08 -0600
Message-ID: <4F845E30.6070006@sandia.gov>
References: <4F59414B.3000403@sandia.gov>
 <Pine.LNX.4.64.1203081625030.21631@cobra.newdream.net>
 <4F5A5C65.6030705@sandia.gov> <4F5A9064.3020400@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:59698 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2DJQWt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 12:22:49 -0400
In-Reply-To: <4F5A9064.3020400@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/09/2012 04:21 PM, Jim Schutt wrote:
> On 03/09/2012 12:39 PM, Jim Schutt wrote:
>> On 03/08/2012 05:26 PM, Sage Weil wrote:
>>> On Thu, 8 Mar 2012, Jim Schutt wrote:
>>>> Hi,
>>>>
>>>> I've been trying to scale up a Ceph filesystem to as big
>>>> as I have hardware for - up to 288 OSDs right now.
>>>>
>>>> (I'm using commit ed0f605365e - tip of master branch from
>>>> a few days ago.)
>>>>
>>>> My problem is that I cannot get a 288 OSD filesystem to go active
>>>> (that's with 1 mon and 1 MDS). Pretty quickly I start seeing
>>>> "mds e4 e4: 1/1/1 up {0=cs33=up:creating(laggy or crashed)}".
>>>> Note that as this is happening all the OSDs and the MDS are
>>>> essentially idle; only the mon is busy.
>>>>
>>>> While tailing the mon log I noticed there was a periodic pause;
>>>> after adding a little more debug printing, I learned that the
>>>> pause was due to encoding pg_stat_t before writing the pg_map to disk.
>>>>
>>>> Here's the result of a scaling study I did on startup time for
>>>> a freshly created filesystem. I normally run 24 OSDs/server on
>>>> these machines with no trouble, for small numbers of OSDs.

[snip]

>
> I recompiled with -g -O2, and got this:
>
> OSDs size of pg_stat_t
>      latest  encode
>              time
>
> 48  2976461  0.052731
> 72  4472477  0.107187
> 96  5969477  0.194690
> 120 7466021  0.311586
> 144 8963141  0.465111
> 168 10460317 0.680222
> 192 11956709 0.713398
> 240 14950437 1.159426
> 288 17944413 1.714004
>
> It seems that encoding time still isn't proportional to the
> size of pgmap/latest. However, things have improved enough
> that my 288 OSD filesystem goes active pretty quickly (~90 sec),
> so I can continue testing at that scale.
>

I'm still having trouble at 288 OSDs with under heavy write load
(166 linux clients running dd simultaneously).  I'm currently
running with master branch from last week - commit e792cd938897.

The symptom is that the cluster cycles between "up:active"
and "up:active(laggy or crashed)".  When the cluster goes into
"laggy or crashed" the client caps go stale, and cluster throughput
(as monitored by vmstat on OSD servers) trails off to zero.  After a
short idle period, the cluster goes back "up:active", clients
renew their caps, and cluster throughput goes back to its maximum
until the next cycle starts.

I believe this is a scaling issue because when I use pg_bits = 5
and pgp_bits = 5 (instead of the default 6) to build the filesystem,
I can write >20 TB using the same test, with no instances of the
cluster going  "laggy or crashed".  Perhaps it is related to
the encoding time for pg_stat_t that I reported above?

The problem with using pg_bits = 5 is that the data distribution
is not particularly even; after writing 20 TB to 288 OSDs I see
(max OSD use)/(min OSD use) = ~2. Even with pg_bits = 6 after
writing 20 TB I see (max OSD use)/(min OSD use) = ~1.5.
I think I'd like that variability to be even smaller.

AFAICS I'm getting 3 pools of (n_OSDs << pg_bits) PGs, one pool
each for each of CEPH_DATA_RULE, CEPH_METADATA_RULE, and
CEPH_RBD_RULE.  So, for 288 OSDs I get 3*(288<<6) = 55296 PGs,
plus a few thousand more for the localized PGs.

I can't seem to find any use of CEPH_RBD_RULE in the code, other
than to create that pool.  What am I missing?  I'd like to just
not create that pool to reduce my PG count - what problems might
that cause?

Also, what would be the downside if I tried to not create the
CEPH_METADATA_RULE pool, and just put everything into the
CEPH_DATA_RULE pool?  That way I could run with just one pool.

In the longer run, can anything be done to keep the monitor
daemon responsive when running with thousands of OSDs under a
heavy write load?

Thanks -- Jim

