From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Performance test on Ceph cluster
Date: Thu, 23 Feb 2012 10:05:36 -0800
Message-ID: <CAORUGqBF-o7o_izZMoT1dNvrSES0owiGtd-9w1u_wYtqoH4AQA@mail.gmail.com>
References: <loom.20120222T102830-526@post.gmane.org> <CAORUGqC4Nof1d0V1K-ntNuRMh6c27AC+cB67HCxsKR-fWa+qPg@mail.gmail.com>
 <loom.20120223T080047-368@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46543 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2BWSF5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 13:05:57 -0500
Received: by werb13 with SMTP id b13so938657wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 10:05:56 -0800 (PST)
In-Reply-To: <loom.20120223T080047-368@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 22, 2012 at 23:12, madhusudhana
<madhusudhana.u.acharya@gmail.com> wrote:
> 1. can you please let me know how I can make only 1 MDS active ?

You can see that in "ceph -s" output, the "mds" line should have just
one entry like "0=3Da=3Dup:active" with the word active.

You can control that with the "max mds" config option, and at runtime
with "ceph mds set_max_mds NUM" and "ceph mds stop ID".

Note, decreasing the number of active MDSes is not currently well
tested. You might be better off with a fresh cluster, that only ever
ran one ceph-mds process.

> 2. BTRFS for all OSD's

There is currently one known case where btrfs's internal structured
get fragmented, and its performance starts degrading. You might want
to make sure you start your test with freshly-mkfs'ed btrfses.

> 3. All hosts (including OSD) in my ceph cluster are running 3.0.9 ver
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[root@ceph-nod=
e-8 ~]# uname -r
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.0.9

Well, that's at least in the 3.x series.. Btrfs has had a steady
stream of fixes, so in general we recommend running the latest stable
kernel. You might want to try that.

> 4. All 9 machines are replica of each other. I have imaged them using
> systemimager. Only difference is 9th node is not a part of CEPH
> cluster. I mounted ceph cluster to this node using mount -t ceph
> command

That's good.

> 5. All 9 clients are running same version of CentOS and Kernel with
> 1GigE interface

> You mean to say, I can have ceph mon/OSD's running in the
> same machine ? but, in ceph wiki, i have read that its better to
> have different machines for each mds/mon/osd.

Yes, I just wanted to make sure you have it set up like that.

> I assume that ceph uses whatever ethernet interface i have (1GigE)
> in my system to load balance the cluster in case of node failure and
> node addition. Won't this uses entire bandwidth during load
> balancing ? won't this cause bandwidth saturation for clients ?

Yes. That's why you can set up a separate network for cluster-internal
communication. See "cluster network" or "cluster addr" vs "public
network" or "public addr".

> I would like to know what benchmark I should use to test CEPH ?
> I want to present the data to my management how CEPH can perform when
> compared with other file systems (like GlusterFS/NetApp/Lustre)

You should use the benchmark that matches your actual workload best.

Please stay active on the mailing list until your results start
looking good. The more information you can provide, the better we can
help you.

We're looking forward to get one of our new hires going, he'll be
benchmarking Ceph on pretty decent hardware & 10gig network with
whatever loads we can come up with. That should give you a better idea
of what to expect, and us what to keep working on.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
