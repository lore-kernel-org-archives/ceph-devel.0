From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Unable to Add Monitor
Date: Mon, 9 May 2011 09:08:34 -0700
Message-ID: <BANLkTik5FbaysoFYV-XzKX1T+K8gPAsWzQ@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46071 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1EIQIg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 12:08:36 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8B8C6C066
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 09:08:36 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 39240C064
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 09:08:36 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1585907eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 09:08:34 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 9, 2011 at 7:22 AM, Mark Nigh <mnigh@netelligent.com> wrote=
:
> I have been testing Ceph for several months now but with only 2 mds a=
nd 1 mon. I would like to test failover between mon so I am trying to a=
dd the first (1st) of two (2) mon on the other mds in the cluster.
>
> I also noticed that the mon naming has been changed from numerics to =
names so I am trying to change that also.
>
> My Process:
>
> On the first mon, I get an error when issuing this command "ceph mon =
add beta 10.6.1.91:6789"
>
> I receive the following error as it repeats:
>
> 2011-05-09 09:17:05.500353 7f9248ab0700 -- :/28272 >> 10.6.1.91:6789/=
0 pipe(0x2167010 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
This error generally means that the daemon can't communicate with its
target -- in this case, 10.6.1.91:6789. Do you already have mon.beta
in your ceph.conf? It looks like ceph tool is trying to issue its
commands to that monitor.
You can specify which monitor to connect to using the -m switch:
ceph -m 10.6.1.90:6789 mon add beta 10.6.1.91:6789
(assuming there that mon.alpha is using address 10.6.1.90:6789).

> When I try to start the monitor service on beta I get the following e=
rror:
>
> =3D=3D=3D mon.beta =3D=3D=3D
> Starting Ceph mon.beta on mds1...
> =A0** WARNING: Ceph is still under heavy development, and is only sui=
table for **
> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with =
important data. =A0 =A0 =A0 **
> unable to read magic from mon data.. did you run mkcephfs?
> failed: ' /usr/bin/cmon -i beta -c /etc/ceph/ceph.conf '
Did you follow the directions at
http://ceph.newdream.net/wiki/Monitor_cluster_expansion?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
