From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 11:21:56 +0200
Message-ID: <4FCC7E34.7040005@univ-nantes.fr>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com> <4FCC5431.6070002@suse.de> <4FCC6328.3020606@profihost.ag> <4FCC6644.8010106@suse.de> <4FCC6963.7090202@profihost.ag> <4FCC6B82.9080609@suse.de> <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:34038 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754066Ab2FDJWD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 05:22:03 -0400
In-Reply-To: <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Le 04/06/2012 10:23, Stefan Majer a =E9crit :
> Hi Hannes,
>
> our production environment is running on 10GB infrastructure. We had =
a
> lot of troubles till we got to where we are today.
> We use Intel X520 D2 cards on our OSD=B4s and nexus switch
> infrastructure. All other cards we where testing failed horrible.
>

we have Intel Corporation 82599EB 10 Gigabit Dual Port Backplane=20
Connection (rev 01)... Don't know the 'commercial name'. ixgbe driver.


> Some of the problems we encountered have been:
> - page allocation failures in the ixgbe driver --> fixed in upstream
> - problems with jumbo frames, we had to disable tso, gro, lro -- >
> this is the most obscure thing
> - various tuning via sysctl in the net.tcp and net.ipv4 area --> this
> was also the outcome of stefan=B4s benchmarking odysee.

some tuning we made :

-> Turning off Virtualisation extension in BIOS. Don't know why, but it=
=20
gaves us crappy performance. We usually put it on, because we use KVM a=
=20
lot. In our case, OSD are in bare metal and disabling virtualisation=20
extension gives us a very big boost.
It may be a BIOS bug in our machines (DELL M610).

-> One of my colleague played with receive flow steeting ; the intel=20
card supports multi queue, so it seems we can gain a little with it :

!/bin/sh

for x in $(seq 0 23); do echo FFFFFFFF >=20
/sys/class/net/eth2/queues/rx-${x}/rps_cpus; done
echo 16384 > /proc/sys/net/core/rps_sock_flow_entries
for x in $(seq 0 23); do echo 16384 >=20
/sys/class/net/eth2/queues/rx-${x}/rps_flow_cnt; done


>
> But after all this we a quite happy actully and are only limited by
> the speed of the drives (2TB SATA).
> The fsync is a fdatasync in fact which is available in newer glibc. I=
f
> you dont use btrfs (we use xfs) you need to use a recent glibc with
> fdatasync support.

Does it may explain why we see loosy performance with xfs right now ?=20
That the main reason we're stuck with btrfs for the moment.

we're using debian 'stable' : libc is
libc6                                   2.11.3-3
probably too old ?

Cheers,
--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
