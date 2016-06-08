From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Understanding mon space usage during recovery
Date: Wed, 8 Jun 2016 08:33:23 -0700
Message-ID: <CAJ4mKGZTHQYXXgRgWaoiLViX6Z6x0NtjE9-N3tJdR8M2BUvqQg@mail.gmail.com>
References: <5757E47A.2010203@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33825 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbcFHPdY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2016 11:33:24 -0400
Received: by mail-vk0-f45.google.com with SMTP id e4so16396423vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jun 2016 08:33:24 -0700 (PDT)
In-Reply-To: <5757E47A.2010203@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 8, 2016 at 2:25 AM, Bart=C5=82omiej =C5=9Awi=C4=99cki
<bartlomiej.swiecki@corp.ovh.com> wrote:
> Hi,
>
> I was recently trying to understand the growth of mon disk space usag=
e
> during recovery in one of our clusters,
> wanted to know whether we could reduce disk usage somehow or if we ju=
st have
> to prepare more space for our mons.
> Cluster is 0.94.6, just over 300 OSDs. Leveldb compaction does reduce=
 space
> usage but it quickly grows back
> to the previous usage. What I found out is that most of the leveldb d=
ata is
> used by osdmap history.
>
> For each osdmap version leveldb contains both full and incremental en=
try so
> I was thinking if we really need to
> store full osdmaps for all versions? If we're having incremental chan=
ges for
> every version anyway, wouldn't it be
> sufficient to keep first full version only and then recover any futur=
e ones
> by applying incrementals?

Maybe not; we've gone back and forth on this but I think we ended up
learning that reconstructing them was just annoying in terms of
needing to read all the extra keys.

>
> I was also trying to understand how ceph figures out the range of osd=
map
> versions to keep. After analyzing the code
> I thought the obvious answer was in PGMap::calc_min_last_epoch_clean(=
) - In
> case of our production cluster,
> the difference between min and max clean epochs was around 30k during
> recovery, size of one full osdmap blob
> in leveldb is around 250k.

Yeah, there's not a lot that can be done about this directly. 30k maps
is an awful lot though; you probably have other issues happening in
your OSDs (or monitors?).

>
> I also tried to test this on my dev cluster where I could run gdb (15=
 OSD, 4
> OSD nearfull and lots of misplaced objects).
> What I found out is that execution in OSDmonitor::get_trim_to() almos=
t never
> jumped inside the first 'if'.
> mon->pgmon()->is_readable() returns false, I did debug it once and it=
 was a
> result of false returned by Paxos::is_lease_valid().

Okay, that's bad. If your lease isn't valid, then the monitors are
getting so bogged down that they're timing out the leases and
temporarily breaking quorum. You should figure out if this is a load
issue or a result of clock skew issues or something.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
