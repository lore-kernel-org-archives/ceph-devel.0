From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: [ceph-users] Object-map
Date: Thu, 28 Jan 2016 11:02:06 -0500 (EST)
Message-ID: <287871337.17149772.1453996926494.JavaMail.zimbra@redhat.com>
References: <47D132BF400BE64BAE6D71033F7D3D7503DF58F6@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:49642 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbcA1QCM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 11:02:12 -0500
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7503DF58F6@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

There are no known issues with object map in the hammer release.  Suppo=
rt for this feature is not yet available in krbd.  Infernalis adds the =
ability to dynamically enable/disable features which certainly lowers t=
he bar for testing it out.  Infernalis also adds support for fast-diff =
(which is based on the object map), which will dramatically speed up di=
ffs and disk usage calculations.

--=20

Jason Dillaman=20

----- Original Message -----
> From: "Wukongming" <wu.kongming@h3c.com>
> To: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com
> Sent: Wednesday, January 27, 2016 4:06:17 AM
> Subject: [ceph-users] Object-map
>=20
> Hi, all
>     How is robust & stability when enable object-map feature in "Hamm=
er"?
>=20
> ---------------------------------------------
> wukongming ID: 12019
> Tel=EF=BC=9A0571-86760239
> Dept=EF=BC=9A2014 UIS2 ONEStor
>=20
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from=
 H3C,
> which is
> intended only for the person or entity whose address is listed above.=
 Any use
> of the
> information contained herein in any way (including, but not limited t=
o, total
> or partial
> disclosure, reproduction, or dissemination) by persons other than the
> intended
> recipient(s) is prohibited. If you receive this e-mail in error, plea=
se
> notify the sender
> by phone or email immediately and delete it!
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
