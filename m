From: Roland Rabben <roland@jotta.no>
Subject: Re: CEPH production readyness
Date: Wed, 5 Jan 2011 09:55:01 +0100
Message-ID: <AANLkTimpSrTVgT61uCkn0Zk4NdpcMZZ5bfK73Kt82SqA@mail.gmail.com>
References: <AANLkTi=JGqKApqpJJCf_ejxiA=F1VZ2eNxr7ANxxSRgN@mail.gmail.com>
	<AANLkTinxpnbvc17FP_9r+XQMJvXTaBwdR8w5L5oeWY0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59142 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab1AEIzC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jan 2011 03:55:02 -0500
Received: by qyj19 with SMTP id 19so17943567qyj.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jan 2011 00:55:02 -0800 (PST)
In-Reply-To: <AANLkTinxpnbvc17FP_9r+XQMJvXTaBwdR8w5L5oeWY0b@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanx for your answers. It is not very clear from the documentation
what ammount of data that is moved around in the background after I
add new OSD's.

I store very large ammounts of data, and each of my storage servers
holds about 64 TB  (36 X 2 TB configured in two RAID-6 sets. Each RAID
set holds two EXT4 partitions). I store many files in all sizes.

Moving 30-40 TB of data around each time I add a new storage node can
be very painful for my network, and it takes a long time. I guess what
I am trying to find out is what the nature and performance of the
rebalance of data is, and what ammount we are talking about.

Lets say I have 10 OSD in an existing Ceph file system. Each OSD has
50 TB capacity. Lets say the total Ceph filesystem usage is 50 % orf
250 TB. If I add one more node with 50 TB capacity, how much data will
be moved around?

Is it just a matter of dividing 250 TB by 11? Approx 22,72 TB.

Can I configure how rebalancing works?

Will loss of an entire server or RAID set trigger a rebalance?

Best regards

Roland Rabben

2011/1/4 Gregory Farnum <gregf@hq.newdream.net>:
> On Tue, Jan 4, 2011 at 10:02 AM, Roland Rabben <roland@jotta.no> wrot=
e:
>> Hi
>> I have been following your project for a long time and it looks like
>> Ceph is getting closer to release 1.0. Are you planning on calling
>> version 1.0 "production ready"?
> Version 1.0 will definitely be a production ready version. That's a
> nomenclature decision we/Sage made a long time ago.
> However, the possibility exists that we'll push back the release by
> some trivial-to-significant amount of time.
>
> Lest I dissuade you too much, Ceph is much closer to
> production-readiness than it has been in the past. We're internally
> working on products based on Ceph, or pieces of it (rbd), and most of
> our development time now is devoted to new extra-POSIX features and
> bug-fixes in new features rather than in old pieces of the code.
> You can take a look at the tracker's roadmap for a better idea of wha=
t
> still needs to get done; it's mostly disaster recovery stuff (eg fsck=
)
> and other kinds of administrative tools or performance enhancers:
> http://tracker.newdream.net/projects/ceph/roadmap
>
>> We have been holding off on testing Ceph in depth, but it looks like
>> we should start now that a stable production ready release is in
>> sight. For this I have a few questions that I am hoping the communit=
y
>> can answer before we start testing.
> :)
>
>> Once I have a Ceph distributed file system up and running, what is t=
he
>> procedure to scale / increase total storage capacity? Any downtime
>> necessary for this?
> There's a wiki page about this which I believe covers it well:
> http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction
> There is no downtime.
>> Do I need to move any data around or "rebalance" data when I add new
>> storage nodes? (This =C2=A0is a huge problem with eg. Glusterfs)
> The system does need to rebalance, but it does so automatically -- no
> manual intervention is required once the OSDs have been added.
> We're still optimizing this portion but in general you should find
> that performance goes down during the process but it doesn't take too
> long and the system remains fully operational while it's rebalancing.
> Since Ceph employs consistent hashing it's moving a bounded portion o=
f
> data around rather than moving all the data onto different storage
> nodes.
>
>> What are the expected and common maintenance tasks that are Ceph spe=
cific?
> Hmm, I can't come up with any. There are a few parameters that you
> might need to adjust as you scale up the number of machines you're
> running, but in a steady-state system Ceph is pretty self-managing,
> and becoming more so as we put in logic to auto-tune parameters.
> -Greg
>



--=20
Roland Rabben
=46ounder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
