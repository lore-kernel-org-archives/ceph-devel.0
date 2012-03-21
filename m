From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Theoretical questions
Date: Wed, 21 Mar 2012 10:12:44 -0700
Message-ID: <CACLRD_3=FU+2jO6=AZ-KAyk7AqZmduffasDmbVh9BbLNhJW9+g@mail.gmail.com>
References: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50105 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758485Ab2CURMr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 13:12:47 -0400
Received: by wibhj6 with SMTP id hj6so6798036wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 10:12:44 -0700 (PDT)
In-Reply-To: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

1. The standby mds does not maintain cached metadata in memory or
serve reads.  When taking over from a failed mds, it reads the
primary's journal, which does warm up its cache somewhat.  Optionally,
you can put an mds into standby-replay for an active mds.  In this case=
,
the standby-replay mds will continually replay the primary's journal in
order to more quickly take over in the case of a crash.

2. Primary-copy is the only strategy currently implemented.

3. On a sync, we wait for commits to ensure data safety.

4. I don't quite understand this question.

5.  Currently, there is not a good way to accomplish this using only
ceph.  Replication is synchronous on writes, so you would be paying
the latency cost between data centers on each write if you wanted to
replicate between data centers.  We don't currently support reading fro=
m
the closest replica.


On Wed, Mar 21, 2012 at 2:22 AM, Borodin Vladimir <v.a.borodin@gmail.co=
m> wrote:
> Hi all.
>
> I've read everything in ceph.newdream.net/docs and
> ceph.newdream.net/wiki. I've also read some articles from
> ceph.newdream.net/publications. But I haven't found answers on some
> questions:
> 1. there is one active MDS and one in standby mode. Active MDS caches
> all metadata in RAM. Does standby MDS copy this information to RAM?
> Will it take metadata from OSDs on every request after primary MDS
> failure? Do read requests come to standby MDS?
> 2. what replication strategy on OSDs (primary-copy, chain or splay) i=
s
> turned on by default?
> 3. when does kernel client understand that the write was successfull
> (when it recieves ack or commit from primary OSD)?
> 4. I want to have 3 copies of each object. By default there is a way
> to write only one successfull copy (and two others give a failure),
> isn't that? Is there a way to turn this off (even if one of three
> copies failed, the object will be placed to another PG)?
> 5. if I have several data centers with good network connection, what
> is the way to provide data locality? For example, most of write and
> read requests from Spain come to Spanish DC and most of write and rea=
d
> requests from Russia come to Russian DC. Is it posible?
>
> Regards,
> Vladimir.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
