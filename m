From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: rbd performance drop a lot with objectmap
Date: Tue, 14 Feb 2017 06:37:06 +0800
Message-ID: <A4A0B62C-3155-4625-8954-3CCB482F95D2@alibaba-inc.com>
References: <B30C48EF-D72E-471C-808F-02E666347EAB@alibaba-inc.com>
 <CA+aFP1DpPYm1t2+wzgEOzciYAmkemTkuzabsArZCZF6OXzhO2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-144.mail.aliyun.com ([140.205.0.144]:59440 "EHLO
        out0-144.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMWhj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 17:37:39 -0500
In-Reply-To: <CA+aFP1DpPYm1t2+wzgEOzciYAmkemTkuzabsArZCZF6OXzhO2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Jason,
   It makes sense .By the way, we do a random write with qd=3D1 initially .Th=
e performance drops almost 3 times.
  We also tested 10  times fio write test in one image using below fio conf=
iguration with each fio write taking 30 seconds. =20
[global]
ioengine=3Drbd
clientname=3Dadmin
pool=3Dtest-pool
rbdname=3D image-with-objmap
rw=3Dwrite
bs=3D16k
direct=3D1
runtime=3D1200
ramp_time=3D30
group_reporting
time_based
[with_objectmap_rbd_iodepth1_numjobs1]
iodepth=3D128
numjobs=3D1

  IOPS increases from 180 to 1200 in the end after 10 times fio rbd write. =
Once objectmap is warming up , it lowers the latency a lot  and increase IOP=
S accordingly.=20
 =20
However, we also tested the rand write with rbd-bench ,we found the perform=
ance almost drop 10 times with more contention involved:

1.	rbd create test-pool/no-map-image --size 100G --object-size 16K --image-=
format 2 --image-feature layering =20
2.	rbd create test-pool/with-map-image --size 100G --object-size 16K --imag=
e-format 2 --image-feature layering --image-feature exclusive-lock --image-f=
eature object-map
     =20
        Using rbd bench to write 1G data randomly=EF=BC=9A
         rbd bench-write -p test-pool --image no-map-image --io-size 16K --=
io-threads 16 --io-total 1G --io-pattern rand
       =20
 We found the performance drop almost 10 times in terms of IOPS. It shows t=
he performance is getting worse with more jobs. It make us wondering whether=
 the lock is killing factor. Any thoughts?


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

On 2/12/17, 9:59 AM, "Jason Dillaman" <jdillama@redhat.com> wrote:

    On Fri, Feb 10, 2017 at 9:50 AM, LIU, Fei <james.liu@alibaba-inc.com> w=
rote:
    > With FIO single job queue depth 1(W/ vs W/O)  , IOPS drop 3 times and
    > latency increased 3 times. As with more jobs, the IOPS drops more and
    > latency increase higher and higher.
   =20
    Assuming you have a random write workload, within a QD=3D1, it is
    entirely expected for the first write to the object to incur a
    performance penalty since it requires an additional round-trip
    operation to the backing OSDs. Since you only hit this penalty for the
    very first write to the object, its cost is amortized over future
    writes. This is similar to cloned images and the amortized cost of
    copying up the backing parent object to the clone on the first write.
   =20
    > The objectmap_locker in pre and post and objectmap update per IO real=
ly hurt
    > performance. Lockless queue and new way to caching objectmap? Any tho=
ughts?
   =20
    By definition, with a QD=3D1, there is zero contention on that lock. The
    lock is really only held for a minuscule amount of time and is dropped
    while the OSD operation is in-progress. Do you actually have any
    performance metrics to back up this claim? Note that the post state is
    only hit when you issue a remove / trim / discard operation.
   =20
    --=20
    Jason
   =20


