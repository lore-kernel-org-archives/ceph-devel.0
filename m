From: Sage Weil <sage@newdream.net>
Subject: Re: proposed C API for librados
Date: Thu, 24 Feb 2011 07:25:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102240720440.28922@cobra.newdream.net>
References: <AANLkTi=qvZjPOHkZbPem0TPjovGiqNo7Arq=q2YqEWDS@mail.gmail.com>
 <4D65FCD6.1070100@ormod.com> <AANLkTikhrQkwMaEf_4495KZn22QrQ7u4hxVo8Mn4tx1R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2020519407-1298561122=:28922"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50352 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1BXPXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 10:23:44 -0500
In-Reply-To: <AANLkTikhrQkwMaEf_4495KZn22QrQ7u4hxVo8Mn4tx1R@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Hannu Valtonen <me@ormod.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2020519407-1298561122=:28922
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Feb 2011, Colin McCabe wrote:
> Yeah, should add something like that. Maybe something like this:
>=20
> int rados_pool_list(rados_t cluster, char ***pools)
> void rados_pool_list_free(char **pools)
>
> Also should rename
> rados_snap_set_read -> rados_snap_set_read_context for consistency.

Well, on the read side, it's not actually a context.  You just need to=20
specify a snapid.  On the write side, the context tells the OSDs which=20
snapshots to keep/cow when doing a write.  You can't write to a snapshot. =
=20
I'm not sure the details are relevant to API users, but at the very least=
=20
I don't think there is a clear symmetry between the read/write side to=20
make the calls look consistent.  This way it's clear they're not...

Also,

> >> int rados_write(rados_pool_t pool, const char *oid, off_t off, const
> >> char *buf, size_t len);
> >> int rados_write_full(rados_pool_t pool, const char *oid, off_t off,
> >> const char *buf, size_t len);
> >> int rados_read(rados_pool_t pool, const char *oid, off_t off, char
> >> *buf, size_t len);

> >> int rados_aio_write(rados_pool_t pool, const char *oid,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0off_t off, const char *buf, siz=
e_t len,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rados_completion_t completion);
> >> int rados_aio_write_full(rados_pool_t pool, const char *oid,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 off_t off, const char =
*buf, size_t len,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_completion_t com=
pletion);
> >> int rados_aio_read(rados_pool_t pool, const char *oid,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 off_t off, char *buf, size_t len,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_completion_t completion);

The argument order for these is weird... not quite sure what I was=20
thinking.  Let's do whatever pread and pwrite do?

sage
--557981400-2020519407-1298561122=:28922--
