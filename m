From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: CEPH production readyness
Date: Tue, 4 Jan 2011 10:27:53 -0800
Message-ID: <AANLkTinxpnbvc17FP_9r+XQMJvXTaBwdR8w5L5oeWY0b@mail.gmail.com>
References: <AANLkTi=JGqKApqpJJCf_ejxiA=F1VZ2eNxr7ANxxSRgN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58518 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab1ADS1z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 13:27:55 -0500
Received: by eye27 with SMTP id 27so6428858eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 10:27:53 -0800 (PST)
In-Reply-To: <AANLkTi=JGqKApqpJJCf_ejxiA=F1VZ2eNxr7ANxxSRgN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 4, 2011 at 10:02 AM, Roland Rabben <roland@jotta.no> wrote:
> Hi
> I have been following your project for a long time and it looks like
> Ceph is getting closer to release 1.0. Are you planning on calling
> version 1.0 "production ready"?
Version 1.0 will definitely be a production ready version. That's a
nomenclature decision we/Sage made a long time ago.
However, the possibility exists that we'll push back the release by
some trivial-to-significant amount of time.

Lest I dissuade you too much, Ceph is much closer to
production-readiness than it has been in the past. We're internally
working on products based on Ceph, or pieces of it (rbd), and most of
our development time now is devoted to new extra-POSIX features and
bug-fixes in new features rather than in old pieces of the code.
You can take a look at the tracker's roadmap for a better idea of what
still needs to get done; it's mostly disaster recovery stuff (eg fsck)
and other kinds of administrative tools or performance enhancers:
http://tracker.newdream.net/projects/ceph/roadmap

> We have been holding off on testing Ceph in depth, but it looks like
> we should start now that a stable production ready release is in
> sight. For this I have a few questions that I am hoping the community
> can answer before we start testing.
:)

> Once I have a Ceph distributed file system up and running, what is th=
e
> procedure to scale / increase total storage capacity? Any downtime
> necessary for this?
There's a wiki page about this which I believe covers it well:
http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction
There is no downtime.
> Do I need to move any data around or "rebalance" data when I add new
> storage nodes? (This =A0is a huge problem with eg. Glusterfs)
The system does need to rebalance, but it does so automatically -- no
manual intervention is required once the OSDs have been added.
We're still optimizing this portion but in general you should find
that performance goes down during the process but it doesn't take too
long and the system remains fully operational while it's rebalancing.
Since Ceph employs consistent hashing it's moving a bounded portion of
data around rather than moving all the data onto different storage
nodes.

> What are the expected and common maintenance tasks that are Ceph spec=
ific?
Hmm, I can't come up with any. There are a few parameters that you
might need to adjust as you scale up the number of machines you're
running, but in a steady-state system Ceph is pretty self-managing,
and becoming more so as we put in logic to auto-tune parameters.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
