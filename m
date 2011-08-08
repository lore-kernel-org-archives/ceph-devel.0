From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Monitors calling for elections all the time under load
Date: Mon, 8 Aug 2011 08:22:53 -0700
Message-ID: <CAF3hT9AyfqLeoJmPH5F_5KeNOkTexQ53NGYVi6Sw8xpfnsOx7g@mail.gmail.com>
References: <201108081127.12810.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56711 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1HHPWy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2011 11:22:54 -0400
Received: by gxk21 with SMTP id 21so740694gxk.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2011 08:22:53 -0700 (PDT)
In-Reply-To: <201108081127.12810.szekelyi@niif.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2011/8/8 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> Hello,
>
> when I put my cluster under a little stress (doing performance measur=
ements
> with fio from one client), I see messages like this when watching the=
 cluster
> with ceph -w:
>
> My setup consists of three machines:
> 1. iscsigw1: OSD+MDS+MON
> 2. iscsigw2: OSD+MDS(standby-replay)+MON
> 3. cc: MON+client+control utility

It's not normal, precisely, but it's unlikely to be hurting anything.
The monitors have to call sync() to save every map, so my guess is
that the monitor on your 'cc' node, with the Ceph client, is simply
taking forever on its sync calls since they try and flush out data
over the network -- and that makes the other monitors think it's down.
Then a new election is called, and since mon.0 (on 'cc') is still
actually alive, it wins the election.

Perhaps we should adjust the election code so that if there's a
complain they don't resolve back to the same leader, although doing
that and still ending up with a result quickly might take some doing.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
