From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Python 3 a blocking requirement?
Date: Mon, 22 Aug 2016 15:57:00 -0700
Message-ID: <c7814b3d-24dc-ced2-d435-b08d10f5f493@redhat.com>
References: <2ef48fae-b971-3983-2488-c3181607dae3@digiware.nl>
 <9d76a1ec-52c8-b429-a11b-ad8af1bc6a65@redhat.com>
 <ed49edc5-633b-bd2a-0139-272695bd2d7a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756487AbcHVW5B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 18:57:01 -0400
In-Reply-To: <ed49edc5-633b-bd2a-0139-272695bd2d7a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 08/22/2016 03:41 PM, Willem Jan Withagen wrote:
> On 23-8-2016 00:19, Josh Durgin wrote:
>> On 08/22/2016 07:37 AM, Willem Jan Withagen wrote:
>>> I was trying to do some tests on my Centos box.
>>> And ran into:
>>>
>>> -- Found PythonLibs: /usr/lib64/libpython2.7.so (found suitable version
>>> "2.7.5", minimum required is "2")
>>> CMake Error at
>>> /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:108
>>> (message):
>>>   Could NOT find Python3Interp: Found unsuitable version "2.7.5", but
>>>   required is at least "3" (found /usr/bin/python)
>>> Call Stack (most recent call first):
>>>   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:313
>>> (_FPHSA_FAILURE_MESSAGE)
>>>   cmake/modules/FindPython3Interp.cmake:146
>>> (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
>>>   src/CMakeLists.txt:274 (find_package)
>>>
>>> Now is this due to me not being synced enough with master/HEAD, or is
>>> this an actual problem?
>>
>> It's not a strict requirement - you could add some conditionals
>> in src/pybind/CMakeLists.txt to disable it if you don't want to build
>> python 3 versions of the python bindings.
>>
>> Alternatively you can grab python 3.4 for Centos 7 from EPEL.
>
> If it is not a strict requirement, than it would be nice if cmake would
> accept thus....
> And set something like HAVE_PYTHON3

Yeah, if making it optional is desired that'd be the way to go.

> Why not drop the REQUIRED from the find_package()?

Until there is a HAVE_PYTHON3 it should fail early. This was just a
first iteration of python 3 packages for ceph libraries, and since each
platform we test has python 3, we didn't try to make it optional. I've
no objections if you want to add that option.

Josh
