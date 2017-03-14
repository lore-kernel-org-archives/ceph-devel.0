From: kefu chai <tchaikov@gmail.com>
Subject: Re: Can't compile because of -lpthreads
Date: Tue, 14 Mar 2017 21:15:08 +0800
Message-ID: <CAJE9aOPo4zXFw=FfymHaWN1aX2BbaNh3CwziH9PQ54BPFk9tuw@mail.gmail.com>
References: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
 <CAJE9aOMdgg=Y97PKPQGdxrMN1BShdVLS_QdZZA_1xx+yKgLKEg@mail.gmail.com>
 <CAAXqJ+qmmZTbDi-ipF_AThYO6bMvFxHjo4OZMxweW21fA0Gkyg@mail.gmail.com> <CAJE9aOMBGNs7F9hEyii55=XSs0rMPAdDAj7rjg_0iRnZtkiMjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34308 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdCNNPK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 09:15:10 -0400
Received: by mail-ua0-f196.google.com with SMTP id 72so21911428uaf.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 06:15:09 -0700 (PDT)
In-Reply-To: <CAJE9aOMBGNs7F9hEyii55=XSs0rMPAdDAj7rjg_0iRnZtkiMjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 14, 2017 at 9:13 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 8:57 PM, Spandan Kumar Sahu
> <spandankumarsahu@gmail.com> wrote:
>> On Tue, Mar 14, 2017 at 6:23 PM, kefu chai <tchaikov@gmail.com> wrote:
>>> On Tue, Mar 14, 2017 at 6:33 PM, Spandan Kumar Sahu
>>> <spandankumarsahu@gmail.com> wrote:
>>>> Hey everyone,
>>>>
>>>> I am interested in contributing to Ceph and thus I tried to build the
>>>> source code but unfortunately it has some errors. I will list out the
>>>> steps I did:
>>>>
>>>>  * Clone the ceph/ceph.git repo from github on my local machine
>>>>  * `./install_deps.sh`
>>>>  * `./do_cmake.sh`
>>>>
>>>> Now the last command shows some errors. This[1] is the output of
>>>> CMakeError.log file
>>>>  while this[2]. I am using Ubuntu 16.04 LTS.
>>>>
>>>> The particular problem is that my system can't recognise `-lpthreads`
>>>> but it recognises `-pthread` and `-lpthread`. I had tried a lot to
>>>> search this on the internet and also tried out all the stuff described
>>>> in the stackoverflow results but all in vain. I am familiar with
>>>> Makefiles but not so familiar with CMake files and thus couldn't
>>>> really find a solution. I would be really glad if someone could help!
>>>
>>> what cmake version are you using? it looks like a bug in cmake's
>>> FindThreads module.
>>  I am using CMake version 3.5.1
>>
>>> it should try with -lpthread and -pthread also.
>>
>> How can I change the CMakeList file to include -pthread instead of
>> -lpthreads? I have used Makefiles before, but I am not proficient in
>> CMakefiles.
>
>
> i checked http://paste.ubuntu.com/24175794/ and cmake 3.5.1, the cmake
> module did try "-lpthread" after it failed to link with "-lthreads".
> and "-lthread"
> worked fine.

sorry, should be "-lpthread".


>
> maybe you could pastebin "some errors" from cmake instead.
>
>>
>>>
>>>>
>>>> Cc'ing some people who have worked with CMakeLists.txt
>>>>
>>>> [1]: http://paste.ubuntu.com/24175792/
>>>> [2]: http://paste.ubuntu.com/24175794/
>>>>
>>>> --
>>>> Spandan Kumar Sahu
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>>
>>
>> --
>> Spandan Kumar Sahu
>> UG 2nd Year ( Dual Degree)
>> Computer Science and Engineering Department
>> IIT Kharagpur
>
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai
