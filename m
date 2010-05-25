From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 09:05:55 -0500
Message-ID: <4BFBD943.8020704@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD13C.60605@redhat.com> <4BFBD20E.5060207@codemonkey.ws> <4BFBD2D5.2000201@redhat.com> <4BFBD6CD.3000503@codemonkey.ws> <4BFBD82F.3020404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42208 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab0EYOGA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 10:06:00 -0400
In-Reply-To: <4BFBD82F.3020404@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 09:01 AM, Avi Kivity wrote:
> On 05/25/2010 04:55 PM, Anthony Liguori wrote:
>> On 05/25/2010 08:38 AM, Avi Kivity wrote:
>>> On 05/25/2010 04:35 PM, Anthony Liguori wrote:
>>>> On 05/25/2010 08:31 AM, Avi Kivity wrote:
>>>>>> A protocol based mechanism has the advantage of being more robust 
>>>>>> in the face of poorly written block backends so if it's possible 
>>>>>> to make it perform as well as a plugin, it's a preferable approach.
>>>>>
>>>>> May be hard due to difficulty of exposing guest memory.
>>>>
>>>> If someone did a series to add plugins, I would expect a very 
>>>> strong argument as to why a shared memory mechanism was not 
>>>> possible or at least plausible.
>>>>
>>>> I'm not sure I understand why shared memory is such a bad thing wrt 
>>>> KVM.  Can you elaborate?  Is it simply a matter of fork()?
>>>
>>> fork() doesn't work in the with of memory hotplug.  What else is there?
>>>
>>
>> Is it that fork() doesn't work or is it that fork() is very expensive?
>
> It doesn't work, fork() is done at block device creation time, which 
> freezes the child memory map, while guest memory is allocated at 
> hotplug time.

Now I'm confused.  I thought you were saying shared memory somehow 
affects fork().  If you're talking about shared memory inheritance via 
fork(), that's less important.  You can also pass /dev/shm fd's via 
SCM_RIGHTs to establish shared memory segments dynamically.

Regards,

Anthony Liguori

> fork() actually isn't very expensive since we use MADV_DONTFORK 
> (probably fast enough for everything except realtime).
>
> It may be possible to do a processfd() which can be mmap()ed by 
> another process to export anonymous memory using mmu notifiers, not 
> sure how easy or mergeable that is.
>

