From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: ceph-qa analysis output
Date: Sat, 17 Jan 2015 16:27:41 -0800
Message-ID: <CAJBxG-v8+jWxaVpCspv72DPjXfO+7+FeFZr2y+6umsh9xD22=A@mail.gmail.com>
References: <54BA5E8D.30508@dachary.org>
	<CAJBxG-tjfWt+=HGJF0sZBFRFnYuCs_VdVpQzO8XAXs3ooE4e1g@mail.gmail.com>
	<54BAEFDF.50106@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:65413 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbARA1m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jan 2015 19:27:42 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so24307814obb.9
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 16:27:41 -0800 (PST)
In-Reply-To: <54BAEFDF.50106@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sounds good, Loic

Are you aware BTW about scrape tool written by John Spray?
https://github.com/jcsp/scrape

I use it for test runs analysis often.

Just FYI

Thx
YuriW

On Sat, Jan 17, 2015 at 3:27 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 17/01/2015 23:08, Yuri Weinstein wrote:
>> Hi Loic,
>>
>> I'd love to.
>>
>> Let's chat on Monday to finalize format.
>>
>> (
>> PS:  I think format would be easier to maintain like new lines enfor=
ced, e,g.
>>
>> '701575', '701576', '701582', '701590'
>>  ttp://tracker.ceph.com/issues/10543
>> FAILED assert(m_seed < old_pg_num
>
> Yes, as long as it's consistent enough to be machine readable, that w=
orks :-)
>
>>
>> PPS: Again this ticket http://tracker.ceph.com/issues/10455 would be
>> helpful in what we are discussing here.
>>
>
> I'm not sure where the output of such a parsing would go. The update =
redmine API is currently broken (the read API works ok) but if it was f=
ixed the tickets could be updated indeed.
>
> Cheers
>
>> Thx
>> YuriW
>>
>> On Sat, Jan 17, 2015 at 5:07 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Yuri,
>>>
>>> It would be great if the analysis you compile daily was machine rea=
dable. For instance, in a mail you sent to ceph-qa I read
>>>
>>> '701575', '701576', '701582', '701590' - known issue
>>> http://tracker.ceph.com/issues/10543
>>>
>>> "FAILED assert(m_seed < old_pg_num)"
>>>
>>> (duplicate of http://tracker.ceph.com/issues/10430)
>>>
>>> which could be something like:
>>>
>>> '701575', '701576', '701582', '701590': http://tracker.ceph.com/iss=
ues/10543 FAILED assert(m_seed < old_pg_num)
>>>
>>> or any other format you find easier to use consistently.
>>>
>>> The reason I ask is because it would help me write a script that as=
sociates redmine tickets to your findings, in the context of backportin=
g. It's just an idea, not a request ;-)
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
