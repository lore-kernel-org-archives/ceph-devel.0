From: YuFan Chen <wiz.chen@gmail.com>
Subject: Re: About the "temperature histogram" of tier-agent
Date: Fri, 1 Dec 2017 23:12:57 +0800
Message-ID: <CAHMqkF7VNzAMXhDRDaQhmpSjWCM8PWUckzn_P+dKeh+G1F5cTA@mail.gmail.com>
References: <CAHMqkF7XOhzrQJODwOGnz-0Y8echtdQPEamcNL126w5ctW4+Xg@mail.gmail.com>
 <alpine.DEB.2.11.1711281319000.2819@piezo.novalocal> <CAOsMsV2bmp1-Jdg0Ur+=oF+R=_9zjxw+hjODtN=wCz=VFaqnLQ@mail.gmail.com>
 <CAHMqkF5VckeHoMy2qhUR5M=ivzujGTaiAoutjW8LMjL7vQSxtQ@mail.gmail.com> <CAOsMsV1wuXE_mdvggCb7Yjk9WA+Qk31-cZnbzbRx2KfFk935qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:41581 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdLAPM6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Dec 2017 10:12:58 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so2790434ita.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 Dec 2017 07:12:58 -0800 (PST)
In-Reply-To: <CAOsMsV1wuXE_mdvggCb7Yjk9WA+Qk31-cZnbzbRx2KfFk935qQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <laurence.liwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, mingxinliu@ubuntukylin.com

Okay. I will do it.

Yufan Chen

2017-12-01 20:56 GMT+08:00 Li Wang <laurence.liwang@gmail.com>:
> Hi,
>   Would you please send a pr to fix this
>
> Cheers,
> Li Wang
>
> 2017-11-30 23:45 GMT+08:00 YuFan Chen <wiz.chen@gmail.com>:
>> Hi,
>>   Yes, it really means the ranking level in a
>>    'temperature' rating scale.
>>   Using 'temp_lower' would be better.
>>
>> Thanks.
>>
>> Yufan Chen
>>
>>
>> Li Wang <laurence.liwang@gmail.com> =E6=96=BC 2017=E5=B9=B411=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:51 =E5=AF=AB=E9=81=93=EF=
=BC=9A
>>>
>>> Hi,
>>>   This makes sense, the variable name 'temp_upper' is really confusing
>>> which in fact does not count the number of hot objects. However,
>>> personally,
>>> I prefer use  temp_lower as follows,
>>>
>>> if (temp_lower >=3D agent_state->evict_effort)
>>>   return false;
>>>
>>> Cheers,
>>> Li Wang
>>>
>>> 2017-11-28 21:20 GMT+08:00 Sage Weil <sage@newdream.net>:
>>> > Hi MingXin, Li,
>>> >
>>> > Does the below make sense to you?
>>> >
>>> > Thanks!
>>> > sage
>>> >
>>> >
>>> > On Tue, 28 Nov 2017, YuFan Chen wrote:
>>> >
>>> >> Hi,
>>> >>
>>> >>    Before Jewel, the code uses "atime" to distinguish hot/cold data:
>>> >>
>>> >>           agent_estimate_atime_temp() calculates the distance.
>>> >>           It means colder data gets longer distance (larger value)
>>> >>
>>> >>
>>> >>    In Jewel, it changes to use temperature with weight.
>>> >>             So, colder data gets smaller value.
>>> >>
>>> >>     However, it still use the "old semantics" to determine evicting =
or
>>> >> not in
>>> >>            ReplicatedPG::agent_estimate_atime_temp();
>>> >>
>>> >>     if (1000000 - temp_upper >=3D agent_state->evict_effort)
>>> >>        return false;
>>> >>
>>> >>
>>> >>      if there is no misunderstanding, should it change to that:
>>> >>
>>> >> --- a/src/osd/ReplicatedPG.cc
>>> >> +++ b/src/osd/ReplicatedPG.cc
>>> >> @@ -12211,7 +12211,7 @@ bool
>>> >> ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc, bool
>>> >> after_flush)
>>> >>      delete f;
>>> >>      *_dout << dendl;
>>> >>
>>> >> -    if (1000000 - temp_upper >=3D agent_state->evict_effort)
>>> >> +    if (temp_upper >=3D agent_state->evict_effort)
>>> >>        return false;
>>> >>    }
>>> >>
>>> >> Yu Fan
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>>> >> in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >>
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
