From: Alex Elder <alex.elder@linaro.org>
Subject: Re: krbd + format=2 ?
Date: Sat, 15 Jun 2013 12:01:32 -0500
Message-ID: <51BC9DEC.2050906@linaro.org>
References: <20130603092428.GB28293@onthe.net.au> <51B2103C.7040402@inktank.com> <20130608024852.GA31065@onthe.net.au> <20130612045949.GA13654@onthe.net.au> <51B94302.1010104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53713 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab3FORB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jun 2013 13:01:29 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so3873341iea.11
        for <ceph-devel@vger.kernel.org>; Sat, 15 Jun 2013 10:01:29 -0700 (PDT)
In-Reply-To: <51B94302.1010104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On 06/12/2013 10:56 PM, Josh Durgin wrote:
> On 06/11/2013 09:59 PM, Chris Dunlop wrote:
>> On Sat, Jun 08, 2013 at 12:48:52PM +1000, Chris Dunlop wrote:
>>> On Fri, Jun 07, 2013 at 11:54:20AM -0500, Alex Elder wrote:
>>>> On 06/03/2013 04:24 AM, Chris Dunlop wrote:
>>>>> I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, and
>>>>> it's
>>>>> letting me map a format=2 image (created under bobtail), however
>>>>> reading
>>>>> from the block device returns zeros rather than the data. The same
>>>>> image
>>>>> correctly shows data (NTFS filesystem) when mounted into kvm using
>>>>> librbd.
>>>>
>>>> Have you tried using a format 2 image that you created using
>>>> the Linux rbd environment?  It would be good to know whether
>>>> that works for you.
>>>
>>> Sorry, how to you mean "created using the Linux rbd environment"?
>>> The one I was trying was created using:
>>>
>>> rbd create --format 2 xxx --size nnnnn
>>>
>>> ...then populated using qemu/librbd.
>>
>> Looks like the kernel rbd and librbd aren't compatible, as at
>> 3.10.0-rc4+ceph-client/for-linus@3abef3b vs librbd1 0.56.6-1~bpo70+1.
> 
> Thanks for the detailed report Chris. The kernel client was using the
> wrong object names for format 2 (zero-padding them with a different
> length than librbd). I just posted a patch fixing this.

I remember talking about this Josh.  I had suggested we
use a longer one so the full range of values would be
represented by the default name, and as I recall you said
it had already been done on the user space side.  I'm
sorry if no bug got opened to be sure that got resolved...

					-Alex

> Josh
> 

