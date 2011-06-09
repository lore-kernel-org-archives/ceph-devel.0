From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Active vs. standby MDSes (Was: Re: Degraded PGs blocking open()?)
Date: Thu, 9 Jun 2011 12:23:08 +0200
Message-ID: <201106091223.08914.szekelyi@niif.hu>
References: <201106070237.34854.szekelyi@niif.hu> <BANLkTimt0MKyd9ZOqxYm=z91HNS+5B=a1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:52336 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab1FIKXR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 06:23:17 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id DBB81874AC
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 12:23:15 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id 4wAY4zoCJhPD for <ceph-devel@vger.kernel.org>;
	Thu,  9 Jun 2011 12:23:09 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:410:227:10ff:fef0:45dc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id E57BB8726F
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 12:23:09 +0200 (CEST)
In-Reply-To: <BANLkTimt0MKyd9ZOqxYm=z91HNS+5B=a1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey Greg,

On 2011. June 7. 04:15:31 Gregory Farnum wrote:
> 2011/6/6 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> > I have a three node ceph setup, two nodes playing all three roles (=
OSD,
> > MDS, MON), and one being just a monitor (which happens to be the cl=
ient
> > I'm using the filesystem from).
> >=20
> > I want to achieve high availablity by mirroring all data between th=
e OSDs
> > and being able to still access everything even if one of them goes =
down.
> > The mirroring works fine, I see the space being consumed on both no=
des
> > as I copy data on the file system. According to `ceph -s`, all PGs =
are
> > in active+clean state. If I start reading a big file and shut down =
one
> > of the (OSD+MDS+MON) nodes, the file can still be read until the en=
d,
> > that's fine. Moreover, the contents read back seem correct when com=
pared
> > to the original file. Very nice. But if I start reading the file wh=
ile
> > one of the nodes is down, it blocks until the node comes up again. =
I
> > can't even kill the reading process with KILL, TERM, or INT.
> >=20
> > Am I doing something wrong, or was not careful enough reading the d=
ocs,
> > or may this be a bug? My ceph.conf is attached.
>=20
> The problem isn't in the OSD, it's the MDS. :)
>=20
> The MDS system is *slightly* less resilient than the OSD system is.
> You can set up "standby" MDSes that will take over if the system
> detects that an MDS has died; you can even set up "standby-replay"
> MDSes that follow a specific MDS and keep all its data cached in
> memory so they can take over right when a failure is detected. But if
> you lose one MDS its data won't automatically be imported into the
> remaining MDSes. (Because the MDS keeps all its data on the OSDs,
> there's no danger of losing data -- it's a matter of how the data is
> segregated that requires a new daemon. And generally the process is
> dominated by the timeout, not the time it takes the new MDS to take
> over.)

Thanks for the clarification. I still have a few questions.

If I understand things correctly, Ceph tries to have max_mds number of =
MDSes=20
active at all times. I can have more MDSes than this number, but the ex=
cess=20
ones will be standby MDSes, right?

I can't really understand the difference between a standby and an activ=
e MDS.=20
Now I have two active and no standby MDSes, and the filesystem stops wo=
rking if=20
I kill any of them. Does this mean that the system will stop working if=
 it=20
can't fill up the number of MDSes to max_mds from the standby pool?

What is the reason for running standby MDSes and not setting max_mds to=
 the=20
number of all MDSes?

> So in your case, you're trying to open a file that is controlled by
> the MDS that you killed, and the client can't get the "capability"
> bits that it needs in order to look at the file. So you've got a few
> options:
> 1) Kill the OSD, but not the MDS.

Well, if a machine crashes, then both fall victim. :(

> 2) Create an extra MDS daemon, perhaps on your monitor node. When the
> system detects that one of your MDSes has died (a configurable
> timeout, IIRC in the neighborhood of 30-60 seconds), this extra daemo=
n
> will take over.

I will do this. Should this be a standby or an active MDS? Ie. should I=
=20
increase max_mds from 2 to 3 after creating the new MDS?

> (Or you can just start up the new daemon after you kill the old one,
> doesn't matter.)
> 3) Create a new system with only one MDS and don't kill that one.
> (Eventually you will be able to shrink the number of MDSes, but this
> isn't well-tested or documented so I'm not sure what state it's in
> right now.)

This is not an option since it will create a SPOF and that's exactly th=
e thing=20
I'm trying to avoid by using Ceph.

Thanks,
--=20
cc

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
