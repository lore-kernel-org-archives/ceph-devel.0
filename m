From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Performance test on Ceph cluster
Date: Fri, 24 Feb 2012 10:51:10 -0800
Message-ID: <CAORUGqCJY3Q8uDJLoTeoHPiu9_YpOmE07_ivp28z4L9u0ieRxg@mail.gmail.com>
References: <loom.20120222T102830-526@post.gmane.org> <CAORUGqC4Nof1d0V1K-ntNuRMh6c27AC+cB67HCxsKR-fWa+qPg@mail.gmail.com>
 <loom.20120223T080047-368@post.gmane.org> <CAORUGqBF-o7o_izZMoT1dNvrSES0owiGtd-9w1u_wYtqoH4AQA@mail.gmail.com>
 <loom.20120224T062854-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47771 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab2BXSvb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 13:51:31 -0500
Received: by wgbdr13 with SMTP id dr13so3419wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2012 10:51:30 -0800 (PST)
In-Reply-To: <loom.20120224T062854-915@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 24, 2012 at 00:58, madhusudhana
<madhusudhana.u.acharya@gmail.com> wrote:
> 1. In my cluster, all OSD's are mkfs'ed with btrfs
> 2. Below is what i can see with ceph -s output. Is that mean, only on=
e MDS
> is operation and another one is standby ?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mds e5: 1/1/1 up {0=3Dceph-node-1=3D=
up:active}, 1 up:standby

Yes, you have 1 active and 1 standby mds.

> 3. I will not be able to use new stable kernel bcz of company policy =
:-(

That might become an issue.

> 4. If you don't mind, can you please give me a bit of insight on clus=
ter
> network, what it is and how i can configure one for my ceph cluster ?
> Will there be a significant performance improvement with this ?

When a client submits a write to Ceph, it needs to be replicated
(usually to two replicas). If all the ceph servers have two network
interfaces, and you have two separate networks you connect the servers
to, you can make the replication traffic go over the second interface,
and thus you'll have more available bandwidth between the cluster and
the clients in the first one.

Or you could just bond two 1 gig links, or you could buy 10gig gear.

> 5. I have done some testing with dd on ceph. Below are the results
>
> CASE 1:[root@ceph-node-9 ~]# dd if=3D/dev/zero of=3D/mnt/ceph-test/wt=
est bs=3D4k
> count=3D1000000
=2E..
> As you can see from above output, for 4G file of 4k blocks, speed clo=
cked at
> 1GB/s, it gradually decreased when i increased the file size above 10=
G.
> And also, if i run back to back dd with CASE 1 option, the write will
> slow down from 1GB/s to 90MB/s.
>
> can you please explain whether this behaviour is expected ? if yes, w=
hy ?
> if not, how i can achieve 1GB/s for all file sizes ?

dd is not a very good benchmark. The 4GB write is small enough to
typically be (mostly) stored in RAM even on your client machine --
your benchmark might not even be sending the data over the network
yet! You can get a little bit better by adding conv=3Dfsync to your dd
command lines, that makes sure the data is written to disks before
claiming completion.

In general, you should look for a benchmark that is closer to your work=
load.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
