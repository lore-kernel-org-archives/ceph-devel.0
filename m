From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Python 3 plans
Date: Sun, 4 Sep 2016 02:26:19 +0200
Message-ID: <a5749110-8fc4-3996-071f-7682008ac710@digiware.nl>
References: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
 <2bf23853-de9e-5a98-2db1-fe17e9999548@redhat.com>
 <dbcef1f1-82a7-3d8e-ddb1-7d204b1f58cc@digiware.nl>
 <a91096da-7dd0-5347-ac11-13c75ec57c06@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30990 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcIDA0e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 3 Sep 2016 20:26:34 -0400
In-Reply-To: <a91096da-7dd0-5347-ac11-13c75ec57c06@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2-9-2016 11:56, Willem Jan Withagen wrote:
> On 31-8-2016 22:04, Willem Jan Withagen wrote:
>> On 31-8-2016 21:01, Josh Durgin wrote:
>>> On 08/31/2016 07:09 AM, John Spray wrote:
>>>> Hi all,
>>>>
>>>> Various people have been helpfully fixing up the python modules for
>>>> python 3 -- but I realised I wasn't sure what our plan really was or
>>>> who was depending on this.
>>
>> This is on FreeBSD.
>>
>> I have not yet figured out why, but even though {python/cython}3 is not
>> installed, I'm getting Cmake to report that it found cytron3.
>> And then things start to fail during building.
> 
> I have submitted PR #10960 to make python3 stuff fail quietly, meaning
> that if it is not available Cmake will not start moaning.
> It still reports that it is using cyton3, but that seems annoying but
> harmless.
> 
> Perhaps you care to merge this PR?

Even Jenkins trips over this once in a while....
https://jenkins.ceph.com/job/ceph-pull-requests/11104/console

CMake Error at
/usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:108 (message):
  Could NOT find Python3Interp: Found unsuitable version "2.7.5", but
  required is at least "3" (found /usr/bin/python)
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:313
(_FPHSA_FAILURE_MESSAGE)
  cmake/modules/FindPython3Interp.cmake:146
(FIND_PACKAGE_HANDLE_STANDARD_ARGS)
  src/CMakeLists.txt:203 (find_package)


--WjW

