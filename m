From: Sage Weil <sage@newdream.net>
Subject: Re: Long tail latency due to journal aio io_submit takes long time
 to return
Date: Tue, 25 Aug 2015 06:10:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508250609120.13116@cobra.newdream.net>
References: <SNT146-W82DA23C3C4087E77B0317F8C610@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-781116966-1440508219=:13116"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43293 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbHYNKU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 09:10:20 -0400
In-Reply-To: <SNT146-W82DA23C3C4087E77B0317F8C610@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-781116966-1440508219=:13116
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2015, Z Zhang wrote:
> Hi Ceph-devel,
>=20
> Recently we find there are some (not much) long tail latency due to=20
> journal aio io_submit takes long time to return. We added some logs in=20
> the FileJouranl.cc and get following output as an example. AIO's=20
> io_submit function takes ~400ms to return, occasionally even takes up t=
o=20
> 900ms.
>=20
> ------------------------------------------------------------
> 2015-08-25 15:24:39.535206 7f22699c2700 20 journal write_thread_entry w=
oke up
> 2015-08-25 15:24:39.535212 7f22699c2700 10 journal room 10460594175 max=
_size 10484711424 pos 4786679808 header.start 4762566656 top 4096
> 2015-08-25 15:24:39.535215 7f22699c2700 10 journal check_for_full at 47=
86679808 : 532480 < 10460594175
> 2015-08-25 15:24:39.535216 7f22699c2700 15 journal prepare_single_write=
 1 will write 4786679808 : seq 13075224 len 526537 -> 532480 (head 40 pre=
_pad 4046 ebl 526537 post_pad 1817 tail 40) (ebl alignment 4086)
> 2015-08-25 15:24:39.535322 7f22699c2700 20 journal prepare_multi_write =
queue_pos now 4787212288
> 2015-08-25 15:24:39.535324 7f22699c2700 15 journal do_aio_write writing=
 4786679808~532480
> 2015-08-25 15:24:39.535434 7f22699c2700 10 journal align_bl total memco=
py: 532480
> 2015-08-25 15:24:39.535439 7f22699c2700 20 journal write_aio_bl 4786679=
808~532480 seq 13075224
> 2015-08-25 15:24:39.535442 7f22699c2700 20 journal write_aio_bl .. 4786=
679808~532480 in 1
> 2015-08-25 15:24:39.535444 7f22699c2700 =A05 journal io_submit starting=
...
>=20
> 2015-08-25 15:24:39.990372 7f22699c2700 =A05 journal io_submit return v=
alue: 1
> 2015-08-25 15:24:39.990396 7f22699c2700 =A05 journal put_throttle finis=
hed 1 ops and 526537 bytes, now 12 ops and 6318444 bytes
> 2015-08-25 15:24:39.990401 7f22691c1700 20 journal write_finish_thread_=
entry waiting for aio(s)
> 2015-08-25 15:24:39.990406 7f22699c2700 20 journal write_thread_entry a=
io throttle: aio num 1 bytes 532480 ... exp 2 min_new 4 ... pending 63184=
44
> 2015-08-25 15:24:39.990410 7f22699c2700 10 journal room 10460061695 max=
_size 10484711424 pos 4787212288 header.start 4762566656 top 4096
> 2015-08-25 15:24:39.990413 7f22699c2700 10 journal check_for_full at 47=
87212288 : 532480 < 10460061695
> 2015-08-25 15:24:39.990415 7f22699c2700 15 journal prepare_single_write=
 1 will write 4787212288 : seq 13075225 len 526537 -> 532480 (head 40 pre=
_pad 4046 ebl 526537 post_pad 1817 tail 40) (ebl alignment 4086)
> ------------------------------------------------------------

This is probably the kernel throttling us because the request queue is=20
full / device is busy / whatever.
=20
> And write_aio_bl will hold aio_lock until it returns, so=20
> write_finish_thread_entry can't process completed aio when io_submit is=
=20
> blocking. We reduced the aio_lock's locking scope in=20
> write_aio_bl,=A0specifically not locking io_submit. It doesn't seem to=20
> need lock on io_submit in journal because there is only 1=20
> write_thread_entry and 1 write_finish_thread_entry.=A0
>
> This might help those completed aio to get processed asap. But for the=20
> one blocked in io_submit and the ones in the queue, they still need to=20
> take more time.
>=20
> Any idea about this?=A0

That sounds like the right fix!  I don't think there is anything else to=20
be done.. if the kernel is throttling us it's generally for a good reason=
,=20
and there isn't anything else we can do.

Do you have a patch?

sage
--557981400-781116966-1440508219=:13116--
