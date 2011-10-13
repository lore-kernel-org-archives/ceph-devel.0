From: =?UTF-8?B?56iL6IyC?= <chengmao2010@gmail.com>
Subject: =?UTF-8?Q?Can_read_and_write_on_the_same_connection_at_the_sam?=
	=?UTF-8?Q?e_time=EF=BC=9F?=
Date: Thu, 13 Oct 2011 21:27:30 +0800
Message-ID: <CAGiyNfARcfqw4hnVnT0JBRJ+SkbUt71=Ls5R+pgnQ6L8K+_PfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44696 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1JMN1c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2011 09:27:32 -0400
Received: by eye27 with SMTP id 27so1832645eye.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2011 06:27:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

kclient will establish only one connection with each osd=EF=BC=8Cbut th=
ere is
a mutex in the ceph_connection.

partial code about con_work

static void con_work(struct work_struct *work)
{
struct ceph_connection *con =3D container_of(work, struct ceph_connecti=
on,
=C2=A0=C2=A0work.work);
mutex_lock(&con->mutex);
=E2=80=A6=E2=80=A6
=C2=A0=C2=A0 =C2=A0 =C2=A0if (test_and_clear_bit(SOCK_CLOSED, &con->sta=
te) ||
=C2=A0=C2=A0 try_read(con) < 0 ||
=C2=A0=C2=A0 try_write(con) < 0) {
mutex_unlock(&con->mutex);
bsdocfs_fault(con); =C2=A0 =C2=A0 /* error/fault path */
goto done_unlocked;
}
=E2=80=A6=E2=80=A6
}

if kclient read data from osdN=EF=BC=8Ccan kclient write data to osdN a=
t the same time=EF=BC=9F
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
