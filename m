From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Re: Active vs. standby MDSes (Was: Re: Degraded PGs blocking open()?)
Date: Tue, 21 Jun 2011 17:04:16 +0200
Message-ID: <201106211704.16928.szekelyi@niif.hu>
References: <201106070237.34854.szekelyi@niif.hu> <201106091223.08914.szekelyi@niif.hu> <BANLkTimESfkKJbyFbzpZfK_W8dbshDeGmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:54639 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab1FUPE3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2011 11:04:29 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by mail.ki.iif.hu (Postfix) with ESMTP id 805A0874EA
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2011 17:04:27 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id EfX3bYr4toLs for <ceph-devel@vger.kernel.org>;
	Tue, 21 Jun 2011 17:04:24 +0200 (CEST)
Received: from mranderson.localnet (mac-020000000407.vm-nc-11.vm.cloud.hbone.hu [193.225.36.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id A6B1487554
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2011 17:04:20 +0200 (CEST)
In-Reply-To: <BANLkTimESfkKJbyFbzpZfK_W8dbshDeGmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Greg,

finally I had some time to try what you suggested. Adding a standby MDS=
 fixed=20
the problem.

Thanks a lot for your detailed clarification and excellent support. So =
far I=20
couldn't find any SPOF in the system. Killing any daemon still kept the=
=20
filesystem running and all the data available provided that it was=20
theoretically possible. After the failure was corrected, the system was=
 able=20
to fully recover. I did things like stopping and starting the daemons w=
hile=20
writing to or reading from the filesystem, comparing read back data wit=
h the=20
original.

Thanks & keep up the good work,
--=20
cc

On 2011. June 9. 18:16:38 Gregory Farnum wrote:
> So the Ceph MDS system is a little odd. Presumably you are aware that
> file data is stored as chunks (default 4MB) in objects on RADOS (ie,
> the OSD system). Metadata is also stored on RADOS, where each
> directory is a single object that contains all the inodes underneath
> it.
> In principle you could construct a filesystem that simply accessed
> this on-disk metadata every time it changed everything. However, that
> would be slow for a number of reasons. To speed up metadata ops, we
> have the MetaData Server. Essentially, it does 3 things:
> 1) Cache the metadata in-memory to speed up read accesses.
> 2) Handle client locking of data/metadata accesses (this is the
> capabilities system)
> 3) Journal metadata write operations so that we can get streaming
> write latencies instead of random lookup-and-write latencies on
> changes.
>=20
> When you have multiple active MDSes, they partition the namespace so
> that any given directory has a single "authoritative" MDS which is
> responsible for handling requests. This simplifies locking and
> prevents the MDSes from duplicating inodes in-cache. You can add MDSe=
s
> by increasing the max_mds number. (Most of the machinery is there to
> reduce the number of MDSes too, but it's not all tied together.)
>=20
> So you can see that if one daemon dies you're going to lose access to
> the metadata it's responsible for. :( HOWEVER, all the data it's
> "responsible" for resides in RADOS so you haven't actually lost any
> state or the ability to access it, just the authorization to do so. S=
o
> we introduce standby and standby-replay MDSes. If you have more MDS
> daemons than max_mds, the first max_mds daemons will start up and
> become active and the rest will sit around as standbys. The monitor
> service knows they exist and are available, but they don't do anythin=
g
> until an active MDS dies. If an active MDS does die, the monitor
> assigns one of the standbys to take over for that MDS -- it becomes
> the same logical MDS but on a different host (or not, if you're
> running multiple daemons on the same host or whatever). It goes
> through a set of replay stages and then operates normally.
> If this makes you shudder in horror from previous experiences with th=
e
> HDFS standby or something, fear not. :) We haven't done comprehensive
> tests but replay is generally pretty short -- our default timeout on
> an MDS is in the region of 30 seconds and I don't think I've ever see=
n
> replay take more than 45.
> If you want to reduce the time it takes even further you can assign
> certain daemons to be in standby-replay mode. In this mode they
> actively replay the journal of an active MDS and maintain the same
> cache, so if the active MDS fails they only need to go through the
> client reconnect stage.
> Also remember that during this time access to metadata which resides
> on other non-failed MDSes goes on uninterrupted. :)
>=20
> In principle we could do some whiz-bang coding so that if an MDS fail=
s
> another active MDS takes over responsibility for its data and then
> repartitions it out to the rest of the cluster, but that's not
> something we're likely to do for a while given the complexity and the
> relatively small advantage over using standby daemons.
>=20
> So going through your questions specifically:
>=20
> 2011/6/9 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> > If I understand things correctly, Ceph tries to have max_mds number=
 of
> > MDSes active at all times. I can have more MDSes than this number, =
but
> > the excess ones will be standby MDSes, right?
>=20
> Right.
>=20
> > I can't really understand the difference between a standby and an a=
ctive
> > MDS. Now I have two active and no standby MDSes, and the filesystem
> > stops working if I kill any of them. Does this mean that the system=
 will
> > stop working if it can't fill up the number of MDSes to max_mds fro=
m the
> > standby pool?
>=20
> Hopefully the above answered this for you a little more precisely, bu=
t
> the short answer is yes.
>=20
> > What is the reason for running standby MDSes and not setting max_md=
s to
> > the number of all MDSes?
>=20
> Again, hopefully you got this above. But it increases system
> resiliency in the case of a failure.
>=20
> >> 2) Create an extra MDS daemon, perhaps on your monitor node. When =
the
> >> system detects that one of your MDSes has died (a configurable
> >> timeout, IIRC in the neighborhood of 30-60 seconds), this extra da=
emon
> >> will take over.
> >=20
> > I will do this. Should this be a standby or an active MDS? Ie. shou=
ld I
> > increase max_mds from 2 to 3 after creating the new MDS?
>=20
> Standby -- don't increase max_mds.
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
