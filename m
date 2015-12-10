From: Florent Manens <florent-HFDZmTvHvwhQFI55V6+gNQ@public.gmane.org>
Subject: Re: Client io blocked when removing snapshot
Date: Thu, 10 Dec 2015 09:01:47 +0100 (CET)
Message-ID: <484376676.40372.1449734507796.JavaMail.zimbra@manens.org>
References: <47D132BF400BE64BAE6D71033F7D3D7503DE0DF4@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1603441941=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7503DE0DF4-JwQOC20i6vT3cnzPNjVLboSsE/coCuR8pWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wukongming <wu.kongming-vVzyEvZLFYE@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, &RD-STOR-FIRE-vVzyEvZLFYE@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1603441941==
Content-Type: multipart/alternative;
	boundary="----=_Part_40371_64794758.1449734507795"

------=_Part_40371_64794758.1449734507795
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Can you try modifying osd_snap_trim_sleep ? The default value is 0, I have =
good results with 0.25 with a ceph cluster using SATA disks :=20
ceph tell osd.* injectargs -- --osd_snap_trim_sleep 0.25=20

Best regards,=20

----- Le 10 D=C3=A9c 15, =C3=A0 7:52, Wukongming <wu.kongming-vVzyEvZLFYE@public.gmane.org> a =
=C3=A9crit :=20

> Hi, All

> I used a rbd command to create a 6TB-size image, And then created a snaps=
hot of
> this image. After that, I kept writing something like modifying files so =
the
> snapshots would be cloned one by one.
> At this time, I did the fellow 2 ops simultaneously.

> 1. keep client io to this image.
> 2. excute a rbd snap rm command to delete snapshot.

> Finally ,I found client io blocked for quite a long time. I used SATA dis=
k to
> test, and felt that ceph makes it a priority to remove snapshot.
> Also we use iostat tool to help watch the disk state, and it runs in full
> workload.

> So, should we have a priority to deal with client io instead of removing
> snapshot?
> ---------------------------------------------
> wukongming ID: 12019
> Tel=EF=BC=9A0571-86760239
> Dept=EF=BC=9A2014 UIS2 ONEStor

> -------------------------------------------------------------------------=
------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=80=E6=
=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=E4=BF=
=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=
=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=
=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=
=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=
=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=
=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=
=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=
=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=
=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=
=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from H3C=
, which
> is
> intended only for the person or entity whose address is listed above. Any=
 use of
> the
> information contained herein in any way (including, but not limited to, t=
otal or
> partial
> disclosure, reproduction, or dissemination) by persons other than the int=
ended
> recipient(s) is prohibited. If you receive this e-mail in error, please n=
otify
> the sender
> by phone or email immediately and delete it!
> N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=E7=9E=82=EE=83=
=91=E5=8D=83v=E8=B1=9D=EF=BF=BD)=E8=97=93{.n=EF=BF=BD+=E5=A3=8F=E6=B8=AE=E6=
=A6=8Fz=E9=B3=90=E5=A6=A0ay=EF=BF=BD=E8=95=A0=E8=B7=88=EF=BF=BD,j=EE=84=9Bf=
=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97=EF=BF=BD=E7=95=90=E3=82=A2=EF=BF=BD=E2=
=92=8E=EE=9B=90:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=B1=B0=E7=A8=9B=EF=BF=BD=EF=
=BF=BD=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8=EE=95=90"=E6=BF=9F!=
=E7=A7=88

--=20
Florent Manens=20
BeeZim=20

------=_Part_40371_64794758.1449734507795
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial,helvetica,sans-serif; font-siz=
e: 10pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></div>=
<div>Can you try modifying&nbsp;osd_snap_trim_sleep ? The default value is =
0, I have good results with 0.25 with a ceph cluster using SATA disks :</di=
v><div>ceph tell osd.* injectargs -- --osd_snap_trim_sleep 0.25</div><div><=
br data-mce-bogus=3D"1"></div><div>Best regards,</div><div><br></div><div><=
span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- Le 10 D=C3=A9c 15, =C3=
=A0 7:52, Wukongming &lt;wu.kongming-vVzyEvZLFYE@public.gmane.org&gt; a =C3=A9crit :<br></span><=
/div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:=
 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-=
weight: normal; font-style: normal; text-decoration: none; font-family: Hel=
vetica,Arial,sans-serif; font-size: 12pt;" data-mce-style=3D"border-left: 2=
px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-we=
ight: normal; font-style: normal; text-decoration: none; font-family: Helve=
tica,Arial,sans-serif; font-size: 12pt;">Hi, All<br><br>I used a rbd comman=
d to create a 6TB-size image, And then created a snapshot of this image. Af=
ter that, I kept writing something like modifying files so the snapshots wo=
uld be cloned one by one.<br>At this time, I did the fellow 2 ops simultane=
ously.<br><br>1. keep client io to this image.<br>2. excute a rbd snap rm c=
ommand to delete snapshot.<br><br>Finally ,I found client io blocked for qu=
ite a long time. I used SATA disk to test, and felt that ceph makes it a pr=
iority to remove snapshot.<br>Also we use iostat tool to help watch the dis=
k state, and it runs in full workload.<br><br>So, should we have a priority=
 to deal with client io instead of removing snapshot?<br>------------------=
---------------------------<br>wukongming ID: 12019<br>Tel=EF=BC=9A0571-867=
60239<br>Dept=EF=BC=9A2014 UIS2 ONEStor<br><br>----------------------------=
---------------------------------------------------------------------------=
------------------------------<br>=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=
=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=
=89=E9=80=9A=E4=BF=A1=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=
=E7=9A=84=E4=BF=9D=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=
=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=
=AD=E5=88=97=E5=87=BA<br>=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=
=BB=84=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=
=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=
=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=
=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=
=B6=E3=80=81<br>=E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=
=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=
=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC<br>=E9=82=AE=E4=BB=B6=EF=BC=81<br>This e-mail and its attachments conta=
in confidential information from H3C, which is<br>intended only for the per=
son or entity whose address is listed above. Any use of the<br>information =
contained herein in any way (including, but not limited to, total or partia=
l<br>disclosure, reproduction, or dissemination) by persons other than the =
intended<br>recipient(s) is prohibited. If you receive this e-mail in error=
, please notify the sender<br>by phone or email immediately and delete it!<=
br>N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=E7=9E=82=EE=83=
=91=E5=8D=83v=E8=B1=9D=EF=BF=BD)=E8=97=93{.n=EF=BF=BD+=E5=A3=8F=E6=B8=AE=E6=
=A6=8Fz=E9=B3=90=E5=A6=A0ay=EF=BF=BD=E8=95=A0=E8=B7=88=EF=BF=BD,j=EE=84=9Bf=
=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97=EF=BF=BD=E7=95=90=E3=82=A2=EF=BF=BD=E2=
=92=8E=EE=9B=90:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=B1=B0=E7=A8=9B=EF=BF=BD=EF=
=BF=BD=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8=EE=95=90"=E6=BF=9F!=
=E7=A7=88<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_PO=
ST__">-- <br></div><div>Florent Manens<br>BeeZim</div></div></body></html>
------=_Part_40371_64794758.1449734507795--

--===============1603441941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1603441941==--
