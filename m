From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Tier and MetroCluster
Date: Fri, 17 Feb 2012 23:50:49 +0100
Message-ID: <-4752001628700025891@unknownmsgid>
References: <-4946957540367980946@unknownmsgid> <CAORUGqByVskXRNDA+8USz1_0jTHy6BPyHV9rjayr4fmpfrCLyA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32984 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab2BQWuw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 17:50:52 -0500
Received: by wics10 with SMTP id s10so1840244wic.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 14:50:51 -0800 (PST)
In-Reply-To: <CAORUGqByVskXRNDA+8USz1_0jTHy6BPyHV9rjayr4fmpfrCLyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dnia 17 lut 2012 o godz. 19:06 Tommi Virtanen
<tommi.virtanen@dreamhost.com> napisa=B3(a):

> 2012/2/17 S=B3awomir Skowron <szibis@gmail.com>:
>> 1. Is there any plan about tier support. Example:
>> I have ceph cluster with fast SAS drives, and a losts of RAM, and SS=
D
>> acceleration, and 10GE network. I use only RBD, and RadosGW. Cluster
>> have relative small capacity, but its fast.
>> I have a second cluster with diffrent configuration, with a large
>> number of big SATA drives, and smaller number of RAM, 1Gb ethernet.
>> Same usage as above.
>> All i need is to have phisical 2 clusters, but with some tier
>> function, to move old objects from fast to slow cluster (for archive=
),
>> and opposite.
>
> You can do this right now, by having just one cluster, specifying
> different crush rulesets for different pools, and then moving your
> objects from one pool to another as they get "old". You'll need to
> manage the migration yourself -- with RADOS, explicitly creating
> objects in the "old" pool, with Ceph DFS, "cephfs PATH set_layout
> --pool MYPOOL" only affects new files. For radosgw, this doesn't
> currently exist, and I'm not sure how it would behave, but it is
> conceivable.
>
>> If ceph will be very stable this can be done inside one cluster it
>> will be much simpler, but crush need to know what is faster, and wha=
t
>> is slower.
>
> There are no extra smarts about it. For RADOS, there most likely will
> be no automatic thing here -- after all, we are intentionally avoidin=
g
> any lookup tables -- for the Ceph DFS, I can see that the set_layout
> logic could be extended to migrate existing files too. And radosgw
> might get this as an automatic feature, one day.

Thanks for advice.

=46rom the economical point of view its very nice feature, and i will b=
e
happy to see it in radosgw in some future maybe :)

Yes, you have right, It can be done by the tool in offline via RADOS,
and it's good idea. Maybe storing, a key=3D>value counters for a object
inside ceph, or outside, but it is simple my mind storming :)

>
>> 2. Like above two clusters this time same configurations and size, b=
ut
>> with async replication between.
>> Replication can be done by the external replication darmon on top of
>> rados, or other solution.
>>
>> Is there any plans with any of this ?? Or something like this ??
>
> I think this is something a lot of people will want, so it probably
> will get done at some point. It is not being developed, currently.

Thanks, and i am waiting for some new exciting features in ceph project=
 :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
