From: Ranjan Sarpangala Venkatesh <ranjansv@soe.ucsc.edu>
Subject: Re: Using valgrind_osd option
Date: Thu, 11 Jul 2013 23:45:08 -0700
Message-ID: <CA+bvTtn-Wut4W-iss3=Eq0n3PeLFp0z3Csywqf9iUC-Fx7yXzw@mail.gmail.com>
References: <CA+bvTtnt_GZEiwHgsmW_uWvjhFxE3QxyUTWX=nM6hs5E6ikLuQ@mail.gmail.com>
 <51DCB596.4040800@inktank.com> <CA+bvTtkDCOVMO3vXWsU+V00Q_4rO=ZZstxmi+SAedg0o6Cc2hw@mail.gmail.com>
 <51DF13D5.3020204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:49909 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab3GLGpa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 02:45:30 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so7876142wgg.20
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 23:45:29 -0700 (PDT)
In-Reply-To: <51DF13D5.3020204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,Mike

I reverted back to valgrind version 3.7.0, did what Sage suggested and
it worked. However, with valgrind 3.8.1 no massif.out file was created
even while running a build with no tcmalloc. Not sure why this is
happening.

Thanks Sage and Mark for your help.

With regards
Ranjan

On Thu, Jul 11, 2013 at 1:21 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> Hrm, I think I answered too quickly.  I use that directly with valgrind
> launching the daemon, not through vstart.  Not sure if it passes it through
> properly.  Maybe try Sage's suggestion or see if valgrind works when you
> launch the daemon directly?
>
> Mark
>
>
> On 07/11/2013 01:21 AM, Ranjan Sarpangala Venkatesh wrote:
>>
>> Hi Mark,
>>
>> I upgraded valgrind to 3.8.1 and also used
>> --soname-synonyms=somalloc=*tcmalloc* option. However, no massif.out
>> file was created.
>>
>> Kindly let me know if i am missing something.
>>
>> With regards
>> Ranjan
>>
>> On Tue, Jul 9, 2013 at 6:15 PM, Mark Nelson <mark.nelson@inktank.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> I ran into this problem a while back and it was because I was trying to
>>> use
>>> a version of valgrind that didn't support tcmalloc (which Ceph was
>>> compiled
>>> to use).  Try upgrading valgrind to 3.8.0 or newer.  You'll also need to
>>> pass something like:
>>>
>>> --soname-synonyms=somalloc=*tcmalloc*
>>>
>>> Mark
>>>
>>>
>>> On 07/09/2013 08:10 PM, Ranjan Sarpangala Venkatesh wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> I am trying to collect memory of the OSD daemon with the following
>>>>
>>>> ./vstart.sh -n -x -l --valgrind_osd 'massif'
>>>>
>>>> However, when I print massif.out file there is nothing
>>>>
>>>> cat massif.out.15391
>>>>
>>>> desc: (none)
>>>> cmd: ./ceph-osd -i 0 -c ceph.conf -f
>>>> time_unit: i
>>>> #-----------
>>>> snapshot=0
>>>> #-----------
>>>> time=0
>>>> mem_heap_B=0
>>>> mem_heap_extra_B=0
>>>> mem_stacks_B=0
>>>> heap_tree=empty
>>>>
>>>> --
>>>> With regards,
>>>> Ranjan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>>
>>
>



-- 
With regards,
Ranjan
