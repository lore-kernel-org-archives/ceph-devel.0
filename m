From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: blueprint: ceph platform portability
Date: Sun, 28 Jul 2013 07:31:43 -0500
Message-ID: <51F50F2F.4040001@inktank.com>
References: <CA+Hcz5-WA8uKo9HjN48Z3tnT0RJBE2z8gKKtkEEFndKUb2iCTA@mail.gmail.com> <51F3E65A.7030508@ubuntukylin.com> <alpine.DEB.2.00.1307270833130.10870@cobra.newdream.net> <51F4C9C3.2090508@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:53293 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab3G1Mjd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Jul 2013 08:39:33 -0400
Received: by mail-yh0-f50.google.com with SMTP id a41so1689650yho.37
        for <ceph-devel@vger.kernel.org>; Sun, 28 Jul 2013 05:39:33 -0700 (PDT)
In-Reply-To: <51F4C9C3.2090508@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Sage Weil <sage@inktank.com>, Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/28/2013 02:35 AM, Li Wang wrote:
> Personally, I think it may be more important to improve portability of
> Ceph at the architecture level. For example, the coming ARM64 support,
> ARM has proven its name for its low power etc, it shoule be extremely
> suitable for running IO extensive application like Ceph.
>
> Does Inktank or any other party have plan on that? We would be very
> interesting in that, and pleasure to contribute.

Hi Li Wang,

We've partnered with a couple of companies including Calxeda and Penguin 
computing to enable ARM based Ceph clusters.  We have ARM7 support now 
in our official github repository for quantal:

http://gitbuilder.ceph.com/apache2-deb-quantal-arm7l-basic/

Beyond the basics, the more interesting work will be looking at how to 
improve IO performance and power consumption under heavy IO loads. 
Things like MD5 and CRC32c performance become much more important on 
low-power processors.  It looks like neon will be useful for at least 
some of it.

Mark

>
> On 07/27/2013 11:35 PM, Sage Weil wrote:
>> On Sat, 27 Jul 2013, Li Wang wrote:
>>> We did some work on Sparc machine, fixed some little endian/big
>>> endian as well
>>> as non-align access issues. We are using CentOS 6 recompiled version.
>>> We have
>>> managed to compile Ceph, however, it still could not work properly
>>> due to some
>>> aotmic function bug from some libs. We did not track it further
>>> recently.
>>>
>>> Any experiences on running Ceph on big endian machine to share?
>>
>> We built on a PPC machine a while back and used that to verify that the
>> big/little endian stuff was working.  We don't have any big endian
>> machines in our lab to let us verify this on an ongoing basis, however.
>> I'm not sure what the best options are to do that...  qemu?
>>
>> We'd love to see what endian issues you did hit, by the way, to make sure
>> they make into the tree!
>>
>> sage
>>
>>
>>>
>>> On 07/27/2013 07:07 AM, Noah Watkins wrote:
>>>> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Increasing_Ceph_portability
>>>>
>>>>
>>>> Recently I've managed to get Ceph built and running on OSX. There was
>>>> a past effort to get Ceph working on non-Linux platforms, most notably
>>>> FreeBSD, but that approach introduced a lot of ad-hoc macros that has
>>>> made it difficult to manage changes needed to support additional
>>>> platforms.
>>>>
>>>> This session would address the areas within Ceph that are currently
>>>> non-portable, discuss the state of OSX support, and touch on what is
>>>> needed to factor out platform specific functionality. Changes are
>>>> roughly grouped into (1) internal critical (e.g. locking) (2) internal
>>>> non-critical (some optimizations), and (2) exported headers. A
>>>> significant amount of the OSX changes have been introduced as feature
>>>> tests with generic alternatives, and as such the tree may already be
>>>> near building on additional platforms, so it would be great to find
>>>> people that would be willing to test on additional platforms.
>>>>
>>>> If you are interested please add yourself as an interested party or
>>>> owner of this blueprint :)
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

