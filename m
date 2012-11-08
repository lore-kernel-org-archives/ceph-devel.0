From: Sage Weil <sage@inktank.com>
Subject: Re: some snapshot problems
Date: Thu, 8 Nov 2012 09:30:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-543502450-1352108370=:14104"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59107 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2KHRa4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 12:30:56 -0500
In-Reply-To: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1211080738480.15418@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liu yaqi <liuyaqiyaqi@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-543502450-1352108370=:14104
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1211080738481.15418@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

Hi Liu,

Sorry for the late reply; I have had a very busy week.  :)

On Thu, 1 Nov 2012, liu yaqi wrote:
> Dear Mr.Weil
>=20
> I am a student of Institute of Computing Technology, Chinese Academy of
> Sciences, and I am learning the realization of snapshot in ceph system.
> There are sometings that puzzle me, and I want to ask you some question=
s.
> First question, there is a command "ceph osd cluster_snap {name}", but =
i
> cannot found the complete realization process, and I want to ask is the
> snapshot for the whole cluster has been=A0 realized?

The idea was to have a low-level cluster-wide snapshot that could be used=
=20
for recovery if ceph itself went haywire and corrupted itself.  The idea=20
would be for the OSDs to create btrfs-level snapshots of their data.  It=20
was never completely implemented, though, and the OSD bits have mostly=20
been removed.  In particular, we never made a way for the monitor state t=
o=20
be checkpointed, which would be necessary for the whole scheme to work=20
properly.

> Second question, there
> seems to be snapshots for pools and images. I want to ask what does poo=
l and
> image mean? Is an image means an osd?

Lots of different snapshots:

 - librados lets you do 'selfmanaged snaps' in its API, which let an=20
   application control which snapshots apply to which objects.=20
 - you can create a 'pool' snapshot on an entire librados pool.  this=20
   cannot be used at the same time as rbd, fs, or the above 'selfmanaged'=
=20
   snaps.
 - rbd let's you snapshot block device images (by usuing the librados=20
   selfmanaged snap API).
 - the ceph file system let's you snapshot any subdirectory (again=20
   utilizing the underlying RADOS functionality).

> Third question, in the "mds" folder,
> there are files like "snapserver" "MClientSnap" and so on, is there fil=
es
> are used to snapshot the metadata only?=20

Yes.

> Does they have some relationship
> with the pool or image snapshots?=A0

Not really.

> The last question, is there snapshots
> for a file path in the ceph? Or, the snapshots must be done on metadata=
 and
> data=A0 separately?

For the file system, you create a snapshot on a directory and it affects=20
all files in that directory and beneath it, including the data in those=20
files.

Hope that helps!
sage

> If you would kind enough to help me on the above questions, I will be
> grateful. And I am looking forward to your reply.
>=20
> With best wishes for you.
>=20
> Yours, YaqiLiu
>=20
--557981400-543502450-1352108370=:14104--
