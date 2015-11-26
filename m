From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: why my cluster become unavailable (min_size of pool)
Date: Thu, 26 Nov 2015 16:00:02 +0800
Message-ID: <CACJqLybEM0qiFBYsH0Ybg-R0X1xyf8UrWwY+9voR+eNfk-jNjQ@mail.gmail.com>
References: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com>
	<CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com>
	<alpine.DEB.2.00.1511210948270.24879@cobra.newdream.net>
	<5652651C.8040902@gmail.com>
	<5656BA98.4090301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35953 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbKZIAC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Nov 2015 03:00:02 -0500
Received: by iofh3 with SMTP id h3so7216278iof.3
        for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2015 00:00:02 -0800 (PST)
In-Reply-To: <5656BA98.4090301@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hzwulibin <hzwulibin@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 26, 2015 at 3:54 PM, hzwulibin <hzwulibin@gmail.com> wrote:
> Hi, Sage
>
> I has a question about min_size of pool.
>
> The default value of min_size is 2, but in this setting, when two OSD=
s are down(mean two replicas lost) at same time, the IO will be blocked=
=2E
> We want to set the min_size to 1 in our production environment as we =
think it's normal case when two OSDs are down(sure on different host) a=
t same time.

min_size with 2 means each object must ensure two copies in this pool.
It mainly reduce the permanent storage media corrupt risk which cause
actual data lose. That's mean if min_size is 1 and under this degraded
case, one more osd  permanent corrupt will cause data lose. If
min_size is 2, it need at least 2 osds.

>
> So is there anypotential problem of this setting?
>
> We use 0.80.10 version.
>
> Thanks!
>
>
> ------------------
> hzwulibin
> 2015-11-26
>
> -------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A"hzwulibin"<hzwulibin@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=A5=E6=9C=9F=EF=BC=9A2015-11-23 09:00
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ASage Weil,Haomai Wang
> =E6=8A=84=E9=80=81=EF=BC=9Aceph-devel
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: why my cluster become unavailable
>
> Hi, Sage
>
> Thanks! Will try it when next testing!
>
> ------------------
> hzwulibin
> 2015-11-23
>
> -------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9ASage Weil <sage@newdream.net>
> =E5=8F=91=E9=80=81=E6=97=A5=E6=9C=9F=EF=BC=9A2015-11-22 01:49
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AHaomai Wang
> =E6=8A=84=E9=80=81=EF=BC=9ALibin Wu,ceph-devel
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: why my cluster become unavailable
>
> On Sun, 22 Nov 2015, Haomai Wang wrote:
>> On Thu, Nov 19, 2015 at 11:26 PM, Libin Wu <hzwulibin@gmail.com> wro=
te:
>> > Hi, cepher
>> >
>> > I have a cluster of 6 OSD server, every server has 8 OSDs.
>> >
>> > I out 4 OSDs on every server, then my client io is blocking.
>> >
>> > I reboot my client and then create a new rbd device, but the new
>> > device also can't write io.
>> >
>> > Yeah, i understand that some data may lost as threee replicas of s=
ome
>> > object were lost, but why the cluster become unavailable?
>> >
>> > There 80 incomplete pg and 4 down+incomplete pg.
>> >
>> > Any solution i could solve the problem?
>>
>> Yes, if you doesn't have a special crushmap to control the data
>> replcement policy, pg will lack of necessary metadata to boot. If ne=
ed
>> to readd outed osds or force remove pg which is incomplete(hope it's
>> just a test).
>
> Is min_size 2 or 1?  Reducing it to 1 will generally clear some of th=
e
> incomplete pgs.  Just remember to raise it back to 2 after the cluste=
r
> recovers.
>
> sage
>
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
