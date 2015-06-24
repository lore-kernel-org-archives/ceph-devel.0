From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: radosgw crash within libfcgi
Date: Wed, 24 Jun 2015 17:04:05 -0400 (EDT)
Message-ID: <463953216.19442278.1435179845477.JavaMail.zimbra@redhat.com>
References: <BLU175-W1310E96C473E9ABED62D65DFAF0@phx.gbl> <460832233.19349487.1435171225932.JavaMail.zimbra@redhat.com> <BLU175-W467685E9DD4BACB37D7AB3DFAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:41402 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbFXVEH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 17:04:07 -0400
In-Reply-To: <BLU175-W467685E9DD4BACB37D7AB3DFAF0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com



----- Original Message -----
> From: "GuangYang" <yguang11@outlook.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com
> Sent: Wednesday, June 24, 2015 1:53:20 PM
> Subject: RE: radosgw crash within libfcgi
>=20
> Thanks Yehuda for the response.
>=20
> We already patched libfcgi to use poll instead of select to overcome =
the
> limitation.
>=20
> Thanks,
> Guang
>=20
>=20
> ----------------------------------------
> > Date: Wed, 24 Jun 2015 14:40:25 -0400
> > From: yehuda@redhat.com
> > To: yguang11@outlook.com
> > CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> > Subject: Re: radosgw crash within libfcgi
> >
> >
> >
> > ----- Original Message -----
> >> From: "GuangYang" <yguang11@outlook.com>
> >> To: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com,
> >> yehuda@redhat.com
> >> Sent: Wednesday, June 24, 2015 10:09:58 AM
> >> Subject: radosgw crash within libfcgi
> >>
> >> Hello Cephers,
> >> Recently we have several radosgw daemon crashes with the same foll=
owing
> >> kernel log:
> >>
> >> Jun 23 14:17:38 xxx kernel: radosgw[68180]: segfault at f0 ip
> >> 00007ffa069996f2 sp 00007ff55c432710 error 6 in

error 6 is sigabrt, right? With invalid pointer I'd expect to get segfa=
ult. Is the pointer actually invalid?

Yehuda


> >> libfcgi.so.0.0.0[7ffa06995000+a000] in libfcgi.so.0.0.0[7ffa069950=
00+a000]
> >>
> >> Looking at the assembly, it seems crashing at this point -
> >> http://github.com/sknown/fcgi/blob/master/libfcgi/fcgiapp.c#L2035,=
 which
> >> confused me. I tried to see if there is any other reference holdin=
g the
> >> FCGX_Request which release the handle without any luck.
> >>
> >> There are also other observations:
> >> 1> Several radosgw daemon across different hosts crashed around th=
e same
> >> time.
> >> 2> Apache's error log has some fcgi error complaining ##idle timeo=
ut##
> >> during the time.
> >>
> >> Does anyone experience similar issue?
> >>
> >
> > In the past we've had issues with libfcgi that were related to the =
number
> > of open fds on the process (> 1024). The issue was a buggy libfcgi =
that
> > was using select() instead of poll(), so this might be the issue yo=
u're
> > noticing.
> >
> > Yehuda
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>  		 	   		  N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=
=E7=9E=82=EE=83=91=E5=8D=83v=E8=B1=9D=EF=BF=BD=E8=97=93{.n=EF=BF=BD=E5=A3=
=8F=E6=B8=AE=E6=A6=8Fz=E9=B3=90=E5=A6=A0ay=EF=BF=BD=E8=95=A0=E8=B7=88=EF=
=BF=BDj=EE=84=9Bf=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97=EF=BF=BD=E7=95=90=
=E3=82=A2=EF=BF=BD=E2=92=8E=EE=9B=90:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=B1=
=B0=E7=A8=9B=EF=BF=BD=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8=EE=
=95=90"=E6=BF=9F!=E7=A7=88
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
