From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: Quota issues of pool
Date: Wed, 18 Jan 2017 13:03:29 +0800
Message-ID: <77EC9EC2-760A-452E-A244-59A61E0DBB2B@alibaba-inc.com>
References: <2955E729-D7CF-481A-81AC-E1B72616CC30@alibaba-inc.com>
 <2a30710a-2045-48a3-a77f-267240850230.james.liu@alibaba-inc.com>
 <B12B09C8-32CE-4CB9-8A3A-C94CDAED8B49@alibaba-inc.com>
 <CA+aFP1CtXLWMu1nkBNCjdEvbka+DDzY0X1-b4FN50=dJ0p=5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-141.mail.aliyun.com ([140.205.0.141]:56984 "EHLO
        out0-141.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdARFDt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2017 00:03:49 -0500
In-Reply-To: <CA+aFP1CtXLWMu1nkBNCjdEvbka+DDzY0X1-b4FN50=dJ0p=5JA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

Hi Jason and Sage=EF=BC=8C
  Thanks a lot for your input. We will follow up the pull request and offer=
 any help we can to fix this issue. In the mean time, we got another issue r=
egarding to pool full.
   We created two pools in a cluster: One is called rbd pool, another one i=
s poc-pool, =20
 =20
  $ceph -s
      cluster 789bda76-218d-4c4f-bbf6-182fbe5e7970
       health HEALTH_WARN
              pool 'rbd' is full
       monmap e1: 1 mons at {mon1=3D11.238.224.6:6789/0}
              election epoch 4, quorum 0 mon1
       osdmap e6940: 32 osds: 32 up, 32 in
              flags sortbitwise,require_jewel_osds
        pgmap v380010: 1524 pgs, 2 pools, 64568 MB data, 4027 kobjects
              218 GB used, 59208 GB / 59427 GB avail
                  1524 active+clean
    client io 43274 kB/s wr, 0 op/s rd, 5409 op/s wr
 =20
   Once we make rbd pool full. The another pool =E2=80=9Cpoc-pool=E2=80=9D  performance=
 drops a lot even though poc-poll is far away from full. Any advices?
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

On 1/18/17, 11:33 AM, "Jason Dillaman" <jdillama@redhat.com> wrote:

    For what it's worth, there is work in-progress right now to add the
    necessary hooks to librbd to support removing an image from a full
    cluster [1].
   =20
    [1] https://github.com/ceph/ceph/pull/12627
   =20
    On Tue, Jan 17, 2017 at 9:30 PM, LIU, Fei <james.liu@alibaba-inc.com> w=
rote:
    > Hi Sage,
    >   Thanks for your promptly response. It is clear to us of the root ca=
use that cause  the delay which in the end make quota enforcement somehow no=
t accurate . However, when we tried to remove the image which is exceeding t=
he quota ,the image can not be removed and remove process hang over there.
    >
    > sudo rbd unmap /dev/rbd0
    > rbd rm quota/100
    >
    > We got FULL,paused modify error.
    >
    > Is that normal? Thanks for your advise in advance.
    >
    > Regards,
    > James
    >
    > =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=
=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=
=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=
=8D=E5=88=B6=E5=92=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=
=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
    > This email and its attachments contain confidential information from =
Alibaba Group.which is intended only for the person or entity whose address =
is listed above.Any use of information contained herein in any way(including=
,but not limited to,total or partial disclosure,reproduction or disseminatio=
n)by persons other than the intended recipient(s) is prohibited.If you recei=
ve this email in error,please notify the sender by phone or email immediatel=
y and delete it.
    >
    > ------------------Original Mail ------------------
    > From:Sage Weil <sweil@redhat.com>
    > Date:2017-01-18 08:23:28
    > Recipient:LIU, Fei <james.liu@alibaba-inc.com>
    > CC:ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redh=
at.com>
    > Subject:Re: Quota issues of pool
    > On Wed, 18 Jan 2017, LIU, Fei wrote:
    >> Hi ,
    >>
    >> We have tested the quota features of pool, We found we can set up th=
e quota of pool less than existing image size. We can also create a image wi=
th quota more than the pool size. Sometime ,we even set up a quota for a ima=
ge, but we found we can write the data more than the quota we setup for a im=
age. For example, we set up a poor with quota 100M and create a image inside=
 of pool with 200M. but we found we can write more than 100M to the image wh=
ich is way over 100M.
    >>
    >> ceph osd pool set-quota quota max_bytes 100M
    >> rbd create =E2=80=93s 200M quota/100
    >> sudo rbd map quota/100
    >> sudo dd if=3D /dev/zero of=3D/dev/rbd0 bs=3D16k
    >>
    >> we in the end wrote 163M into the image.
    >>
    >> We are wondering the quota function of the pool did not work from ou=
r
    >> observation. Appreciate for any input?
    >
    > Unlike a single storage server in which all IO passes through a singl=
e
    > server, Ceph is distributed and can't easily do perfect
    > quota enforcement. It's a feedback loop, but there is always some
    > delay:
    >
    > - osds report pg stats to mon
    > - mon sees pool usage exceed quota, sets full flag on pool
    > - new osdmap propagates to osds
    > - osds block new writes
    >
    > This is usually not a problem when limits are large, as we generally
    > expect them to be. (1 PB vs 1.00001 PB written doesn't really matter.=
)
    > It doesn't work well on very small pools (e.g., 100 MB), but you gene=
rally
    > don't want such small pools anyway or else you'll need to have millio=
ns of
    > them in a single cluster, and that isn't supported.
    >
    > sage
    >
    >
    >
    > --
    > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
    > the body of a message to majordomo@vger.kernel.org
    > More majordomo info at  http://vger.kernel.org/majordomo-info.html
   =20
   =20
   =20
    --=20
    Jason
   =20


