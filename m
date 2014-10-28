From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: Cache pool bug?
Date: Tue, 28 Oct 2014 09:44:49 +0800
Message-ID: <CANE=7sUg9VdN3eTof5pmYiAqU-LcC79sX3zz-40Mw8kDC5rAxg@mail.gmail.com>
References: <CANE=7sUW0e-vp8LROZFA+5BGNoENA4MLthsnPUKb1ks=hnoyEA@mail.gmail.com>
	<BLU169-W9B3F7EAC2250B1425B560DA9E0@phx.gbl>
	<06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410270902320.13498@cobra.newdream.net>
	<CANE=7sVJLeCBkSzNM9cC0k0YOCgapBdMVeYP=GqncTKtup5eKw@mail.gmail.com>
	<CANE=7sVM1TbZm1eYRHMiXj47673Qgu4fFBmPG_MV0PDCJ1WoNw@mail.gmail.com>
	<CANE=7sVgT41r+WgZ+jdcNdesXSC8ib-dFzrNETYmRN0=3KqnLw@mail.gmail.com>
	<CANE=7sWyAsMgoOMBLUhnF5UaKaETK5mZe8TZE2ngfCCewjv9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:44911 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaJ1Bot convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 21:44:49 -0400
Received: by mail-oi0-f44.google.com with SMTP id h136so2898672oig.31
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 18:44:49 -0700 (PDT)
In-Reply-To: <CANE=7sWyAsMgoOMBLUhnF5UaKaETK5mZe8TZE2ngfCCewjv9kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Because if there are mutiple access time in agent_state for the same
object, we should use the recently one.

2014-10-28 9:42 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail.co=
m>:
> I think there is also bug in ReplicatedPG::agent_estimate_atime_temp
> I think we should change the following code:
>   for (map<time_t,HitSetRef>::iterator p =3D agent_state->hit_set_map=
=2Ebegin();
>        p !=3D agent_state->hit_set_map.end();
>        ++p) {
>     if (p->second->contains(oid)) {
>       if (*atime < 0)
> *atime =3D now - p->first;
>       if (temp)
> ++(*temp);
>       else
> return;
>     }
>   }
>
> to something like this:
>
>   for (map<time_t,HitSetRef>::iterator p =3D agent_state->hit_set_map=
=2Erbegin();
>        p !=3D agent_state->hit_set_map.rend();
>        ++p) {
>     if (p->second->contains(oid)) {
>       if (*atime < 0)
> *atime =3D now - p->first;
>       if (temp)
> ++(*temp);
>       else
> return;
>     }
>   }
>
> 2014-10-28 9:38 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail.=
com>:
>> I think there is also bug in ReplicatedPG::agent_estimate_atime_temp
>> I think we should change the following code:
>>   for (map<time_t,HitSetRef>::iterator p =3D agent_state->hit_set_ma=
p.begin();
>>        p !=3D agent_state->hit_set_map.end();
>>        ++p) {
>>     if (p->second->contains(oid)) {
>>       if (*atime < 0)
>> *atime =3D now - p->first;
>>       if (temp)
>> ++(*temp);
>>       else
>> return;
>>     }
>>   }
>>
>> to something like this:
>>
>>   for (map<time_t,HitSetRef>::iterator p =3D
>> agent_state->hit_set_map.rbegin();
>>        p !=3D agent_state->hit_set_map.rend();
>>        ++p) {
>>     if (p->second->contains(oid)) {
>>       if (*atime < 0)
>> *atime =3D now - p->first;
>>       if (temp)
>> ++(*temp);
>>       else
>> return;
>>     }
>>   }
>>
>> 2014-10-28 9:35 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail=
=2Ecom>:
>>>
>>>
>>>
>>> 2014-10-28 9:24 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmai=
l.com>:
>>>>
>>>> I think there is also bug in ReplicatedPG::agent_estimate_atime_te=
mp
>>>> I think we should change the following code:
>>>>   for (map<time_t,HitSetRef>::iterator p =3D
>>>> agent_state->hit_set_map.begin();
>>>>        p !=3D agent_state->hit_set_map.end();
>>>>        ++p) {
>>>>     if (p->second->contains(oid)) {
>>>>       if (*atime < 0)
>>>> *atime =3D now - p->first;
>>>>       if (temp)
>>>> ++(*temp);
>>>>       else
>>>> return;
>>>>     }
>>>>   }
>>>>
>>>> to something like this:
>>>>
>>>>   for (map<time_t,HitSetRef>::iterator p =3D
>>>> agent_state->hit_set_map.rbegin();
>>>>        p !=3D agent_state->hit_set_map.rend();
>>>>        ++p) {
>>>>     if (p->second->contains(oid)) {
>>>>       if (*atime < 0)
>>>> *atime =3D now - p->first;
>>>>       if (temp)
>>>> ++(*temp);
>>>>       else
>>>> return;
>>>>     }
>>>>   }
>>>>
>>>> Because if there are mutiple time_t in agent_state for the same ob=
ject,
>>>> we should use the recently one.
>>>>
>>>> 2014-10-28 0:04 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>>>
>>>>> On Mon, 27 Oct 2014, Wang, Zhiqiang wrote:
>>>>> > Hi,
>>>>> >
>>>>> > I agree with you this is a bug.
>>>>> >
>>>>> > I think we should change the following code:
>>>>> >
>>>>> >     // KISS: if [lower,upper] spans our target effort, evict it=
=2E
>>>>> >     if (atime_lower >=3D agent_state->evict_effort)
>>>>> >       return false;
>>>>> >
>>>>> > to something like this:
>>>>> >
>>>>> >     if (1000000 - atime_upper >=3D agent_state->evict_effort)
>>>>> >       return false;
>>>>> >
>>>>> > cc the ceph-devel list for comments.
>>>>>
>>>>> Yes, that does look backwards. Good catch!  If you submit a pull =
request
>>>>> we can get it merged and then backported.
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>>
>>>>> > ________________________________________
>>>>> > Date: Mon, 27 Oct 2014 10:20:01 +0800
>>>>> > Subject: Cache pool bug?
>>>>> > From: xmdxcxz@gmail.com
>>>>> > To: wonzhq@hotmail.com
>>>>> > hi, zhiqiang?
>>>>> >
>>>>> >      When I read the ReplicatedPG::agent_maybe_evic, I found th=
an the
>>>>> > newest object has
>>>>> >
>>>>> > more probability to be evicted. For Example:
>>>>> >
>>>>> >      the object in hit_set is newest object,   call
>>>>> >
>>>>> >       the funtion agent_estimate_atime_temp(soid, &atime, NULL =
/*FIXME
>>>>> > &temp*/); atime is 0 when return.
>>>>> >
>>>>> >      agent_state->atime_hist.get_position_micro(atime, &atime_l=
ower,
>>>>> > &atime_upper), the atime_lower is 0 when return.
>>>>> >
>>>>> >     // KISS: if [lower,upper] spans our target effort, evict it=
=2E
>>>>> >     if (atime_lower >=3D agent_state->evict_effort)
>>>>> >       return false;
>>>>> >
>>>>> >     Above, the newest object in hit_set is evicted.
>>>>> >
>>>>> >     Is there a bug? Or, whether I skip something?
>>>>> >
>>>>> >
>>>>> >     Thanks
>>>>> > N?????r??y??????X???v???)?{.n?????z?]z????ay? ????j ??f???h????=
? ?w???
>>>>> > ???j:+v???w???????? ????zZ+???????j"????i
>>>>
>>>>
>>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
