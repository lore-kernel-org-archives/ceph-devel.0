From: kefu chai <tchaikov@gmail.com>
Subject: Re: Can't compile because of -lpthreads
Date: Wed, 15 Mar 2017 00:57:38 +0800
Message-ID: <CAJE9aONRJKuDKTHc4BrOorahnG6WtCox_vOuaVOFG0d5X8tWuw@mail.gmail.com>
References: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
 <CAJE9aOMdgg=Y97PKPQGdxrMN1BShdVLS_QdZZA_1xx+yKgLKEg@mail.gmail.com>
 <CAAXqJ+qmmZTbDi-ipF_AThYO6bMvFxHjo4OZMxweW21fA0Gkyg@mail.gmail.com>
 <CAJE9aOMBGNs7F9hEyii55=XSs0rMPAdDAj7rjg_0iRnZtkiMjA@mail.gmail.com> <CAAXqJ+pUpdvEZQKn2eVKo-p-dxaASL9Q1Q-PpsV=n2unW-AV1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34653 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbdCNQ5k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 12:57:40 -0400
Received: by mail-vk0-f66.google.com with SMTP id r136so7652634vke.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 09:57:39 -0700 (PDT)
In-Reply-To: <CAAXqJ+pUpdvEZQKn2eVKo-p-dxaASL9Q1Q-PpsV=n2unW-AV1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel, please keep the mailing list in the loop. thanks.

On Tue, Mar 14, 2017 at 10:30 PM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> I checked I was not on the latest CMake. So, I purged CMake that I was
> using, and installed the latest version 3.8.0
>
> Now I followed the same steps from beginning.
>
> This[1] was the CMakeError.log, that I initially had.
>
> After purging and reinstalling CMake, this[2] is the CMakeError.log, and
> this[3] is the output I get on the terminal, when I run `./do_cmake.sh`.
>
> [1]:http://paste.ubuntu.com/24175792/
> [2]:http://paste.ubuntu.com/24176815/
> [3]:http://paste.ubuntu.com/24176834/


error: wrong library name 'coroutine' in the --with-<library> option.
error: wrong library name 'coroutine' in the --with-<library> option.
CMake Warning at
/usr/local/share/cmake-3.8/Modules/FindBoost.cmake:761 (message):
  Imported targets not available for Boost version
Call Stack (most recent call first):
  /usr/local/share/cmake-3.8/Modules/FindBoost.cmake:865
(_Boost_COMPONENT_DEPENDENCIES)
  /usr/local/share/cmake-3.8/Modules/FindBoost.cmake:1456
(_Boost_MISSING_DEPENDENCIES)
  CMakeLists.txt:577 (find_package)

this is the error that fails the cmake.

could you run

./bootstrap.sh --show-libraries

under src/boost, to see if coroutine is available? and make sure your
boost's submodules are synced.

>
>
> On Tue, Mar 14, 2017 at 6:43 PM, kefu chai <tchaikov@gmail.com> wrote:
>>
>> On Tue, Mar 14, 2017 at 8:57 PM, Spandan Kumar Sahu
>> <spandankumarsahu@gmail.com> wrote:
>> > On Tue, Mar 14, 2017 at 6:23 PM, kefu chai <tchaikov@gmail.com> wrote:
>> >> On Tue, Mar 14, 2017 at 6:33 PM, Spandan Kumar Sahu
>> >> <spandankumarsahu@gmail.com> wrote:
>> >>> Hey everyone,
>> >>>
>> >>> I am interested in contributing to Ceph and thus I tried to build the
>> >>> source code but unfortunately it has some errors. I will list out the
>> >>> steps I did:
>> >>>
>> >>>  * Clone the ceph/ceph.git repo from github on my local machine
>> >>>  * `./install_deps.sh`
>> >>>  * `./do_cmake.sh`
>> >>>
>> >>> Now the last command shows some errors. This[1] is the output of
>> >>> CMakeError.log file
>> >>>  while this[2]. I am using Ubuntu 16.04 LTS.
>> >>>
>> >>> The particular problem is that my system can't recognise `-lpthreads`
>> >>> but it recognises `-pthread` and `-lpthread`. I had tried a lot to
>> >>> search this on the internet and also tried out all the stuff described
>> >>> in the stackoverflow results but all in vain. I am familiar with
>> >>> Makefiles but not so familiar with CMake files and thus couldn't
>> >>> really find a solution. I would be really glad if someone could help!
>> >>
>> >> what cmake version are you using? it looks like a bug in cmake's
>> >> FindThreads module.
>> >  I am using CMake version 3.5.1
>> >
>> >> it should try with -lpthread and -pthread also.
>> >
>> > How can I change the CMakeList file to include -pthread instead of
>> > -lpthreads? I have used Makefiles before, but I am not proficient in
>> > CMakefiles.
>>
>>
>> i checked http://paste.ubuntu.com/24175794/ and cmake 3.5.1, the cmake
>> module did try "-lpthread" after it failed to link with "-lthreads".
>> and "-lthread"
>> worked fine.
>>
>> maybe you could pastebin "some errors" from cmake instead.
>>
>> >
>> >>
>> >>>
>> >>> Cc'ing some people who have worked with CMakeLists.txt
>> >>>
>> >>> [1]: http://paste.ubuntu.com/24175792/
>> >>> [2]: http://paste.ubuntu.com/24175794/
>> >>>
>> >>> --
>> >>> Spandan Kumar Sahu
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >>> in
>> >>> the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> >>
>> >> --
>> >> Regards
>> >> Kefu Chai
>> >
>> >
>> >
>> > --
>> > Spandan Kumar Sahu
>> > UG 2nd Year ( Dual Degree)
>> > Computer Science and Engineering Department
>> > IIT Kharagpur
>>
>>
>>
>> --
>> Regards
>> Kefu Chai
>
>
>
>
> --
> Spandan Kumar Sahu
> IIT Kharagpur



-- 
Regards
Kefu Chai
