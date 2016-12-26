From: deming jia <jiademing.dd@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=EF=BC=88krbd=EF=BC=89rbd_map_failed_on_aarch64_by_jewel?=
Date: Mon, 26 Dec 2016 17:21:06 +0800
Message-ID: <CABmAqELGj-_Wmgjc1ftgG9A5uQ5s_Bm-C5+V_XEgho+MQ=YqzA@mail.gmail.com>
References: <CABmAqEJQWQm-eP2akTPjwqZaKV5TkXw-rUBHqQRtQcAsFm9mvg@mail.gmail.com>
 <A2F6736D5AC58C448B8B7D859805FD15075E98@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37975 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbcLZJVH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Dec 2016 04:21:07 -0500
Received: by mail-it0-f52.google.com with SMTP id x2so147250833itf.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Dec 2016 01:21:07 -0800 (PST)
In-Reply-To: <A2F6736D5AC58C448B8B7D859805FD15075E98@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

   Sorry, I express is not correct. I mean I can put data into rbd
pool, not hello image.



On Sat, Dec 24, 2016 at 10:20 PM, Varada Kari <Varada.Kari@sandisk.com> wro=
te:
> Hi,
>
> How are you writing data using rados to hello image? ?
> And this one seems to be bad header on the message, could you please
> enable debug_ms to 20/20 and post the logs some where to take a look.
>
> Varada
>
> On Saturday 24 December 2016 01:28 PM, deming jia wrote:
>> the rbd create hello --size 10240
>> I can put data into hello by rados=EF=BC=8C then
>> rbd map hello=EF=BC=8C but failed=EF=BC=9A
>>  rbd: sysfs write failed
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
>
