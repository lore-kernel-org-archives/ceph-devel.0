From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: BlueStore: Multi sharded kv pull request
Date: Mon, 23 Jan 2017 15:32:15 +0800
Message-ID: <588E15ED-9C9D-44D2-8F5C-4A093A3B370B@alibaba-inc.com>
References: <5E3E05AED7F0F044904275810D0CB465055CCA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <B9070C20-620C-4CDA-8B00-5B563F150693@alibaba-inc.com>
 <5E3E05AED7F0F044904275810D0CB465055E65@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-135.mail.aliyun.com ([140.205.0.135]:58608 "EHLO
        out0-135.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAWHci (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 02:32:38 -0500
In-Reply-To: <5E3E05AED7F0F044904275810D0CB465055E65@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath=EF=BC=8C
  The data is pretty promising . Especially we saw almost double performanc=
e gain in 4k rw comparing to filestore. Even comparing with RocksDB, ZS have=
 a big performance gain  as well. That=E2=80=99s a big achievement in last several=
 month. Can I assume ZS will have advantage in red performance comparing to =
RocksDB because of B+ tree used in ZS? are you guys having any performance d=
ata like 16K RW/RR for reference?

  Thanks,
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

On 1/23/17, 12:40 PM, "Somnath Roy" <Somnath.Roy@sandisk.com> wrote:

    Hi James,
    Sorry, if I was not clear earlier. The 3rd sheet in the xls is with blu=
estore + rocks (not ZS)  and sole purpose of that is to demonstrate the bene=
fit of multi kv sync threads.
    The test I ran here without preconditioning the image unlike sheet 1 an=
d 2. This is why we are seeing the drop and it is mostly because of rocks co=
mpaction.=20
   =20
    Thanks & Regards
    Somnath
   =20
    -----Original Message-----
    From: LIU, Fei [mailto:james.liu@alibaba-inc.com]=20
    Sent: Sunday, January 22, 2017 7:04 PM
    To: Somnath Roy; Mark Nelson (mnelson@redhat.com); Sage Weil (sweil@red=
hat.com)
    Cc: ceph-devel
    Subject: Re: BlueStore: Multi sharded kv pull request
   =20
    Hi Somnath,
       Thanks for sharing data.  We can see iops drops a lot from 40000 to =
~15000 as time going by . Any particular reason for ZetaScale to drop that m=
uch in the time period?
   =20
       Regards,
       James
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
    On 1/21/17, 7:32 AM, "Somnath Roy" <ceph-devel-owner@vger.kernel.org on=
 behalf of Somnath.Roy@sandisk.com> wrote:
   =20
        Hi Mark/Sage,
        Please find the different comparison data in the following document=
.
       =20
        https://drive.google.com/file/d/0B7W-S0z_ymMJUXVmOUhINU01c3c/view?u=
sp=3Dsharing
       =20
        Please download the doc (and open in xls) as google is not able to =
show the graphs properly.
       =20
        Setup:
        ------
        Single osd on 700G nvme drive and single osd on 2 700G nvme drive (=
LVM ed)
        48 core server, 40G link
        Test is only for 4K RW from fio.
       =20
        1. The first sheet is showing iops and cpu utilization for Bluestor=
 + rocks , Bluestore + Zs and filestore.
        This is with small shards and with the hack we are using for precon=
ditioning.
        Bluestore + rocks with 16K min_alloc and ZS with 4k min_alloc
       =20
        WE can see Bluestore with rocks and ZS is behaving almost similarly=
 for a 600G image and it is ~2X higher than filestore. ZS cpu utilization an=
d WA (data not there in xls) is higher than rocks.
       =20
        2. Next, I created 3 LVM volumes (data/db/wal) out of 2 NVMe drives=
 and created an image of 1TB. See in the next sheet how bluestore + rocks pe=
rformance came down. Didn't have time for the filestore data but expectation=
 is it will remain similar to previous sheet. Now, ZS is running with 16k mi=
n_alloc size here with the prototype shim implementation I was talking about=
 in the standup.
        This is with this implementation is not fully crash safe but expect=
ation is when we will be done with implementing this write ahead log impleme=
ntation in ZS it should produce similar throughput.
        This is giving ~90% benefir over rocks and ZS with 4k min_alloc (li=
ke previous sheet) is giving ~50% benefit (not plotted here). Cpu util is si=
milar to rocks.
       =20
       =20
        3. This sheet is to demonstrate the benefit of single kv sync vs mu=
lti kv sync with rocks. With ZS we *need* multi kv but with rocks as you can=
 see we are gaining (~20%) only during the peak performance.
        Later db is getting in the way. I think peak performance is limited=
 to day by osd upstream , if in future we can optimize that and allow more t=
raffic to come in the Bluestore (objectstore) , the benefit of multiple shar=
ded kv sync will be more. Here is the pull request for this..
       =20
        https://github.com/ceph/ceph/pull/13037
       =20
        Thanks & Regards
        Somnath
       =20
        ________________________________
       =20
        PLEASE NOTE: The information contained in this electronic mail mess=
age is intended only for the use of the designated recipient(s) named above.=
 If the reader of this message is not the intended recipient, you are hereby=
 notified that you have received this message in error and that any review, =
dissemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electro=
nically stored copies).
       =20
        --
        To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
        the body of a message to majordomo@vger.kernel.org
        More majordomo info at  http://vger.kernel.org/majordomo-info.html
       =20
   =20
   =20
   =20


