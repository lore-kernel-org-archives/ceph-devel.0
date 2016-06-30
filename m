From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Thu, 30 Jun 2016 21:03:57 +0200
Message-ID: <32f03e6d-e1d1-3575-e153-733fe8c323e1@digiware.nl>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
 <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
 <alpine.DEB.2.11.1606281339570.8816@piezo.us.to>
 <2bf0a521-863a-b43c-328c-9c6c6a7c73ca@digiware.nl>
 <f859c212-83d3-98e8-50f0-40a5f7fd3afb@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30826 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbcF3TER (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jun 2016 15:04:17 -0400
In-Reply-To: <f859c212-83d3-98e8-50f0-40a5f7fd3afb@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 29-6-2016 18:51, Willem Jan Withagen wrote:
> On 28-6-2016 18:05, Willem Jan Withagen wrote:
>> On 28-6-2016 15:42, Sage Weil wrote:
>>> On Tue, 28 Jun 2016, Willem Jan Withagen wrote:
>>>> On 27-6-2016 19:50, Sage Weil wrote:
>>>>> We are switching from autotools to cmake on the master branch. Any 
>>>>> builds done post-jewel will be cmake and not autotools based.  Jewel and 
>>>>> older releases will still be built with autotools the old way.
>>>>>
>>>>> The README.md in the master branch has been updated with new developer 
>>>>> build instructions.  Please take a look:
>>>>>
>>>>> 	https://github.com/ceph/ceph/blob/master/README.md
>>>>>
>>>>> If you are doing development, please switch to using cmake (i.e., 
>>>>> run do_cmake.sh) now.  Running vstart.sh is a little different and it 
>>>>> takes some getting used to.
>>>>>
>>>>> If there is anything that doesn't work that is part of your developer 
>>>>> workflow, we need to fix it now, before the autotools support is removed 
>>>>> and you're unable to work!  This is hopefully a week or two away.
>>>>
>>>> Hi Sage,
>>>>
>>>> Although i appreciate and understand the desire to move to cmake.
>>>> Really ripping out the automake stuff would put me in the situation
>>>> where I have no more building environment until all the cmake tweaks for
>>>> FreeBSD are in place.
>>>>
>>>> An while I'll start working on it, time is rather scarce atm.
>>>> So please disable but please keep it around for a bit longer...
>>>
>>> There is no particular need to remove any of the autotools stuff while 
>>> anyone still relies on it, so don't worry.  I'm just making sure 
>>> everyone starts using it now so that we can identify any gaps and 
>>> avoid surprises and fragmentation of efforts later.
>>>
>>> Thanks for taking a look!
>>
>> Sort of feel like starting all over again, and hacking all FreeBSD
>> specials into the Make process.
>> But I've done that, so it does have steady progress.
> 
> First shot to be found in #10024
> 
> It does not compile all the way to the end. But I have a feeling that is
> because of new/extra code that has little to do with Cmake.
> 
> Gladly change any parts for better.
> 
> And yes, it is way much less hackish that automake stuff.
> I did not say easier, but the result should be a lot better to maintain.

Looks like I made building all the way to the end.
===
[100%] Building CXX object
src/test/system/CMakeFiles/ceph_test_rados_list_parallel.dir/rados_list_parallel.cc.o
[100%] Linking CXX executable ../../../bin/ceph_test_rados_list_parallel
c++: warning: argument unused during compilation:
'-Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=2'
[100%] Built target ceph_test_rados_list_parallel
210.372u 32.331s 4:03.17 99.8%  45172+574k 18431+324012io 4169pf+0w
[/usr/srcs/Ceph/work.cmake/ceph] wjw@freetest.digiware.nl>
===

Time to evaluate the amount of damage there is in the CmakeList.txt
files. 8D

--WjW




