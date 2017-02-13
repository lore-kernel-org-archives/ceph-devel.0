From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: Pgs distribution evenly across osds
Date: Tue, 14 Feb 2017 06:48:56 +0800
Message-ID: <753C3729-DF1E-4FEB-9448-4CEDF74D9195@alibaba-inc.com>
References: <731B4B00-3D93-4E2B-9A32-5F50BDF84177@alibaba-inc.com>
 <32478390-b790-226f-59aa-15f76d1c247e@redhat.com>
 <36A35D18-3331-4B49-88C6-C7A181F12FC5@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-153.mail.aliyun.com ([140.205.0.153]:57086 "EHLO
        out0-153.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdBMWtf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 17:49:35 -0500
In-Reply-To: <36A35D18-3331-4B49-88C6-C7A181F12FC5@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Mark,
   After we periodically even out the pg distribution with reweight-by-pgs =
,we can see our cluster performance(IOPS and bandwidth ) up almost 25%~40% a=
nd latency drop almost 25%.  It somehow prove pg distribution affect the who=
le cluster performance a lot.

  Regards,
  James

=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=
=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E5=92=
=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
This email and its attachments contain confidential information from Alibab=
a Group.which is intended only for the person or entity whose address is lis=
ted above.Any use of information contained herein in any way(including,but n=
ot limited to,total or partial disclosure,reproduction or dissemination)by p=
ersons other than the intended recipient(s) is prohibited.If you receive thi=
s email in error,please notify the sender by phone or email immediately and =
delete it.

On 2/8/17, 4:57 AM, "LIU, Fei" <ceph-devel-owner@vger.kernel.org on behalf =
of james.liu@alibaba-inc.com> wrote:

    Hi Mark,
       Thanks very much for sharing. We found as we tested more , somehow t=
he oversubscribed OSD node perform worse than other OSD node with less PGs ,=
However , the CPU utilization even in worst oversubscribed OSD node is aroun=
d ~50%. We also observed the apply latency and commit latency are pretty hig=
h comparing to others with less PGs. The networking traffic is reasonable . =
The disk utilization sometime is around 99%.but most of time is around 60%. =
We see latency spike from time to time caused by the oversubscribed OSD we g=
uess. Any suggestions?
   =20
    Regards,
    James=20
   =20
   =20
    =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=
=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=
=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=
=88=B6=E5=92=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=
=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
    This email and its attachments contain confidential information from Al=
ibaba Group.which is intended only for the person or entity whose address is=
 listed above.Any use of information contained herein in any way(including,b=
ut not limited to,total or partial disclosure,reproduction or dissemination)=
by persons other than the intended recipient(s) is prohibited.If you receive=
 this email in error,please notify the sender by phone or email immediately =
and delete it.
   =20
    On 2/7/17, 6:48 PM, "Mark Nelson" <mnelson@redhat.com> wrote:
   =20
        Hi James,
       =20
        I'm not sage, but I'll chime in since I spent some time thinking ab=
out=20
        this stuff a while back when I was playing around with halton=20
        distributions for PG placement.  It's very difficult to get even=20
        distributions using random sampling unless you have a *very* high n=
umber=20
        of samples.  The following equations give you a reasonable expectat=
ion=20
        of what the min/max should be assuming an evenly weighted random=20
        distribution:
       =20
        min =3D (pgs / osds) - sqrt(2*pgs*log(osds)/osds)
        max =3D (pgs / osds) + sqrt(2*pgs*log(osds)/osds)
       =20
        In your case that's:
       =20
        min =3D 49152/168 - sqrt(2*49152*log(168)/168) =3D 256
        max =3D 49152/168 + sqrt(2*49152*log(168)/168) =3D 329
       =20
        In terms of performance potential and data distribution evenness, I=
'd=20
        argue you really want to know how bad your worst oversubscribed PG =
is vs=20
        the average:
       =20
        Expected: (49152/168)/329 =3D ~88.9%
        Actual: (49152/168)/333 =3D =3D ~87.9%
       =20
        Your numbers are a little worse, though typically I see our=20
        distributions hover right around expected or just slightly better. =
 This=20
        particular roll of the dice might have just been a little worse.
       =20
        If you jumped up to say 100K PGs:
       =20
        min =3D 1000000/168 - sqrt(2*1000000*log(168)/168) =3D 544
        max =3D 1000000/168 + sqrt(2*1000000*log(168)/168) =3D 647
       =20
        Expected: (100000/168)/647 =3D ~92%
       =20
        Now if you jumped up to 1 million PGs:
       =20
        min =3D 1000000/168 - sqrt(2*1000000*log(168)/168) =3D 5790
        max =3D 1000000/168 + sqrt(2*1000000*log(168)/168) =3D 6115
       =20
        Expected: (1000000/168)/6115 =3D ~97.3%
       =20
        Thanks,
        Mark
       =20
        On 02/07/2017 06:14 PM, LIU, Fei wrote:
        > Hi Sage,
        >   We are trying to distribute pgs evenly across osds. However, af=
ter certain tunes, we still got 30% difference among max pgs  and min pg  of=
 OSDs (OSD 9 has 13.8% more pgs than average and OSD 86 has 15.2% less pgs t=
han average).  Any good suggestions to make PGs distributed evenly across OS=
Ds?
        >
        >   Thanks,
        >   James
        >
        >
        > SUM :   49152   |
        > Osd :   168     |
        > AVE :   292.57  |
        > Max :   333     |
        > Osdid : osd.9   |
        > per:    13.8%   |
        > ------------------------
        > min :   248     |
        > osdid : osd.86  |
        > per:    -15.2%  |
        >
        > [james.liu@a18d13422.eu13 /home/james.liu]
        > $
        >
        >
        > =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=
=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=
=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=
=80=81=E5=A4=8D=E5=88=B6=E5=92=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
        > This email and its attachments contain confidential information f=
rom Alibaba Group.which is intended only for the person or entity whose addr=
ess is listed above.Any use of information contained herein in any way(inclu=
ding,but not limited to,total or partial disclosure,reproduction or dissemin=
ation)by persons other than the intended recipient(s) is prohibited.If you r=
eceive this email in error,please notify the sender by phone or email immedi=
ately and delete it.
        >
        >
        > --
        > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
        > the body of a message to majordomo@vger.kernel.org
        > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
        >
       =20
   =20
   =20
    --
    To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
   =20


