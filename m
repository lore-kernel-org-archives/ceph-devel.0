From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: blueprint: ceph platform portability
Date: Sun, 28 Jul 2013 15:35:31 +0800
Message-ID: <51F4C9C3.2090508@ubuntukylin.com>
References: <CA+Hcz5-WA8uKo9HjN48Z3tnT0RJBE2z8gKKtkEEFndKUb2iCTA@mail.gmail.com> <51F3E65A.7030508@ubuntukylin.com> <alpine.DEB.2.00.1307270833130.10870@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:56232 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab3G1Hfl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Jul 2013 03:35:41 -0400
In-Reply-To: <alpine.DEB.2.00.1307270833130.10870@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Personally, I think it may be more important to improve portability of 
Ceph at the architecture level. For example, the coming ARM64 support,
ARM has proven its name for its low power etc, it shoule be extremely 
suitable for running IO extensive application like Ceph.

Does Inktank or any other party have plan on that? We would be very 
interesting in that, and pleasure to contribute.

On 07/27/2013 11:35 PM, Sage Weil wrote:
> On Sat, 27 Jul 2013, Li Wang wrote:
>> We did some work on Sparc machine, fixed some little endian/big endian as well
>> as non-align access issues. We are using CentOS 6 recompiled version. We have
>> managed to compile Ceph, however, it still could not work properly due to some
>> aotmic function bug from some libs. We did not track it further recently.
>>
>> Any experiences on running Ceph on big endian machine to share?
>
> We built on a PPC machine a while back and used that to verify that the
> big/little endian stuff was working.  We don't have any big endian
> machines in our lab to let us verify this on an ongoing basis, however.
> I'm not sure what the best options are to do that...  qemu?
>
> We'd love to see what endian issues you did hit, by the way, to make sure
> they make into the tree!
>
> sage
>
>
>>
>> On 07/27/2013 07:07 AM, Noah Watkins wrote:
>>> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Increasing_Ceph_portability
>>>
>>> Recently I've managed to get Ceph built and running on OSX. There was
>>> a past effort to get Ceph working on non-Linux platforms, most notably
>>> FreeBSD, but that approach introduced a lot of ad-hoc macros that has
>>> made it difficult to manage changes needed to support additional
>>> platforms.
>>>
>>> This session would address the areas within Ceph that are currently
>>> non-portable, discuss the state of OSX support, and touch on what is
>>> needed to factor out platform specific functionality. Changes are
>>> roughly grouped into (1) internal critical (e.g. locking) (2) internal
>>> non-critical (some optimizations), and (2) exported headers. A
>>> significant amount of the OSX changes have been introduced as feature
>>> tests with generic alternatives, and as such the tree may already be
>>> near building on additional platforms, so it would be great to find
>>> people that would be willing to test on additional platforms.
>>>
>>> If you are interested please add yourself as an interested party or
>>> owner of this blueprint :)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
