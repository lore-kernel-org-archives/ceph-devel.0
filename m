From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Fwd: Cache pool bug?
Date: Tue, 28 Oct 2014 13:39:22 +0800
Message-ID: <CANE=7sW7ujhb+YzWUFJ0XfeubMELWwOTyNcth6UM9Eu+bTJeOA@mail.gmail.com>
References: <CANE=7sUW0e-vp8LROZFA+5BGNoENA4MLthsnPUKb1ks=hnoyEA@mail.gmail.com>
	<BLU169-W9B3F7EAC2250B1425B560DA9E0@phx.gbl>
	<06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410270902320.13498@cobra.newdream.net>
	<CANE=7sVJLeCBkSzNM9cC0k0YOCgapBdMVeYP=GqncTKtup5eKw@mail.gmail.com>
	<06E7D85B3BA36C4DB207FEDE871C5348950D90@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410272100310.7897@cobra.newdream.net>
	<CANE=7sWu2aXfAYRXNTqkUvGkxmkyYjmeJbt=j-8SaUNwbu4Rvw@mail.gmail.com>
	<CANE=7sW1m=sJNoTPiVUMo-XPSpefk5++fSTzmb8RPMwDyOYV9A@mail.gmail.com>
	<CANE=7sWE1Rx8Bg7SCb5ASLFNGrteh3Noyqaop-s4rKKwB2Gikw@mail.gmail.com>
	<06E7D85B3BA36C4DB207FEDE871C5348950F34@SHSMSX101.ccr.corp.intel.com>
	<CANE=7sX6oaXKKiSB5Se50=Ht3tJsQE5a=AKBLBo37Q0+pZjRrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42918 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbaJ1FjW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 01:39:22 -0400
Received: by mail-oi0-f48.google.com with SMTP id x69so3021714oia.7
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 22:39:22 -0700 (PDT)
In-Reply-To: <CANE=7sX6oaXKKiSB5Se50=Ht3tJsQE5a=AKBLBo37Q0+pZjRrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
=46rom: =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail.com>
Date: 2014-10-28 13:37 GMT+08:00
Subject: Re: Cache pool bug?
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>


If we use the timestamp,

get_position_micro(int32_t v, uint64_t *lower, uint64_t *upper)

    unsigned bin =3D calc_bits_of(v); // this function will return the
same value at most time, this may be a problem.


2014-10-28 12:50 GMT+08:00 Wang, Zhiqiang <zhiqiang.wang@intel.com>:
> Yes, if we change atime to be a timestamp, we also need to change the=
 code for the case when the object is not in any hit sets.
>
> -----Original Message-----
> From: =E6=B1=A0=E4=BF=A1=E6=B3=BD [mailto:xmdxcxz@gmail.com]
> Sent: Tuesday, October 28, 2014 12:46 PM
> To: Sage Weil; Wang, Zhiqiang; ceph-devel@vger.kernel.org
> Subject: Re: Cache pool bug?
>
> If it changed to be *atime =3D p->first
>
> we should change ReplicatedPG::agent_maybe_evict
>     if (atime < 0 && obc->obs.oi.mtime !=3D utime_t()) {
>       if (obc->obs.oi.local_mtime !=3D utime_t()) {
>         atime =3D obc->obs.oi.local_mtime;
>       } else {
>         atime =3D obc->obs.oi.mtime;
>       }
>     }
>     if (atime < 0)
>       atime =3D 0; // or other
>
> void ReplicatedPG::agent_estimate_atime_temp(const hobject_t& oid,
>     int *atime, int *temp)
> {
>   assert(hit_set);
>    time_t now =3D ceph_clock_now(NULL).sec();
>   *atime =3D -1;
>   if (temp)
>     *temp =3D 0;
>   if (hit_set->contains(oid)) {
>     *atime =3D now;
>     if (temp)
>       ++(*temp);
>     else
>       return;
>   }
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
> }
>
> 2014-10-28 12:36 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail=
=2Ecom>:
>> I am sorry. We should only just modify the logic
>> ReplicatedPG::agent_estimate_atime_temp, atime should be now.
>>
>>   if (temp)
>>     *temp =3D 0;
>>   if (hit_set->contains(oid)) {
>>     *atime =3D 0;
>>     if (temp)
>>       ++(*temp);
>>     else
>>       return;
>>   }
>>
>> 2014-10-28 12:28 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmai=
l.com>:
>>> I think if it changed to be  *atime =3D p->first, Below logic shoul=
d
>>> also be modified.
>>>
>>> ReplicatedPG::agent_maybe_evict
>>>
>>>     if (atime < 0 && obc->obs.oi.mtime !=3D utime_t()) {
>>>       if (obc->obs.oi.local_mtime !=3D utime_t()) {
>>>         atime =3D ceph_clock_now(NULL).sec() - obc->obs.oi.local_mt=
ime;
>>>       } else {
>>>         atime =3D ceph_clock_now(NULL).sec() - obc->obs.oi.mtime;
>>>       }
>>>     }
>>>
>>>
>>> including
>>> ReplicatedPG::agent_estimate_atime_temp
>>>   if (temp)
>>>     *temp =3D 0;
>>>   if (hit_set->contains(oid)) {
>>>     *atime =3D 0;
>>>     if (temp)
>>>       ++(*temp);
>>>     else
>>>       return;
>>>   }
>>>
>>> 2014-10-28 12:02 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>> Yep.  The pull request looks is correct too, but needs to be
>>>> squashed into a single commit with a Signed-off-by: line and descr=
iption.
>>>>
>>>> Zhiqiang, I think the reversed logic you just fixed in
>>>> agent_maybe_evict() was partly because this function is filling in
>>>> atime (which sounds like a
>>>> timestamp) with an *age* (now - p->first).  I think we should chan=
ge
>>>>
>>>>>       if (*atime < 0)
>>>>>       *atime =3D now - p->first;
>>>>
>>>> to be
>>>>
>>>>  *atime =3D p->first
>>>>
>>>> and/or adjust the caller accordingly...?
>>>>
>>>> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
