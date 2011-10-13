From: Sage Weil <sage@newdream.net>
Subject: Re: =?UTF-8?Q?Can_read_and_write_on_the_same_connection_at_the_sam?=
 =?UTF-8?Q?e_time=EF=BC=9F?=
Date: Thu, 13 Oct 2011 08:29:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110130824190.7714@cobra.newdream.net>
References: <CAGiyNfARcfqw4hnVnT0JBRJ+SkbUt71=Ls5R+pgnQ6L8K+_PfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1365312071-1318519766=:7714"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37555 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1JMP32 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2011 11:29:28 -0400
In-Reply-To: <CAGiyNfARcfqw4hnVnT0JBRJ+SkbUt71=Ls5R+pgnQ6L8K+_PfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?56iL6IyC?= <chengmao2010@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1365312071-1318519766=:7714
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Oct 2011,  wrote:
> kclient will establish only one connection with each osd=FF=FFbut there i=
s
> a mutex in the ceph_connection.
>=20
> partial code about con_work
>=20
> static void con_work(struct work_struct *work)
> {
> struct ceph_connection *con =3D container_of(work, struct ceph_connection=
,
> =A0=A0work.work);
> mutex_lock(&con->mutex);
> =FF=FF=FF=FF
> =A0=A0 =A0 =A0if (test_and_clear_bit(SOCK_CLOSED, &con->state) ||
> =A0=A0 try_read(con) < 0 ||
> =A0=A0 try_write(con) < 0) {
> mutex_unlock(&con->mutex);
> bsdocfs_fault(con); =A0 =A0 /* error/fault path */
> goto done_unlocked;
> }
> =FF=FF=FF=FF
> }
>=20
> if kclient read data from osdN=FF=FFcan kclient write data to osdN at the=
=20
> same time=FF=FF

Yes.  The messenger code wakes up whenever there is new data queued to=20
send, or new data available on the socket.  We only ever read or write as=
=20
much data as we can without emptying or filling the socket buffer at a=20
time.  We never block on network IO, so the mutex is only ever held for=20
very short periods.  The model is asynchronous message passing.  We have a=
=20
queue of outgoing messages that we send as quickly as the socket will=20
accept them, and when a complete incoming message is read we process it.

sage
--557981400-1365312071-1318519766=:7714--
