From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Python 3 a blocking requirement?
Date: Wed, 24 Aug 2016 07:16:06 -0600
Message-ID: <CALqRxCxQdinA2HY_61Q7FujfUh9_o2Pystm9=LC-PvtHB5jJ9g@mail.gmail.com>
References: <2ef48fae-b971-3983-2488-c3181607dae3@digiware.nl>
 <9d76a1ec-52c8-b429-a11b-ad8af1bc6a65@redhat.com> <ed49edc5-633b-bd2a-0139-272695bd2d7a@digiware.nl>
 <c7814b3d-24dc-ced2-d435-b08d10f5f493@redhat.com> <77f467b7-7bcc-8267-8987-4cb4fb95260c@digiware.nl>
 <73da48c0-a358-0cb7-ff9b-3e787803b660@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34735 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754917AbcHXNQI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:16:08 -0400
Received: by mail-ua0-f176.google.com with SMTP id k90so27192736uak.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:16:07 -0700 (PDT)
In-Reply-To: <73da48c0-a358-0cb7-ff9b-3e787803b660@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Somewhat related to this discussion, I've opened
http://tracker.ceph.com/issues/17103 to track making Python 3
optional.

- Ken

On Wed, Aug 24, 2016 at 3:38 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 23-8-2016 10:03, Willem Jan Withagen wrote:
>> On 23-8-2016 00:57, Josh Durgin wrote:
>>> On 08/22/2016 03:41 PM, Willem Jan Withagen wrote:
>>>> On 23-8-2016 00:19, Josh Durgin wrote:
>>>>> On 08/22/2016 07:37 AM, Willem Jan Withagen wrote:
>>>>>> I was trying to do some tests on my Centos box.
>>>>>> And ran into:
>>>>>>
>>>>>> -- Found PythonLibs: /usr/lib64/libpython2.7.so (found suitable version
>>>>>> "2.7.5", minimum required is "2")
>>>>>> CMake Error at
>>>>>> /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:108
>>>>>> (message):
>>>>>>   Could NOT find Python3Interp: Found unsuitable version "2.7.5", but
>>>>>>   required is at least "3" (found /usr/bin/python)
>>>>>> Call Stack (most recent call first):
>>>>>>   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:313
>>>>>> (_FPHSA_FAILURE_MESSAGE)
>>>>>>   cmake/modules/FindPython3Interp.cmake:146
>>>>>> (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
>>>>>>   src/CMakeLists.txt:274 (find_package)
>>>>>>
>>>>>> Now is this due to me not being synced enough with master/HEAD, or is
>>>>>> this an actual problem?
>>>>>
>>>>> It's not a strict requirement - you could add some conditionals
>>>>> in src/pybind/CMakeLists.txt to disable it if you don't want to build
>>>>> python 3 versions of the python bindings.
>>>>>
>>>>> Alternatively you can grab python 3.4 for Centos 7 from EPEL.
>>>>
>>>> If it is not a strict requirement, than it would be nice if cmake would
>>>> accept thus....
>>>> And set something like HAVE_PYTHON3
>>>
>>> Yeah, if making it optional is desired that'd be the way to go.
>>>
>>>> Why not drop the REQUIRED from the find_package()?
>>>
>>> Until there is a HAVE_PYTHON3 it should fail early. This was just a
>>> first iteration of python 3 packages for ceph libraries, and since each
>>> platform we test has python 3, we didn't try to make it optional. I've
>>> no objections if you want to add that option.
>>
>> That is fair enough, I just found out the hard way because I do not run
>> make-deps every time.
>> And I have to maintain the deps list for FreeBSD manually atm.
>>
>> So the dependancies in the rpms has python3 as requirement, and that
>> gets python3 available before getting to Ceph?
>> If so I, I'll add them to the FreeBSD packages list. That'll move things
>> forward, instead of stasis.
>
> Tried this on FreeBSD and the Python detector is not as lenient.
> It refuses to find python3 stuff even though it is available as
> /usr/local/bin/puthon3 ....
>
> So the solution ATM is to
>  - delete the REQUIRED which will result in complaints (but no error)
>    that python3 is not found
>  - replace REQUIRED with QUIET.
>    And that generates no ouput but silently ignores any misses.
>
> For the time being I'd prefer the second one, as to not start people a
> goose chase to fix getting python3
>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
