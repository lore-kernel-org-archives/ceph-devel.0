From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Python 3 a blocking requirement?
Date: Tue, 23 Aug 2016 00:41:58 +0200
Message-ID: <ed49edc5-633b-bd2a-0139-272695bd2d7a@digiware.nl>
References: <2ef48fae-b971-3983-2488-c3181607dae3@digiware.nl>
 <9d76a1ec-52c8-b429-a11b-ad8af1bc6a65@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25763 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbcHVWmC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 18:42:02 -0400
In-Reply-To: <9d76a1ec-52c8-b429-a11b-ad8af1bc6a65@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23-8-2016 00:19, Josh Durgin wrote:
> On 08/22/2016 07:37 AM, Willem Jan Withagen wrote:
>> I was trying to do some tests on my Centos box.
>> And ran into:
>>
>> -- Found PythonLibs: /usr/lib64/libpython2.7.so (found suitable version
>> "2.7.5", minimum required is "2")
>> CMake Error at
>> /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:108
>> (message):
>>   Could NOT find Python3Interp: Found unsuitable version "2.7.5", but
>>   required is at least "3" (found /usr/bin/python)
>> Call Stack (most recent call first):
>>   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:313
>> (_FPHSA_FAILURE_MESSAGE)
>>   cmake/modules/FindPython3Interp.cmake:146
>> (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
>>   src/CMakeLists.txt:274 (find_package)
>>
>> Now is this due to me not being synced enough with master/HEAD, or is
>> this an actual problem?
> 
> It's not a strict requirement - you could add some conditionals
> in src/pybind/CMakeLists.txt to disable it if you don't want to build
> python 3 versions of the python bindings.
> 
> Alternatively you can grab python 3.4 for Centos 7 from EPEL.

If it is not a strict requirement, than it would be nice if cmake would
accept thus....
And set something like HAVE_PYTHON3

Why not drop the REQUIRED from the find_package()?

--WjW

