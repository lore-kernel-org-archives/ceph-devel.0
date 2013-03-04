From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 06:16:00 -0800
Message-ID: <CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:59135 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab3CDOQA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 09:16:00 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so4820825iaz.16
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 06:16:00 -0800 (PST)
In-Reply-To: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 3:02 AM, S=C5=82awomir Skowron <szibis@gmail.com=
> wrote:
> Hi,
>
> We have a big problem with RGW. I don't know what is the initial
> trigger, but i have theory.
>
> 2-3 osd, from 78 in cluster (6480 PG on RGW pool), have 3x time more
> RAM usage, they have much more operations in journal, and much bigger
> latency.
>
> When we PUT some objects then in some cases, there are so many
> operations in triple replication on this osd (one PG). Then this
> triple can't handle this load, and goes down, drives on backend of
> this osd are getting fire with big wait-io, and big response times.
> RGW waiting for this PG, and eventually block all the others
> operations when makes 1024 operations blocked in queue.
> Then whole cluster have problems, and we have an outage.
>
> When RGW block operations there is only one PG that have >1000
> operations in queue -
> ceph pg map 3.9447554d
> osdmap e11404 pg 3.9447554d (3.54d) -> up [53,45,23] acting [53,45,23=
]
>
> now this osd are migrated, with ratio 0.5 on, but before it was
>
> ceph pg map 3.9447554d
> osdmap e11404 pg 3.9447554d (3.54d) -> up [71,45,23] acting [71,45,23=
]
>
> and this three osd's have such a problems. Under this osd's are only =
3
> drive, one drive per osd, that's why this have such a big impact.
>
> What i done. I gave 50% smaller ratio in CRUSH for this osd's, but
> data move to other osd, and this osd, have half of possible capacity.
> I think it won't help in long term, and it's not a solution.
>
> I have second cluster, with only replication on it, and there are sam=
e
> case. Attachment explain everything. Every parameter on this bad osd
> is much higher than on others. There are 2-3 osd with such high
> counters.
>
> Is this a bug ?? maybe there is no problems in bobtail ?? I can't
> switch quick into bobtail that's why i need some answers, which way i
> need to go.
>

Not sure if bobtail is going to help much here, although there were a
few performance fixes that went in. If your cluster is unbalanced (in
terms of performance) then requests are going to be accumulated on the
weakest link. Reweighting the osd like what you did is a valid way to
go. You need to make sure that on the steady state, there's no one osd
that starts holding all the traffic.
Also, make sure that your pools have enough pgs so that the placement
distribution is uniform.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
