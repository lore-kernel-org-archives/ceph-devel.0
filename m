From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: radosgw crash within libfcgi
Date: Wed, 24 Jun 2015 14:40:25 -0400 (EDT)
Message-ID: <460832233.19349487.1435171225932.JavaMail.zimbra@redhat.com>
References: <BLU175-W1310E96C473E9ABED62D65DFAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:59957 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbFXSk2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 14:40:28 -0400
In-Reply-To: <BLU175-W1310E96C473E9ABED62D65DFAF0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com



----- Original Message -----
> From: "GuangYang" <yguang11@outlook.com>
> To: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com, yehuda@red=
hat.com
> Sent: Wednesday, June 24, 2015 10:09:58 AM
> Subject: radosgw crash within libfcgi
>=20
> Hello Cephers,
> Recently we have several radosgw daemon crashes with the same followi=
ng
> kernel log:
>=20
> Jun 23 14:17:38 xxx kernel: radosgw[68180]: segfault at f0 ip
> 00007ffa069996f2 sp 00007ff55c432710 error 6 in
> libfcgi.so.0.0.0[7ffa06995000+a000] in libfcgi.so.0.0.0[7ffa06995000+=
a000]
>=20
> Looking at the assembly, it seems crashing at this point -
> http://github.com/sknown/fcgi/blob/master/libfcgi/fcgiapp.c#L2035, wh=
ich
> confused me. I tried to see if there is any other reference holding t=
he
> FCGX_Request which release the handle without any luck.
>=20
> There are also other observations:
> =C2=A01> Several radosgw daemon across different hosts crashed around=
 the same
> =C2=A0time.
> =C2=A02> Apache's error log has some fcgi error complaining ##idle ti=
meout##
> =C2=A0during the time.
>=20
> Does anyone experience similar issue?
>=20

In the past we've had issues with libfcgi that were related to the numb=
er of open fds on the process (> 1024). The issue was a buggy libfcgi t=
hat was using select() instead of poll(), so this might be the issue yo=
u're noticing.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
