From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Fri, 7 Apr 2017 08:46:20 +0200
Message-ID: <0a855b7e-8c04-5742-ad89-32304b88dc75@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
 <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
 <alpine.DEB.2.11.1704061353070.2999@piezo.novalocal>
 <b7d71b5e-ebd6-23c1-962c-59375038ce5b@corp.ovh.com>
 <alpine.DEB.2.11.1704061426480.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 8.mo302.mail-out.ovh.net ([137.74.110.81]:36545 "EHLO
        8.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdDGGqY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Apr 2017 02:46:24 -0400
In-Reply-To: <alpine.DEB.2.11.1704061426480.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/06/2017 04:27 PM, Sage Weil wrote:
> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> On 04/06/2017 03:55 PM, Sage Weil wrote:
>>> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>>>> On 04/06/2017 03:25 PM, Sage Weil wrote:
>>>>> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>>>>>> [..]
>>>>>
>>>>> I think the solution here is to use sparse_read during recovery.  The
>>>>> PushOp data representation already supports it; it's just a matter of
>>>>> skipping the zeros.  The recovery code could also have an option to
>>>>> check
>>>>> for fully-zero regions of the data and turn those into holes as well.
>>>>> For
>>>>> ReplicatedBackend, see build_push_op().
>>>>
>>>> Can we abuse that to reduce amount of regular (client/inter-osd) network
>>>> traffic?
>>>
>>> Yeah... I wouldn't call it abuse :).  sparse_read() will use
>>> SEEK_HOLE/SEEK_DATA on filestore (if enabled).  On bluestore we have the
>>> metadata on-hand.  It may be a bit slower, though... more complexity
>>> and such.  They recently implemented something like this for the kernel
>>> NFS server and found it was faster for very sparse files but the rest of
>>> the time it was a fair bit slower.
>>
>> I was wondering if we could modify regular reads in a way that makes them work
>> as it used to work, but not transmit zeroed out pages/blocks/objects (in other
>> words, you still would get bufferptrs full of zeroes, but they wouldn't be
>> transmitted as such over the wire; specialized case of RLE compression). That
>> shouldn't be so much slower. But I don't really see how that would work
>> without protocol change... Well, at least it's possible to replace some of
>> calls to read with sparse read, utilizing filesystem/file store metadata to do
>> heavy lifting for us.
>
> IIRC librbd used to have an option to do sparse-read all the time instead
> of read (I think this was in ObjectCacher somewhere?) but I think it got
> turned off for some reason?  Memory is very fuzzy here.  In any case,
> changing the client to use sparse-read is the way to do it, I think.
> I'm a bit skeptical that this will have much of an impact, though.

I don't expect it to be a big win either, having even a simple RLE 
compressor would be more useful (and in particular, make "rados bench" 
useless), but if sparse reads are also less bandwidth-intensive, it could be 
meaningful for many large cluster operators and also easier to implement 
without breaking too much.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
