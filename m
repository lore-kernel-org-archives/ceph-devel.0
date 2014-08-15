From: Sage Weil <sweil@redhat.com>
Subject: Re: Import a pg into an already down osd causes it to crash on
 startup
Date: Fri, 15 Aug 2014 11:05:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408151102290.32572@cobra.newdream.net>
References: <CCEA212A-9E44-4D22-A764-8AD5C15E7A76@inktank.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1292573385-1408125919=:32572"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40686 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaHOSFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 14:05:20 -0400
In-Reply-To: <CCEA212A-9E44-4D22-A764-8AD5C15E7A76@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1292573385-1408125919=:32572
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

[switching to ceph-devel]

On Fri, 15 Aug 2014, David Zafman wrote:
>=20
> The way my test works, is that when an osd goes down we export a pg fro=
m it.
> =A0Then we look to see if other OSDs are already down to pick from. =A0=
Since we
> are moving a pg from an OSD that has been up longer than the destinatio=
n
> OSD, that one doesn?t have the maps that the newly imported pg needs.
>=20
> In load_pgs() the get_map() called here asserts:
>=20
> =A0 =A0 dout(10) << "pgid " << pgid << " coll " << coll_t(pgid) << dend=
l;
> =A0 =A0 bufferlist bl;
> =A0 =A0 epoch_t map_epoch =3D PG::peek_map_epoch(store, coll_t(pgid),
> service.infos_oid, &bl);
>=20
> =A0 =A0 PG *pg =3D _open_lock_pg(map_epoch =3D=3D 0 ? osdmap :
> service.get_map(map_epoch), pgid);
>=20
> =A0 OSDMapRef get_map(epoch_t e) {
> =A0 =A0 OSDMapRef ret(try_get_map(e));
> =A0 =A0 assert(ret);
> =A0 =A0 return ret;
> =A0 }
>=20
> osd-3 log
> =A0 =A0 -8> 2014-08-15 10:40:08.516025 7ff2f931d7a0 10 osd.3 61 pgid 1.=
10 coll
> 1.10_head
> =A0 =A0 -7> 2014-08-15 10:40:08.516034 7ff2f931d7a0 15
> filestore(/var/lib/ceph/osd/ceph-3) collection_getattr
> /var/lib/ceph/osd/ceph-3/current/1.10_head 'info'
> =A0 =A0 -6> 2014-08-15 10:40:08.516048 7ff2f931d7a0 10
> filestore(/var/lib/ceph/osd/ceph-3) collection_getattr
> /var/lib/ceph/osd/ceph-3/current/1.10_head 'info' =3D 1
> =A0 =A0 -5> 2014-08-15 10:40:08.516056 7ff2f931d7a0 15
> filestore(/var/lib/ceph/osd/ceph-3) omap_get_values
> meta/16ef7597/infos/head//-1
> =A0 =A0 -4> 2014-08-15 10:40:08.516111 7ff2f931d7a0 20 osd.3 0 get_map =
77 -
> loading and decoding 0x3aea400
> =A0 =A0 -3> 2014-08-15 10:40:08.516120 7ff2f931d7a0 15
> filestore(/var/lib/ceph/osd/ceph-3) read meta/64173f2c/osdmap.77/0//-1 =
0~0
> =A0 =A0 -2> 2014-08-15 10:40:08.516165 7ff2f931d7a0 10
> filestore(/var/lib/ceph/osd/ceph-3) error opening file
> /var/lib/ceph/osd/ceph-3/current/meta/osdmap.77__0_64173F2C__none with
> flags=3D2: (2) No such file or directory
> =A0 =A0 -1> 2014-08-15 10:40:08.516246 7ff2f931d7a0 10
> filestore(/var/lib/ceph/osd/ceph-3)
> FileStore::read(meta/64173f2c/osdmap.77/0//-1) open error: (2) No such =
file
> or directory
> =A0 =A0 =A00> 2014-08-15 10:40:08.517093 7ff2f931d7a0 -1 osd/OSD.h: In =
function
> 'OSDMapRef OSDService::get_map(epoch_t)' thread 7ff2f931d7a0 time 2014-=
08-15
> 10:40:08.516268
> osd/OSD.h: 729: FAILED assert(ret)
>=20
> =A0ceph version 0.83-731-g50e1ed0 (50e1ed04a1a48d653f11829fdf7e0f3954a2=
4f97)
> =A01: (OSD::load_pgs()+0x23b1) [0x660551]
> =A02: (OSD::init()+0x19d5) [0x663145]
> =A03: (main()+0x35ec) [0x6019fc]
> =A04: (__libc_start_main()+0xfd) [0x379ae1ed1d]
> =A05: ceph-osd() [0x5fe059]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to
> interpret this.

Maybe we also need a export and import maps functions.  Then there would=20
be a check on import that the osd has at least the map that the PG needs.=
 =20
And on OSD startup, the existing code in the OSD will (I think) get all o=
f=20
the PGs to consume the new maps if they are present.

The main challenge would then be to make sure that we export=20
enough maps with the PG that the import will succeed (so we don't have to=
=20
retry or something).  Maybe the thrasher would grab the current epoch eac=
h=20
time it starts a new episode of thrashing and always export maps back to=20
that point (when we were last active+clean) to ensure it's enough ...

sage

--557981400-1292573385-1408125919=:32572--
