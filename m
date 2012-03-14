From: Sage Weil <sage@newdream.net>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Wed, 14 Mar 2012 10:56:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203141052350.11925@cobra.newdream.net>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com>
 <loom.20120314T052312-964@post.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1379884912-1331747794=:11925"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53008 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761183Ab2CNR4f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 13:56:35 -0400
In-Reply-To: <loom.20120314T052312-964@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1379884912-1331747794=:11925
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 Mar 2012, madhusudhana wrote:
> Jo=E3o Eduardo Lu=EDs <jecluis <at> gmail.com> writes:
> > On 03/13/2012 10:39 AM, madhusudhana wrote:
> > > Hi all,
> > > Can someone PLEASE help me to understand why data copying (simple cp
> > > or rsync) is SO slow in CEPH ? And delete command (\rm -rf) for remov=
ing
> > > a small (175M) directory is taking so much of time. Because of this,
> > > i am not able to complete evaluation of ceph using my actual workload=
=2E=20
> > >=20
> > > I am hereby requesting all to help me in finding out the reason for=
=20
> > > slow write/delete in my ceph cluster. I am really trying hard to=20
> > > complete the evaluation with actual workload but not able to copy the
> > > data whats required for evaluation to ceph cluster bcz of slow copy.
> > >=20
> > > I really appreciate any help on this.
> > >=20
> > > Thanks in advance
> > > Madhusudhan
> > >=20
> >=20
> > Hi Madhusudhan,
> >=20
> > Are you using Btrfs? And are you taking snapshots while you're
> > performing those operations?
> >=20
> Joao,
> Yes. all my OSD's are running on btrfs. I am not doing anything special
> except running 'cp' or 'rsync' command. can you please let me know how
> i can find if am taking snapshots while I do 'cp' or 'rsync' commands ?
>=20
> One more concern is 'rm' command is also TOO slow. I am a newbie here and=
=20
> i don't know to much about ceph working. I configured it in a simple way.
> Install ceph and run mkcephfs and start ceph in all the servers in the=20
> cluster.
>=20
> I want to understand why basic operations like 'cp' and 'rm' are slow bcz=
=20
> my actual workload does a lot of copy and delete operation. If I find the
> reason for the slowness and get a fix, then I think i can better compare =
and=20
> complete my ceph evaluation.=20

There are a range of reasons why this could be slow, and unfortunately we=
=20
don't have enough information to tell what is the problem.=20

First, see what the OSD performance looks like.  Output from, say,

 rados -p rbd bench 60 write
 rados -p rbd bench 60 write -b 4096

will give us a sense of what the object store performance looks like.

The other big question is which client you're using.. since you have=20
ceph-fuse problems, I assume you're using the kernel client?  Which kernel=
=20
version, etc.  If it's MDS performance the way to diagnose would probably=
=20
be to gather a message log initially ('debug ms =3D 1' on the [mds] section=
=20
of ceph.conf) to see what the client/mds interaction looks like.  MDS=20
performance isn't something we have very much time to spend on right now,=
=20
though, since our focus in primarily RADOS and RBD stability currently=20
(unless you want to talk to the professional services side of things,=20
info@ceph.com).

The first step, though, is to figure out if this is an OSD or MDS=20
performance issue...

sage
--557981400-1379884912-1331747794=:11925--
