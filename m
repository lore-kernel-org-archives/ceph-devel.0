From: Li Wang <laurence.liwang@gmail.com>
Subject: Re: About the "temperature histogram" of tier-agent
Date: Thu, 30 Nov 2017 16:51:37 +0800
Message-ID: <CAOsMsV2bmp1-Jdg0Ur+=oF+R=_9zjxw+hjODtN=wCz=VFaqnLQ@mail.gmail.com>
References: <CAHMqkF7XOhzrQJODwOGnz-0Y8echtdQPEamcNL126w5ctW4+Xg@mail.gmail.com>
 <alpine.DEB.2.11.1711281319000.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45627 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdK3Ivi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 03:51:38 -0500
Received: by mail-qt0-f195.google.com with SMTP id g10so7782361qtj.12
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 00:51:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711281319000.2819@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: mingxinliu@ubuntukylin.com, ceph-devel@vger.kernel.org, YuFan Chen <wiz.chen@gmail.com>

Hi,
  This makes sense, the variable name 'temp_upper' is really confusing
which in fact does not count the number of hot objects. However, personally,
I prefer use  temp_lower as follows,

if (temp_lower >= agent_state->evict_effort)
  return false;

Cheers,
Li Wang

2017-11-28 21:20 GMT+08:00 Sage Weil <sage@newdream.net>:
> Hi MingXin, Li,
>
> Does the below make sense to you?
>
> Thanks!
> sage
>
>
> On Tue, 28 Nov 2017, YuFan Chen wrote:
>
>> Hi,
>>
>>    Before Jewel, the code uses "atime" to distinguish hot/cold data:
>>
>>           agent_estimate_atime_temp() calculates the distance.
>>           It means colder data gets longer distance (larger value)
>>
>>
>>    In Jewel, it changes to use temperature with weight.
>>             So, colder data gets smaller value.
>>
>>     However, it still use the "old semantics" to determine evicting or not in
>>            ReplicatedPG::agent_estimate_atime_temp();
>>
>>     if (1000000 - temp_upper >= agent_state->evict_effort)
>>        return false;
>>
>>
>>      if there is no misunderstanding, should it change to that:
>>
>> --- a/src/osd/ReplicatedPG.cc
>> +++ b/src/osd/ReplicatedPG.cc
>> @@ -12211,7 +12211,7 @@ bool
>> ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc, bool
>> after_flush)
>>      delete f;
>>      *_dout << dendl;
>>
>> -    if (1000000 - temp_upper >= agent_state->evict_effort)
>> +    if (temp_upper >= agent_state->evict_effort)
>>        return false;
>>    }
>>
>> Yu Fan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
