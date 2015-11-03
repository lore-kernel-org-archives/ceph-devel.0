From: Samuel Just <sjust@redhat.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTogYW5vdGhlciBwZWVyaW5nIA==?=
	=?UTF-8?B?c3R1Y2sgY2F1c2VkIGJ5IG5ldCBwcm9ibGVtLg==?=
Date: Mon, 2 Nov 2015 17:28:08 -0800
Message-ID: <CAN=+7FVaQqkN27_7mENWY38a+5HcQOKVug1zR_B4ar+7jwe2Sg@mail.gmail.com>
References: <5F4E7462F2F4A14E974FBE17B8EB37210E5B1FB1@H3CMLB12-EX.srv.huawei-3com.com>
	<CAN=+7FVJaD2fpgFuEPJ0Mincv5M4K+w_qg0DHYxsXU-4R5=o=w@mail.gmail.com>
	<0C3F6DA3760D0C4691E69E5BE224FF495E17479D@H3CMLB12-EX.srv.huawei-3com.com>
	<CAN=+7FW+6x39_Z0uXNuCjwQUPC4EPQTSDC1iG_duycdmvLZF9g@mail.gmail.com>
	<0C3F6DA3760D0C4691E69E5BE224FF495E1759B9@H3CMLB12-EX.srv.huawei-3com.com>
	<CAN=+7FU4kwfJDxCDn9TRd+6sjKKZpWwLbd=tUpqCKgv9V_GMTw@mail.gmail.com>
	<0C3F6DA3760D0C4691E69E5BE224FF495E175A2E@H3CMLB12-EX.srv.huawei-3com.com>
	<CAN=+7FXcr82-WWV6UK2WC3-nU+V907LpgqL7+YZUEEJX_+Z4nw@mail.gmail.com>
	<0C3F6DA3760D0C4691E69E5BE224FF495E175A81@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36546 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbKCB2J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 20:28:09 -0500
Received: by ioll68 with SMTP id l68so4928880iol.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 17:28:08 -0800 (PST)
In-Reply-To: <0C3F6DA3760D0C4691E69E5BE224FF495E175A81@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "yangruifeng.09209@h3c.com" <yangruifeng.09209@h3c.com>
Cc: Chenxiaowei <chen.xiaowei@h3c.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Temporary network failures should be handled correctly.  The best
solution is to actually fix that bug then.  Capture logging on all
involved osds while it is hung and open a bug:

debug osd =3D 20
debug filestore =3D 20
debug ms =3D 1
-Sam

On Mon, Nov 2, 2015 at 5:24 PM, yangruifeng.09209@h3c.com
<yangruifeng.09209@h3c.com> wrote:
> a unknown reason problem, which cause pg stuck in peering, may be a t=
emporary failure network failure or other bug.
> BUT it can be solved by *manual* 'ceph osd down <osdid>'
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: ceph-devel-owner@vger.kernel.org [mailto=
:ceph-devel-owner@vger.kernel.org] =E4=BB=A3=E8=A1=A8 Samuel Just
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B411=E6=9C=883=E6=97=
=A5 9:12
> =E6=94=B6=E4=BB=B6=E4=BA=BA: yangruifeng 09209 (RD)
> =E6=8A=84=E9=80=81: chenxiaowei 11245 (RD); Sage Weil (sweil@redhat.c=
om); ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: =E7=AD=
=94=E5=A4=8D: another peering stuck caused by net problem.
>
> The problem is that peering shouldn't hang for no reason.  If you are=
 seeing peering hang for a long time either
