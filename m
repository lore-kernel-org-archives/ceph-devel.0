From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: BlueStore Latency Breakdown
Date: Wed, 07 Dec 2016 11:23:45 +0800
Message-ID: <97EAB128-A136-4550-B303-1DA870C12AD2@alibaba-inc.com>
References: <9919FCA5-993E-4153-9A6E-AA64E592A3A4@alibaba-inc.com>
 <alpine.DEB.2.11.1612011647400.2702@piezo.novalocal>
 <768BBDE6-FF04-4842-9DD5-75E1FFA5D4B4@alibaba-inc.com>
 <cd4a3dd2-f769-8556-bb1f-fd284b45d806@redhat.com>
 <4FA019FC-B916-4FC8-B657-DDEB1686E43B@alibaba-inc.com>
 <alpine.DEB.2.11.1612070304530.4753@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-134.mail.aliyun.com ([140.205.0.134]:47981 "EHLO
        out0-134.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbcLGDa4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 22:30:56 -0500
In-Reply-To: <alpine.DEB.2.11.1612070304530.4753@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org

Hi Sage,
  Understand. Thanks.

  Regards,
  James
On 12/7/16, 11:07 AM, "Sage Weil" <sweil@redhat.com> wrote:

    On Wed, 7 Dec 2016, LIU, Fei wrote:
    > Hi Mark,
    >    Here is what I referred about Sage=E2=80=99s comments:
    >=20
    >    =E2=80=9C     As mentioned during the perf call, I think the path we sho=
uld take is an
    >      option or some auto-tuning so that in BlueStore can choose to do
    >      write-ahead logging of the data write even when it is <=3D min_all=
oc_size.
    >      This will allow the operation to commit with a single IO + flush=
 to the
    >      nvme wal device and the data write to the slower device to happe=
n
    >   asynchronously.=E2=80=9D
    >  =20
    >   One parameter will be possibilly developed for that purpose by Sage=
 .
   =20
    I'm busy with kraken at the moment, but even after that's done I'm not=20
    sure this will be a priority given everything else that needs to get do=
ne=20
    for luminous.  This would be a great initial project for you to get=20
    involved in BlueStore development, though!
   =20
    sage
   =20
   =20
    >=20
    >   Regards,
    >   James
    >=20
    >  =20
    >=20
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
    >=20
    > On 12/6/16, 11:49 PM, "Mark Nelson" <mnelson@redhat.com> wrote:
    >=20
    >     Hi James,
    >    =20
    >     Sorry, which tuning option do you mean?
    >    =20
    >     Mark
    >    =20
    >     On 12/06/2016 02:43 AM, LIU, Fei wrote:
    >     > Hi Sage=EF=BC=8C
    >     >    I am in business travel, Sorry for being a little bit to rep=
ly your email . We will have a quick try and let you know the result in Wedn=
esday=E2=80=99s perf call. In the mean time, We would like to have a tuning option=
 .
    >     >
    >     >   Best Regards,
    >     >   James
    >     >
    >     > =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=
=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=
=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=
=B2=E3=80=81=E5=A4=8D=E5=88=B6=E5=92=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=
=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
    >     > This email and its attachments contain confidential information=
 from Alibaba Group.which is intended only for the person or entity whose ad=
dress is listed above.Any use of information contained herein in any way(inc=
luding,but not limited to,total or partial disclosure,reproduction or dissem=
ination)by persons other than the intended recipient(s) is prohibited.If you=
 receive this email in error,please notify the sender by phone or email imme=
diately and delete it.
    >     >
    >     > On 12/2/16, 1:37 AM, "Sage Weil" <sweil@redhat.com> wrote:
    >     >
    >     >     [adding ceph-devel]
    >     >
    >     >     On Thu, 1 Dec 2016, LIU, Fei wrote:
    >     >     > Hi Sage:
    >     >     >
    >     >     >     Here are the benchmark results that we got:
    >     >     >
    >     >     >         1. With bluestore storage engine=EF=BC=8CThe latency of=
 fio 16KB, single IO
    >     >     > with three replicas is  around 1.2ms
    >     >     >
    >     >     >         2. With bluestore storage engine=EF=BC=8CThe latenc of =
fio 16KB, single IO
    >     >     > with single replicas is  around 0.7ms
    >     >     >
    >     >     >         3. With filestore storage engine=EF=BC=8CThe latenc of =
fio 16KB, single IO
    >     >     > with three replicas is  around 0.8ms
    >     >     >
    >     >     >     The IO flow including space allocation, data write an=
d metadata write.
    >     >     > All of these operations are serialized . The data was wri=
tten to block
    >     >     > device(SATA SSD) through AIO. The metadata was written to=
  RocksDB (NVMe
    >     >     > SSD).
    >     >     >
    >     >     >
    >     >     >
    >     >     > Here are what we observed and latency breakdown through p=
ercounter and log:
    >     >     >
    >     >     > 1.       Prepare stage of transaction=EF=BC=9A90us
    >     >     >
    >     >     > 2.       Data was written through AIO(SATA SSD): 110us(35=
20 16k random write
    >     >     > latency is around 80-90us)
    >     >     >
    >     >     > 3.       Metadata was written twice by calling submit_tra=
nsaction_sync, The
    >     >     > total latency is around 350us(The logging mechanism was u=
sed in bluefs,
    >     >     > everytime, the IO to bluefs will be written to log then t=
o data, so here is
    >     >     > total four IOs.)
    >     >
    >     >     This is part of the problem.  The bluefs logging path shoul=
d not be
    >     >     triggered unless it is a totally fresh OSD and the wal log =
files haven't
    >     >     been recycled yet.  There is an option to precondition the =
rocksdb log
    >     >
    >     >     	OPTION(bluestore_precondition_bluefs, OPT_U64, 512*1024*10=
24)  // write this much data at mkfs
    >     >
    >     >     that you may have adjusted or might not be writing enough d=
ata?  Have you
    >     >     adjusted the rocksdb parameters at all?
    >     >
    >     >     Actually, testing this now, it looks like the preconditioni=
ng isn't
    >     >     working the way it should.  You can work around this just b=
y writing a
    >     >     bunch of data to bluestore to get the rocksdb logs to roll =
over.  The
    >     >     easiest way to do this is
    >     >
    >     >       rados -p rbd bench 30 write -b 65536 --write-omap
    >     >
    >     >     and be sure to write serveral hundred megabytes to each OSD=
.  After that,
    >     >     you should see the latency drop way down.
    >     >
    >     >     > The whole process for a bluestore write hence take : 90+1=
10+350=3D550us
    >     >     >
    >     >     >     Three replicas were used in Ceph:  We first wrote to =
primary then to two
    >     >     > replicas and return. The total latency including the netw=
orking latency will
    >     >     > be
    >     >     >
    >     >     >     network_latency + primary_osd_bluestore_latency +
    >     >     > slave_osd_bluestore_latency which equals to 200+550+550=3D1=
.3ms(the networking
    >     >     > latency is around 200us for three replicas) . It is prett=
y close to 1.2ms .
    >     >     >
    >     >     >
    >     >     >
    >     >     >    For further verified , we have test the cluster with s=
ingle replics with
    >     >     > below latency calculation:
    >     >     >
    >     >     >    network_latency + primary_osd_bluestore_latency which =
is equal to
    >     >     > 100+550=EF=BC=9D0.65us (networking latency is 100us with single=
 replica), it is
    >     >     > pretty close to to 0.7ms.
    >     >     >
    >     >     >
    >     >     >
    >     >     > Here is our preliminary conclusion:
    >     >     >
    >     >     >             1. Latency of Bluestore is worse than filesto=
re because metadata
    >     >     > and data write twice in difference place in bluestore.
    >     >
    >     >     As mentioned during the perf call, I think the path we shou=
ld take is an
    >     >     option or some auto-tuning so that in BlueStore can choose =
to do
    >     >     write-ahead logging of the data write even when it is <=3D mi=
n_alloc_size.
    >     >     This will allow the operation to commit with a single IO + =
flush to the
    >     >     nvme wal device and the data write to the slower device to =
happen
    >     >     asynchronously.
    >     >
    >     >     >             2. It take too much time for calling submit_s=
ync_latency twice
    >     >     > to write metadata =E3=80=82more optimization should be made ove=
r here
    >     >
    >     >     This is a easist thing to fix... I've opened a ticket:
    >     >
    >     >     	http://tracker.ceph.com/issues/18105
    >     >
    >     >     >             3. Could be possible to make metadata and dat=
a write in parallel
    >     >     > for improving the latency.
    >     >
    >     >     Definitely not.  We cannot write any metadata that referenc=
es data until
    >     >     the data is on stable storage or else a power failure will =
lead to
    >     >     corruption.
    >     >
    >     >     Thanks for the detailed breakdown!
    >     >
    >     >     sage
    >     >
    >     >
    >    =20
    >=20
    >=20
    >=20


