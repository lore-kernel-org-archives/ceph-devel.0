From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Thu, 29 Jan 2015 14:51:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1321034726-1422571876=:3895"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34145 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbbA2WvR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 17:51:17 -0500
In-Reply-To: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>
Cc: ceph-devel@vger.kernel.org, haomaiwang@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1321034726-1422571876=:3895
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

[Moving this thread to ceph-devel, which is probably a bit more=20
appropriate.]

On Thu, 29 Jan 2015, Chris Pacejo wrote:
> Hi, we've been experimenting with the keyvaluestore backend, and have f=
ound
> that, on every object write (e.g. with `rados put`), a single transacti=
on is
> issued containing an additional 9 KeyValueDB writes, beyond those which
> constitute the object data.=C2=A0 Given the key names, these are clearl=
y all
> metadata of some sort, but this poses a problem when the objects themse=
lves
> are very small.=C2=A0 Given the default strip block size of 4 KiB, with=
 objects
> of size 36 KiB or less, half or more of all key-value store writes are
> metadata writes.=C2=A0 With objects of size 4 KiB or less, the metadata=
 overhead
> grows to 90%+.
>=20
> Is there any way to reduce the number of metadata rows which must be wr=
itten
> with each object?

There is a level (or two) of indirection in KeyValueStore's=20
GenericObjectMap that is there to allow object cloning.  I wonder if we=20
will want to facilitate a backend that doesn't implement clone and can=20
only be used for pools that disallow clone and snap operations.

There is also some key consolidation in the OSD layer we talked about in=20
the wednesday performance call that will cut this down some!

> (Alternatively, if there is a way to convince the OSD to issue multiple
> concurrent write transactions, that would also help.=C2=A0 But even wit=
h
> "keyvaluestore op threads" set as high as 64, and `rados bench` issuing=
 64
> concurrent writes, we never see more than a single active write transac=
tion
> on the (multithread-capable) backend.=C2=A0 Is there some other option =
we're
> missing?)

sage
--557981400-1321034726-1422571876=:3895--
