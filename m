From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: BlueStore Latency Breakdown
Date: Tue, 06 Dec 2016 16:43:49 +0800
Message-ID: <768BBDE6-FF04-4842-9DD5-75E1FFA5D4B4@alibaba-inc.com>
References: <9919FCA5-993E-4153-9A6E-AA64E592A3A4@alibaba-inc.com>
 <alpine.DEB.2.11.1612011647400.2702@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-132.mail.aliyun.com ([140.205.0.132]:49692 "EHLO
        out0-132.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbcLFItv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 03:49:51 -0500
In-Reply-To: <alpine.DEB.2.11.1612011647400.2702@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org

Hi Sage=EF=BC=8C
   I am in business travel, Sorry for being a little bit to reply your emai=
l . We will have a quick try and let you know the result in Wednesday=E2=80=99s pe=
rf call. In the mean time, We would like to have a tuning option .

  Best Regards,
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

On 12/2/16, 1:37 AM, "Sage Weil" <sweil@redhat.com> wrote:

    [adding ceph-devel]
   =20
    On Thu, 1 Dec 2016, LIU, Fei wrote:
    > Hi Sage:
    >=20
    >     Here are the benchmark results that we got:       =20
    >=20
    >         1. With bluestore storage engine=EF=BC=8CThe latency of fio 16KB, s=
ingle IO
    > with three replicas is  around 1.2ms
    >=20
    >         2. With bluestore storage engine=EF=BC=8CThe latenc of fio 16KB, si=
ngle IO
    > with single replicas is  around 0.7ms
    >=20
    >         3. With filestore storage engine=EF=BC=8CThe latenc of fio 16KB, si=
ngle IO
    > with three replicas is  around 0.8ms
    >=20
    >     The IO flow including space allocation, data write and metadata w=
rite.
    > All of these operations are serialized . The data was written to bloc=
k
    > device(SATA SSD) through AIO. The metadata was written to  RocksDB (N=
VMe
    > SSD).
    >=20
    > =20
    >=20
    > Here are what we observed and latency breakdown through percounter an=
d log:
    >=20
    > 1.       Prepare stage of transaction=EF=BC=9A90us
    >=20
    > 2.       Data was written through AIO(SATA SSD): 110us(3520 16k rando=
m write
    > latency is around 80-90us)
    >=20
    > 3.       Metadata was written twice by calling submit_transaction_syn=
c, The
    > total latency is around 350us(The logging mechanism was used in bluef=
s,
    > everytime, the IO to bluefs will be written to log then to data, so h=
ere is
    > total four IOs.)
   =20
    This is part of the problem.  The bluefs logging path should not be=20
    triggered unless it is a totally fresh OSD and the wal log files haven'=
t=20
    been recycled yet.  There is an option to precondition the rocksdb log
   =20
    	OPTION(bluestore_precondition_bluefs, OPT_U64, 512*1024*1024)  // writ=
e this much data at mkfs
   =20
    that you may have adjusted or might not be writing enough data?  Have y=
ou=20
    adjusted the rocksdb parameters at all?
   =20
    Actually, testing this now, it looks like the preconditioning isn't=20
    working the way it should.  You can work around this just by writing a=20
    bunch of data to bluestore to get the rocksdb logs to roll over.  The=20
    easiest way to do this is
   =20
      rados -p rbd bench 30 write -b 65536 --write-omap
   =20
    and be sure to write serveral hundred megabytes to each OSD.  After tha=
t,=20
    you should see the latency drop way down.
   =20
    > The whole process for a bluestore write hence take : 90+110+350=3D550us
    >=20
    >     Three replicas were used in Ceph:  We first wrote to primary then=
 to two
    > replicas and return. The total latency including the networking laten=
cy will
    > be =20
    >=20
    >     network_latency + primary_osd_bluestore_latency +
    > slave_osd_bluestore_latency which equals to 200+550+550=3D1.3ms(the net=
working
    > latency is around 200us for three replicas) . It is pretty close to 1=
.2ms .
    >=20
    > =20
    >=20
    >    For further verified , we have test the cluster with single replic=
s with
    > below latency calculation:
    >=20
    >    network_latency + primary_osd_bluestore_latency which is equal to
    > 100+550=EF=BC=9D0.65us (networking latency is 100us with single replica), i=
t is
    > pretty close to to 0.7ms.
    >=20
    > =20
    >=20
    > Here is our preliminary conclusion:
    >=20
    >             1. Latency of Bluestore is worse than filestore because m=
etadata
    > and data write twice in difference place in bluestore.
   =20
    As mentioned during the perf call, I think the path we should take is a=
n=20
    option or some auto-tuning so that in BlueStore can choose to do=20
    write-ahead logging of the data write even when it is <=3D min_alloc_size=
. =20
    This will allow the operation to commit with a single IO + flush to the=
=20
    nvme wal device and the data write to the slower device to happen=20
    asynchronously.
   =20
    >             2. It take too much time for calling submit_sync_latency =
twice
    > to write metadata =E3=80=82more optimization should be made over here
   =20
    This is a easist thing to fix... I've opened a ticket:
   =20
    	http://tracker.ceph.com/issues/18105
   =20
    >             3. Could be possible to make metadata and data write in p=
arallel
    > for improving the latency.   =20
   =20
    Definitely not.  We cannot write any metadata that references data unti=
l=20
    the data is on stable storage or else a power failure will lead to=20
    corruption.
   =20
    Thanks for the detailed breakdown!
   =20
    sage


