From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Quota issues of pool
Date: Wed, 18 Jan 2017 07:51:23 +0800
Message-ID: <2955E729-D7CF-481A-81AC-E1B72616CC30@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-148.mail.aliyun.com ([140.205.0.148]:43874 "EHLO
        out0-148.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdAQXvn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2017 18:51:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>

Hi ,

   We have tested the quota features of pool, We found we can set up the qu=
ota of pool less than existing image size. We can also create a image with q=
uota more than the pool size. Sometime ,we even set up a quota for a image, =
but we found we can write the data more than the quota we setup for a image.=
 For example, we set up a poor with quota 100M and create a image inside of =
pool with 200M. but we found we can write more than 100M to the image which =
is way over 100M.
  =20
   ceph osd pool set-quota quota max_bytes 100M
   rbd create =E2=80=93s 200M  quota/100
   sudo rbd map quota/100
   sudo dd  if=3D /dev/zero of=3D/dev/rbd0  bs=3D16k=20

   we in the end  wrote 163M into the image.

  We are wondering the quota function of the pool did not work from our obs=
ervation. Appreciate for any input?=20
=20
   Regards,
   James
=20
  =20

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


