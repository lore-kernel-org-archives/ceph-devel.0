From: Sage Weil <sage@newdream.net>
Subject: Re: cephx questions
Date: Fri, 30 Jul 2010 16:07:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007301553230.28085@cobra.newdream.net>
References: <7083006A98B5314F86152D05FFB1B99814AAEF06FF@ICE-MBX-2.ice.nd.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-76679441-1280531267=:28085"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0G3XFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 19:05:12 -0400
In-Reply-To: <7083006A98B5314F86152D05FFB1B99814AAEF06FF@ICE-MBX-2.ice.nd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Regola <nregola@nd.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-76679441-1280531267=:28085
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Jul 2010, Nathan Regola wrote:
> Hi,
>=20
> Thank you for this excellent project.=A0 Are you still planning on=20
> incorporating the code from the Maat paper at some time in the future?=20
> As I'm sure you already know, access control lists on the storage=20
> objects would be quite useful to store research data.=A0

We may.  The question is what granularity of security people really need. =
=20
Maat essentially gives fine-grains access control on individual objects=20
storing file data, based on the user you are logged in as on the client. =
=20
But in order for this to be very useful, you need some additional=20
user-level distributed authentiation scheme like Kerberos, or else a=20
misbehaving client can pose as any user on that host.  Currently, the=20
kernel client authenticates to cephx and is given a capability to access=20
all objects in the file system object pool.. the same set of objects it=20
can access by traversing the namespace as 'root'.  It doesn't get access=20
to other object pools in the distributed object store (e.g., metadata=20
objects, rbd images, or other pools you may create).

What kind of objects (or files?) do you want to protect with ACLs?  Do you=
=20
need object granularity, or is pool granularity sufficient?

> We are experimenting with a small ceph cluster (3 older Sun V20z servers=
=20
> with 2 SCSI drives each). To give you a brief overview of our setup, we=
=20
> have one MDS/monitoring node and 2 OSDs.=A0 The OSDs have 16GB of RAM and=
=20
> the MDS/monitoring node has 12GB.=A0 We are using btrfs on a dedicated=20
> drive, mounted as /btrfs (each node has this mount). On the OSDs, we=20
> also use a partition on the boot disk as /btrfs_journal for the journal=
=20
> and the data is on the second drive, mounted as /btrfs.=A0 We only have=
=20
> toy data on the file system, so we can reformat the ceph file system as=
=20
> needed. =A0 We attempted an in place upgrade to 0.21 yesterday.=A0 =A0Upo=
n=20
> restarting the ceph processes on the MDS/monitoring node, we could no=20
> longer login to ceph due to cephx authentication failure.=A0 We did not=
=20
> change the configuration in /etc/ceph/ceph.conf. I was able to disable=20
> cephx, and eventually imported some keys and put the admin_keyring.bin=20
> file in /etc/ceph/keyring.bin and I can login now.=A0 Was the code change=
d=20
> to enforce cephx or stop looking in certain locations for keys?=A0 I=20
> believe it was enabled before, but it never complained.

Ah, I suspect that you had/have

=09auth supported =3D cephx

in your ceph, which is what the wiki had in the sample ceph.conf.  The=20
code in v0.20.* was actually looking for 'supported auth', though (fixed=20
in v0.21).  The cephx stuff was probably just turned off before now, and=20
you didn't notice that your admin keyring wasn't in place.

> Also, what causes an MDS to be blacklisted?=A0 Until I fixed the=20
> authentication issues, "ceph mds stat" returned "3 blacklisted MDS".=A0 W=
e=20

Any time an mds crashes (or is declared crashed by the monitor, due to not=
=20
sending regular heartbeats), it's address is blacklisted in the osd map to=
=20
prevent a runaway/stale process from interfering with a new cmds instance. =
=20
It's completely normal.  The entry will be expired on its own after=20
several (24?) hours.

> I was interested in more detailed information on cephx (where is the=20
> auth database stored) and what the various keyring lines in the=20
> ceph.conf file control.

The monitor keeps the auth data in $mon_data/auth/*.  It's not in a form=20
that you can manipulate manually, unfortunately.

> Also, is there a baseline sample of what your=20
> "ceph auth list" output should look like and the minimum capabilities=20
> various entities need to function?

The cauthtool man page has a minimal set of caps for a machine to mount=20
the file system.  Basically,

client.foo
        key: asdf
        caps: [mds] allow
        caps: [mon] allow r
        caps: [osd] allow rw; allow rw pool=3D0

Or, if you're lazy, you can just use the client.admin key.  Just be sure=20
to specify both name=3Dadmin,secret=3Dasdf (or name=3Dfoo,secret=3Dasdf, if=
 using=20
the above) as a mount option.  (The 'client.' name prefix is assumed.)

I hope that answers your questions?
sage


> I pasted a redacted version of our=20
> "auth list" output below. Perhaps we have an error in our authorization=
=20
> list that caused the errors we experienced after the upgrade (and before=
=20
> I changed some things).=A0 I can send a ceph.conf file as well if you nee=
d=20
> it.=A0
>=20
> We can provide feedback on cephx code if you need it, as we were=20
> planning on keeping our cluster "cephx enabled".=A0
>=20
> Thanks,
>=20
> Nathan Regola
> Grid and Cloud Computing Analyst
> University of Notre Dame
> Center for Research Computing
> P.O. Box 539
> Room 110 Information Technology Center
> Notre Dame, IN=A0 46556
>=20
> Phone: 574-631-5287
>=20
>=20
> 10.07.30_13:07:08.584179 mon <- [auth,list]
> 10.07.30_13:07:08.584825 mon0 -> 'installed auth entries:=20
> mon.0
> =A0=A0=A0=A0=A0=A0=A0 key: T
> =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
> mds.opteron03
> =A0=A0=A0=A0=A0=A0=A0 key: U
> =A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
> =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> osd.0
> =A0=A0=A0=A0=A0=A0=A0 key: V
> =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> osd.1
> =A0=A0=A0=A0=A0=A0=A0 key: W
> =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> client.admin
> =A0=A0=A0=A0=A0=A0=A0 key: X
> =A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
> =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
> =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> ' (0)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-76679441-1280531267=:28085--
