From: Sage Weil <sage@newdream.net>
Subject: Re: Client can't unmount, some pinned dentries in cache.
Date: Thu, 12 Jan 2012 09:22:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201120922010.18796@cobra.newdream.net>
References: <CAADCt4LZSayxYfWmQ7He09eSxkvBzh-5FyB2hyDkUcBCsCjTGg@mail.gmail.com>
 <CAADCt4LwdnVeXBZRP1-WO_2XnXAKvZ0KThF5Hk_tZGh2X0=MDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-649790279-1326388942=:18796"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57606 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALRWX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 12:22:23 -0500
In-Reply-To: <CAADCt4LwdnVeXBZRP1-WO_2XnXAKvZ0KThF5Hk_tZGh2X0=MDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-649790279-1326388942=:18796
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Jan 2012, Andrey Stepachev wrote:
> Hi all.
>=20
> I've drill down this bug. Ceph issues ->get() on inode in
> ctor
>=20
> dir_result_t::dir_result_t(Inode *in)
>   : inode(in), offset(0), next_offset(2),
>     release_count(0), start_shared_gen(0),
>     buffer(0) {
>   inode->get();
> }
>=20
> But don't deref in destructor. So it hard to
> see, that problem can be in code like this
>=20
> int Client::_opendir(Inode *in, dir_result_t **dirpp, int uid, int gid)
> {
>   *dirpp =3D new dir_result_t(in);
>   if (!in->is_dir())
>     return -ENOTDIR;
> ...
> }
>=20
> Patch attached.

Wonderful!

I can add your Signed-off-by: to the patch, I assume?

Thanks!
sage


>=20
> 2012/1/11 Andrey Stepachev <octo47@gmail.com>:
> > Hi all.
> >
> > I have client hangs on unmount. Logs show, that
> > some pinned entries in cache exists, but I can't understand
> > what is going on and why they still referenced.
> >
> > 2012-01-11 15:29:27.168712 7f32f6ffd700 client.4915 unmounting: trim
> > pass, size was 0+6
> > 2012-01-11 15:29:27.168729 7f32f6ffd700 client.4915 unmounting: trim
> > pass, size still 0+6
> > 2012-01-11 15:29:27.168751 7f32f6ffd700 client.4915 dump_cache: inode
> > 10000007dc3.head ref 1 dir 0 10000007dc3.head(ref=3D1
> > cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> > mtime=3D2012-01-11 15:13:53.624282 caps=3Dp(0=3Dp) objectset[10000007dc=
3 ts
> > 0/0 objects 1 dirty_or_tx 0] 0x1210d80)
> > 2012-01-11 15:29:27.168767 7f32f6ffd700 client.4915 dump_cache: inode
> > 10000007586.head ref 1 dir 0 10000007586.head(ref=3D1
> > cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D714
> > mtime=3D2012-01-11 12:39:00.960535 caps=3Dp(0=3Dp) objectset[1000000758=
6 ts
> > 0/0 objects 1 dirty_or_tx 0] 0x166d370)
> > 2012-01-11 15:29:27.168779 7f32f6ffd700 client.4915 dump_cache: inode
> > 1000000758d.head ref 1 dir 0 1000000758d.head(ref=3D1
> > cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> > mtime=3D2012-01-11 15:25:09.622986 caps=3Dp(0=3Dp) objectset[1000000758=
d ts
> > 0/0 objects 1 dirty_or_tx 0] 0x12111c0)
> > 2012-01-11 15:29:27.168791 7f32f6ffd700 client.4915 dump_cache: inode
> > 100000079df.head ref 2 dir 0 100000079df.head(ref=3D2
> > cap_refs=3D{1024=3D0,2048=3D0,4096=3D0,8192=3D0} open=3D{1=3D0,2=3D0} m=
ode=3D100777
> > size=3D1089 mtime=3D2012-01-11 15:26:23.780076 caps=3Dp(0=3Dp)
> > objectset[100000079df ts 0/0 objects 1 dirty_or_tx 0] 0x12a99b0)
> > 2012-01-11 15:29:27.168803 7f32f6ffd700 client.4915 dump_cache: inode
> > 100000079e0.head ref 2 dir 0 100000079e0.head(ref=3D2
> > cap_refs=3D{1024=3D0,2048=3D0,4096=3D0,8192=3D0} open=3D{1=3D0,2=3D0} m=
ode=3D100777
> > size=3D734 mtime=3D2012-01-11 15:27:13.887592 caps=3Dp(0=3Dp)
> > objectset[100000079e0 ts 0/0 objects 0 dirty_or_tx 0] 0x7f32f833cb00)
> > 2012-01-11 15:29:27.168814 7f32f6ffd700 client.4915 dump_cache: inode
> > 100000079d7.head ref 1 dir 0 100000079d7.head(ref=3D1
> > cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> > mtime=3D2012-01-11 12:40:14.325753 caps=3Dp(0=3Dp) objectset[100000079d=
7 ts
> > 0/0 objects 1 dirty_or_tx 0] 0x1211750)
> >
> > --
> > Andrey.
>=20
>=20
>=20
> --=20
> =FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF.
>=20
--557981400-649790279-1326388942=:18796--
