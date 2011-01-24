From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: xtreemfs
Date: Mon, 24 Jan 2011 11:07:25 -0800
Message-ID: <AANLkTimtvRaw1+vp7iTAMQqoB+N5TwWuExRK3Mz0fZXV@mail.gmail.com>
References: <AANLkTikayUp=kCnikVPxi2wYch_yY_3fXpLKg6GfCgbf@mail.gmail.com>
	<AANLkTikpLF-v1F=ELqSUNPJxikspLrNW-F6oohJzT8X-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55078 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab1AXTHt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jan 2011 14:07:49 -0500
Received: by ewy5 with SMTP id 5so2090801ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jan 2011 11:07:48 -0800 (PST)
In-Reply-To: <AANLkTikpLF-v1F=ELqSUNPJxikspLrNW-F6oohJzT8X-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Markus Kienast <mark@trickkiste.at>, ceph-devel@vger.kernel.org

Based on what I've read, Tahoe-LAFS would be suitable for use in a WAN
environment. (I've never tested it out, though.)

The main idea behind Tahoe-LAFS seems to be "well, we've got these
remote servers that we don't really trust completely. Can we use them
for storage?"

http://en.wikipedia.org/wiki/Tahoe_Least-Authority_Filesystem

Ceph is designed for a different environment than xtreemfs or Tahoe.

cheers,
Colin


On Mon, Jan 24, 2011 at 10:59 AM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> On Mon, Jan 24, 2011 at 10:46 AM, Markus Kienast <mark@trickkiste.at>=
 wrote:
>> How does ceph differentiate itself from xtreemfs?
> Ceph and XtreemFS have pretty different goals.
> From what I've read, Xtreemfs is designed as a WAN distributed FS wit=
h
> interesting file replication strategies designed to minimize latency
> across the internet.
> Ceph is a cluster filesystem designed to be used across a high-speed
> low-latency network that provides pseudo-random but deterministic
> block-based replication of data, with strong consistency guarantees,
> and extreme scalability. (Unlike xtreemfs, Ceph can shard
> responsibility for metadata across many nodes, and since it calculate=
s
> data placement rather than assigning it, less metadata needs to be
> stored and cached.)
>
> If you have more specific questions (preferably with indications of
> how xtreemfs behaves; I'm not terribly familiar with it) we can answe=
r
> those in more detail. :)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
