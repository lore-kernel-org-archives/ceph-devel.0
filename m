From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw - Object Lifecycle Management
Date: Fri, 26 Jun 2015 16:27:28 -0400 (EDT)
Message-ID: <1727226091.20572909.1435350448528.JavaMail.zimbra@redhat.com>
References: <BLU175-W40A39950CB80A4B1D3D838DFAD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52934 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbFZU13 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 16:27:29 -0400
In-Reply-To: <BLU175-W40A39950CB80A4B1D3D838DFAD0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: ceph-devel@vger.kernel.org

We discussed this, and it's relatively high in our priority, but we nee=
d to get the new multi site done first. At the moment there is some bac=
kground work that is being done by the community to support swift objec=
t expiration (see PR #4739). The bigger S3-like lifecycle management is=
 yet to leave the drawing board.

Yehuda

----- Original Message -----
> From: "GuangYang" <yguang11@outlook.com>
> To: yehuda@redhat.com
> Cc: ceph-devel@vger.kernel.org
> Sent: Friday, June 26, 2015 1:19:37 PM
> Subject: rgw - Object Lifecycle Management
>=20
> Hi Yehuda,
> Is there any plan to add bucket/object lifecycle management to radosg=
w?
>=20
>=20
> Thanks,
> Guang
> 		 	   		  N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=E7=
=9E=82=EE=83=91=E5=8D=83v=E8=B1=9D=EF=BF=BD=E8=97=93{.n=EF=BF=BD=E5=A3=8F=
=E6=B8=AE=E6=A6=8Fz=E9=B3=90=E5=A6=A0ay=EF=BF=BD=E8=95=A0=E8=B7=88=EF=BF=
=BDj=EE=84=9Bf=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97=EF=BF=BD=E7=95=90=E3=
=82=A2=EF=BF=BD=E2=92=8E=EE=9B=90:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=B1=B0=
=E7=A8=9B=EF=BF=BD=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8=EE=95=
=90"=E6=BF=9F!=E7=A7=88
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
