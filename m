From: Ning Yao <zay11022@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Can_i_improve_the_performance_of_rbd_rollback_in?=
	=?UTF-8?Q?_this_way=EF=BC=9F?=
Date: Tue, 17 Mar 2015 16:40:38 +0800
Message-ID: <CALZt5jxdfi0nO-Zir-cCCUX1G65bVj_fLb=3ene+hqmEnYsmLA@mail.gmail.com>
References: <CAO7bE7fXz7-An2REcJKSjsb-HZFMnfi0Bo-MWtskptmLDd=8_g@mail.gmail.com>
	<576710578.4735463.1426574609418.JavaMail.zimbra@oxygem.tv>
	<1047024924.4735475.1426574615914.JavaMail.zimbra@oxygem.tv>
	<CAO7bE7fXP1uQW-RtnPPsDozt-5hr0XR9=aZHCYcuOhWW0pKU1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35962 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbCQIkj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 04:40:39 -0400
Received: by oigv203 with SMTP id v203so2314760oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 01:40:38 -0700 (PDT)
In-Reply-To: <CAO7bE7fXP1uQW-RtnPPsDozt-5hr0XR9=aZHCYcuOhWW0pKU1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5b6Q5piV?= <xuxinhfut@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

2015-03-17 15:25 GMT+08:00 =E5=BE=90=E6=98=95 <xuxinhfut@gmail.com>:
> Hi Alexandre,
>
> I have tried this out. It can improve the performance of rbd rollback
> greatly when the difference between the image and the sanpshot is
> small.
>
If the clone does not happen in the rollback process, you may consider
it would properly happen when it is modified. I may agree, if one
object is always not modified since the snapshot N, it may be treated
as a cold object so that it is likely not to be modified in the
following period.

> But i'm not sure if this change may cause potential problem.
>
> Thanks
> Xin Xu
>
> 2015-03-17 14:43 GMT+08:00 Alexandre DERUMIER <aderumier@odiso.com>:
>> Hi,
>> I'm not sure it's helping for snapshot rollback, but hammer have a n=
ew object_map feature:
>>
>> https://wiki.ceph.com/Planning/Blueprints/Hammer/librbd%3A_shared_fl=
ag,_object_map
>>
>>
>> which help for resize,flatten,...
>>
>>
>> ----- Mail original -----
>> De: "=E5=BE=90=E6=98=95" <xuxinhfut@gmail.com>
>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Envoy=C3=A9: Mardi 17 Mars 2015 04:24:28
>> Objet: Can i improve the performance of rbd rollback in this way=EF=BC=
=9F
>>
>> Hi,
>>
>> I am a newbie to ceph. Recently i need to improve the performance of
>> rbd rollback on xfs in my project. Through experiment i found that t=
he
>> mechanism of rbd rollback is like this:
>>
>> When a image is rolled back to one of its snapshot (say N), for ever=
y
>> object that has been allocated,
>> case A) if the object has no snap version since snap N, then the hea=
d
>> version will be copied back to the latest snap (say N+M);
>> case B) if the object has snap version since snap N, and it has the
>> latest snap version (N+M), then the oldest snap version since snap N
>> (say N+x, 0<=3Dx<=3DM) will be copied to cover the head version;
>> case C) if the object has snap version since snap N, and it has no
>> version in the latest snap (N+M), then the head version will be copi=
ed
>> back to the latest snap N+M, and the oldest snap version since snap =
N
>> (say N+x, 0<=3Dx<M) will be copied to cover the head version.
>>
>> I think in case A, we need not to copied the head version back. So f=
or
>> improving performance, i comment the following statement in function
>> ReplicatedPG::_rollback_to in osd/ReplicatedPG.cc,
>>
>> ......
>> else if (rollback_to->obs.oi.soid.snap =3D=3D CEPH_NOSNAP) {
>> // rolling back to the head; we just need to clone it.
>> // ctx->modify =3D true;
>> }
>> ......
>>
>> Can i improve performance of rollback like this? If CAN NOT, what is=
 the reason?
>>
>> Thank you.
>>
>> Xin Xu
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
