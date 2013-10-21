From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: issues when bucket index deep-scrubbing
Date: Mon, 21 Oct 2013 22:44:38 +0200
Message-ID: <CAMNMNTwfVTRaC4popOSBQ+ZqhGz7hMxiCAEc0XfAV_90dKjsSA@mail.gmail.com>
References: <CAMNMNTyRDoQX=ytzF-jporD3uTpaUiJqTXEzqYGetqUerJ5=-g@mail.gmail.com>
	<CAPYLRzjFRn=SHOs5JiEqGow0hgnbOEMkqrqwTi9W0cX4EAe=KA@mail.gmail.com>
	<CAMNMNTzc6V90xg89Fi+yNk-Boq0oTM7JQys49qYDnjs5TOjg1Q@mail.gmail.com>
	<CAPYLRzj=RuPn1-4=wTAkqGDu2tjZor-bh0r3eur99CiyQzrXGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:65330 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab3JUUoj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 16:44:39 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii20so2803291qab.17
        for <ceph-devel@vger.kernel.org>; Mon, 21 Oct 2013 13:44:38 -0700 (PDT)
In-Reply-To: <CAPYLRzj=RuPn1-4=wTAkqGDu2tjZor-bh0r3eur99CiyQzrXGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Thanks, for now i'm sure what to do.

Maybe there is another way ( except turning off deep-scrubbing) to
avoid issues caused by large indexes?

Now we have ~15m bojects in the largest bucket.
In the short term(after sharding) we want to put there 100m object more.
Are there any other limitations in ceph that can affect us?

--
Regards
Dominik


2013/10/21 Gregory Farnum <greg@inktank.com>:
> On Mon, Oct 21, 2013 at 2:26 AM, Dominik Mostowiec
> <dominikmostowiec@gmail.com> wrote:
>> Hi,
>> Thanks for your response.
>>
>>> That is definitely the obvious next step, but it's a non-trivial
>>> amount of work and hasn't yet been started on by anybody. This is
>>> probably a good subject for a CDS blueprint!
>> But we want to split our big bucket into the smallest ones. We want to
>> shard it before radosgw.
>> Do you think this is a good idea to make workaround of this problem
>> (big index issues)?
>
> Oh, yes, this is a good workaround.
> Sorry, I misread your initial post and thought you were discussing
> sharding the bucket index itself, rather than sharding across buckets
> in the application. :)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
>>
>> Regards
>> Dominik
>>
>>
>>
>> 2013/10/18 Gregory Farnum <greg@inktank.com>:
>>> On Fri, Oct 18, 2013 at 4:01 AM, Dominik Mostowiec
>>> <dominikmostowiec@gmail.com> wrote:
>>>> Hi,
>>>> I plan to shard my largest bucket because of issues of deep-scrubbing
>>>> (when PG which index for this bucket is stored on is deep-scrubbed, it
>>>> appears many slow requests and OSD grows in memory - after latest
>>>> scrub it grows up to 9G).
>>>>
>>>> I trying to found why large bucket index make issues when it is scrubbed.
>>>> On test cluster:
>>>> radosgw-admin bucket stats --bucket=test1-XX
>>>> { "bucket": "test1-XX",
>>>>   "pool": ".rgw.buckets",
>>>>   "index_pool": ".rgw.buckets",
>>>>   "id": "default.4211.2",
>>>> ...
>>>>
>>>> I guess index is in object .dir.default.4211.2. (pool: .rgw.buckets)
>>>>
>>>> rados -p .rgw.buckets get .dir.default.4211.2 -
>>>> <empty>
>>>>
>>>> But:
>>>> rados -p .rgw.buckets listomapkeys .dir.default.4211.2
>>>> test_file_2.txt
>>>> test_file_2_11.txt
>>>> test_file_3.txt
>>>> test_file_4.txt
>>>> test_file_5.txt
>>>>
>>>> I guess that list of files are stored in leveldb not in one large file.
>>>> 'omap' files are stored in {osd_dir}/current/omap/, the largest file
>>>> that i found in this directory (on production) have 8.8M.
>>>>
>>>> I'm a little confused.
>>>>
>>>> How list of files (for bucket) is stored?
>>>
>>> The index is stored as a bunch of omap entries in a single object.
>>>
>>>> If list of objects in bucket is splitted on many small files in
>>>> leveldb that large bucket (with many files) should not cause larger
>>>> latency in PUT new object.
>>>
>>> That's not quite how it works. Leveldb has a custom storage format in
>>> which it stores sets of keys based on both time of update and the
>>> value of the key, so the size of the individual files in its directory
>>> has no correlation to the number or size of any given set of entries.
>>>
>>>> Scrubbing also should not be a problem i think ...
>>>
>>> The problem you're running into is that scrubbing is done on an
>>> object-by-object basis, and so the OSD is reading all of the keys
>>> associated with that object out of leveldb, and processing them, at
>>> once. This number can be very much larger than the 8MB file you've
>>> found in the leveldb directory, as discussed above.
>>>
>>>> What you think about using a sharding to split big buckets into the
>>>> smalest one to avoid the problems with big indexes?
>>>
>>> That is definitely the obvious next step, but it's a non-trivial
>>> amount of work and hasn't yet been started on by anybody. This is
>>> probably a good subject for a CDS blueprint!
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>>
>> --
>> Pozdrawiam
>> Dominik



-- 
Pozdrawiam
Dominik