> 1) you are hitting a peering bug which we need to track down and fix
> 2) peering actually cannot make progress.
>
> In case 1, it can be nice to have a work around to force peering to r=
estart and avoid the bug.  However, case 2 would not be helped by resta=
rting peering, you'd just end up in the same place.  If you did it base=
d on a timeout, you'd just increase load by a ton when in that situatio=
n.  What problem are you trying to solve?
> -Sam
>
> On Mon, Nov 2, 2015 at 5:05 PM, yangruifeng.09209@h3c.com <yangruifen=
g.09209@h3c.com> wrote:
>> ok.
>>
>> thanks
>> Ruifeng Yang
>>
>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Samuel Just [mailto:sjust@redhat.com]
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B411=E6=9C=883=E6=97=
=A5 9:03
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: yangruifeng 09209 (RD)
>> =E6=8A=84=E9=80=81: chenxiaowei 11245 (RD); Sage Weil (sweil@redhat.=
com)
>> =E4=B8=BB=E9=A2=98: Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: anot=
her peering stuck caused by net problem.
>>
>> Would it be ok if I reply to the list as well?
>> -Sam
>>
>> On Mon, Nov 2, 2015 at 4:37 PM, yangruifeng.09209@h3c.com <yangruife=
ng.09209@h3c.com> wrote:
>>> the cluster is maybe always peering in same exceptional cases, but =
it
>>> can return to normal by *manual* 'ceph osd down <osdid>', this is n=
ot
>>> convenient in a production environment, and against the concept of =
rados.
>>> add a timeout mechanism to kick it, or kick it when io hang, maybe =
reasonable?
>>>
>>> thanks,
>>> Ruifeng Yang
>>>
>>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Samuel Just [mailto:sjust@redhat.com]
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B411=E6=9C=883=E6=97=
=A5 2:21
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: yangruifeng 09209 (RD)
>>> =E6=8A=84=E9=80=81: chenxiaowei 11245 (RD); Sage Weil (sweil@redhat=
=2Ecom)
>>> =E4=B8=BB=E9=A2=98: Re: =E7=AD=94=E5=A4=8D: another peering stuck c=
aused by net problem.
>>>
>>> I mean issue 'ceph osd down <osdid>' for the primary on the pg.  Bu=
t that only causes peering to restart.  If peering stalled previously, =
it'll probably stall again.  What are you trying to accomplish?
>>> -Sam
>>>
>>> On Fri, Oct 30, 2015 at 5:51 PM, yangruifeng.09209@h3c.com <yangrui=
feng.09209@h3c.com> wrote:
>>>> do you mean restart primary osd? or any other command=EF=BC=9F
>>>>
>>>> thanks
>>>> Ruifeng Yang
>>>>
>>>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Samuel Just [mailto:sjust@redhat.com]
>>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B410=E6=9C=8830=E6=
=97=A5 23:07
>>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: chenxiaowei 11245 (RD)
>>>> =E6=8A=84=E9=80=81: Sage Weil (sweil@redhat.com); yangruifeng 0920=
9 (RD)
>>>> =E4=B8=BB=E9=A2=98: Re: another peering stuck caused by net proble=
m.
>>>>
>>>> How would that help?  As a way to work around a possible bug?  You=
 can accomplish pretty much the same thing by setting the primary down.
>>>> -Sam
>>>>
>>>> On Wed, Oct 28, 2015 at 8:22 PM, Chenxiaowei <chen.xiaowei@h3c.com=
> wrote:
>>>>> Hi, Samuel&Sage:
>>>>>         I am cxwshawn from H3C(belong to HP), the pg peering stuc=
k
>>>>> problem is a serious problem especially under the production envi=
ronment, So here we came up two solutions:
>>>>>         if state Peering stuck too long, we can check timeout
>>>>> exceeds to force transition from Peering to Reset state, Or we ca=
n add a command line to force one pg from Peering stuck to Reset state.
>>>>>
>>>>> What's your advice? Wish your reply
>>>>>
>>>>> Yours
>>>>> shawn from Beijing, China.
>>>>>
>>>>> -----------------------------------------------------------------=
--
>>>>> -
>>>>> -
>>>>> -
>>>>> ---------------------------------------------------------------
>>>>> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=
=90=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=
=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=
=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=
=87=BA
>>>>> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=
=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=
=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=
=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=
=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=
=80=81
>>>>> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=
=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=
=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=
=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=
=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=
=9C=AC
>>>>> =E9=82=AE=E4=BB=B6=EF=BC=81
>>>>> This e-mail and its attachments contain confidential information
>>>>> from H3C, which is intended only for the person or entity whose
>>>>> address is listed above. Any use of the information contained
>>>>> herein in any way (including, but not limited to, total or partia=
l
>>>>> disclosure, reproduction, or dissemination) by persons other than
>>>>> the intended
>>>>> recipient(s) is prohibited. If you receive this e-mail in error,
>>>>> please notify the sender by phone or email immediately and delete=
 it!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
