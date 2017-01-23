From: Haodong Tang <tanghaodong25@gmail.com>
Subject: Re: BlueStore: Multi sharded kv pull request
Date: Mon, 23 Jan 2017 15:13:44 +0800
Message-ID: <CACYTDmiTubsHo3sLaAH6Bv2-x7MnMJbG3rhEgkZ0Nx76UBY4+Q@mail.gmail.com>
References: <5E3E05AED7F0F044904275810D0CB465055CCA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <B9070C20-620C-4CDA-8B00-5B563F150693@alibaba-inc.com> <5E3E05AED7F0F044904275810D0CB465055E65@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35885 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWHNq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 02:13:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so24108053wmr.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jan 2017 23:13:45 -0800 (PST)
In-Reply-To: <5E3E05AED7F0F044904275810D0CB465055E65@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "LIU, Fei" <james.liu@alibaba-inc.com>, "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

What were the differences in OSD/KV configuration between test 1 and
2? If I understand correctly, by increasing volume size from 600GB to
1TB, for bluestore+rocksdb, IOPS dropped down from 28000 to 14000 for
bluestore+rocks and for bluestore+zs, IOPS dropped down from 28000 to
24000 for bluestore+zs?

Thanks,
Haodong

On 23 January 2017 at 12:40, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi James,
> Sorry, if I was not clear earlier. The 3rd sheet in the xls is with blues=
tore + rocks (not ZS)  and sole purpose of that is to demonstrate the benef=
it of multi kv sync threads.
> The test I ran here without preconditioning the image unlike sheet 1 and =
2. This is why we are seeing the drop and it is mostly because of rocks com=
paction.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: LIU, Fei [mailto:james.liu@alibaba-inc.com]
> Sent: Sunday, January 22, 2017 7:04 PM
> To: Somnath Roy; Mark Nelson (mnelson@redhat.com); Sage Weil (sweil@redha=
t.com)
> Cc: ceph-devel
> Subject: Re: BlueStore: Multi sharded kv pull request
>
> Hi Somnath,
>    Thanks for sharing data.  We can see iops drops a lot from 40000 to ~1=
5000 as time going by . Any particular reason for ZetaScale to drop that mu=
ch in the time period?
>
>    Regards,
>    James
>
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E9=98=BF=E9=87=8C=E5=B7=B4=E5=B7=B4=E9=9B=86=E5=9B=A2=E7=9A=84=E5=
=95=86=E4=B8=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=
=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=
=E4=B8=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E5=92=8C=E7=BE=A4=E7=
=BB=84=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=
=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=
=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=
=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=
=B6=E5=92=8C=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=
=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=
=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=
=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82
> This email and its attachments contain confidential information from Alib=
aba Group.which is intended only for the person or entity whose address is =
listed above.Any use of information contained herein in any way(including,b=
ut not limited to,total or partial disclosure,reproduction or dissemination=
)by persons other than the intended recipient(s) is prohibited.If you recei=
ve this email in error,please notify the sender by phone or email immediate=
ly and delete it.
>
> On 1/21/17, 7:32 AM, "Somnath Roy" <ceph-devel-owner@vger.kernel.org on b=
ehalf of Somnath.Roy@sandisk.com> wrote:
>
>     Hi Mark/Sage,
>     Please find the different comparison data in the following document.
>
>     https://drive.google.com/file/d/0B7W-S0z_ymMJUXVmOUhINU01c3c/view?usp=
=3Dsharing
>
>     Please download the doc (and open in xls) as google is not able to sh=
ow the graphs properly.
>
>     Setup:
>     ------
>     Single osd on 700G nvme drive and single osd on 2 700G nvme drive (LV=
M ed)
>     48 core server, 40G link
>     Test is only for 4K RW from fio.
>
>     1. The first sheet is showing iops and cpu utilization for Bluestor +=
 rocks , Bluestore + Zs and filestore.
>     This is with small shards and with the hack we are using for precondi=
tioning.
>     Bluestore + rocks with 16K min_alloc and ZS with 4k min_alloc
>
>     WE can see Bluestore with rocks and ZS is behaving almost similarly f=
or a 600G image and it is ~2X higher than filestore. ZS cpu utilization and=
 WA (data not there in xls) is higher than rocks.
>
>     2. Next, I created 3 LVM volumes (data/db/wal) out of 2 NVMe drives a=
nd created an image of 1TB. See in the next sheet how bluestore + rocks per=
formance came down. Didn't have time for the filestore data but expectation=
 is it will remain similar to previous sheet. Now, ZS is running with 16k m=
in_alloc size here with the prototype shim implementation I was talking abo=
ut in the standup.
>     This is with this implementation is not fully crash safe but expectat=
ion is when we will be done with implementing this write ahead log implemen=
tation in ZS it should produce similar throughput.
>     This is giving ~90% benefir over rocks and ZS with 4k min_alloc (like=
 previous sheet) is giving ~50% benefit (not plotted here). Cpu util is sim=
ilar to rocks.
>
>
>     3. This sheet is to demonstrate the benefit of single kv sync vs mult=
i kv sync with rocks. With ZS we *need* multi kv but with rocks as you can =
see we are gaining (~20%) only during the peak performance.
>     Later db is getting in the way. I think peak performance is limited t=
o day by osd upstream , if in future we can optimize that and allow more tr=
affic to come in the Bluestore (objectstore) , the benefit of multiple shar=
ded kv sync will be more. Here is the pull request for this..
>
>     https://github.com/ceph/ceph/pull/13037
>
>     Thanks & Regards
>     Somnath
>
>     ________________________________
>
>     PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are hereby=
 notified that you have received this message in error and that any review,=
 dissemination, distribution, or copying of this message is strictly prohib=
ited. If you have received this communication in error, please notify the s=
ender by telephone or e-mail (as shown above) immediately and destroy any a=
nd all copies of this message in your possession (whether hard copies or el=
ectronically stored copies).
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
