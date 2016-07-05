From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Tue, 5 Jul 2016 21:09:32 +0200
Message-ID: <490b0db7-a342-88b6-832e-94f5dbf57b59@digiware.nl>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
 <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
 <alpine.DEB.2.11.1606281339570.8816@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:16167 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcGETKK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2016 15:10:10 -0400
In-Reply-To: <alpine.DEB.2.11.1606281339570.8816@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 28-6-2016 15:42, Sage Weil wrote:
> On Tue, 28 Jun 2016, Willem Jan Withagen wrote:
>> On 27-6-2016 19:50, Sage Weil wrote:
>>> We are switching from autotools to cmake on the master branch. Any 
>>> builds done post-jewel will be cmake and not autotools based.  Jewel and 
>>> older releases will still be built with autotools the old way.
>>>
>>> The README.md in the master branch has been updated with new developer 
>>> build instructions.  Please take a look:
>>>
>>> 	https://github.com/ceph/ceph/blob/master/README.md
>>>
>>> If you are doing development, please switch to using cmake (i.e., 
>>> run do_cmake.sh) now.  Running vstart.sh is a little different and it 
>>> takes some getting used to.
>>>
>>> If there is anything that doesn't work that is part of your developer 
>>> workflow, we need to fix it now, before the autotools support is removed 
>>> and you're unable to work!  This is hopefully a week or two away.
>>
>> Hi Sage,
>>
>> Although i appreciate and understand the desire to move to cmake.
>> Really ripping out the automake stuff would put me in the situation
>> where I have no more building environment until all the cmake tweaks for
>> FreeBSD are in place.
>>
>> An while I'll start working on it, time is rather scarce atm.
>> So please disable but please keep it around for a bit longer...
> 
> There is no particular need to remove any of the autotools stuff while 
> anyone still relies on it, so don't worry.  I'm just making sure 
> everyone starts using it now so that we can identify any gaps and 
> avoid surprises and fragmentation of efforts later.
> 
> Thanks for taking a look!

I'm at 8 fails of 132 tests.

Which is more or less what I have in my FreeBSD work. And I did not take
all FreeBSD-wip stuff to my cmake tree.

So I'm going to clean up, and then hopelully we can get tings in the tree.

--WjW
