From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 14:56:27 -0400
Message-ID: <CACkq2mpFVXzSHn6KKRg4biuGz48-da8G4N+t7TD5K_G__xj26Q@mail.gmail.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
 <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
 <505311CD02000099000EA409@collaborate.seakr.com> <50537C21.2060001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40618 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab2INS4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 14:56:48 -0400
Received: by qcro28 with SMTP id o28so3035027qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 11:56:47 -0700 (PDT)
In-Reply-To: <50537C21.2060001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Nick Couchman <Nick.Couchman@seakr.com>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

Mark,

That's pretty definitive!  Thanks for doing that test so quickly, and
the link to the mailing list discussions.  Sounds like -o allocsize
isn't really useful these days.  I guess those are the consequences of
looking at slightly older blog posts about performance tuning (on my
part)...

 - Travis

On Fri, Sep 14, 2012 at 2:49 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 09/14/2012 12:15 PM, Nick Couchman wrote:
>>>
>>>
>>>> While I'm talking about XFS...  I know that RBD's use a default object
>>>> size of 4MB.  I've stuck with that so far..  Would it be beneficial to
>>>> mount XFS with -o allocsize=4M ?  What is the object size that gets
>>>> used for non-RBD cases -- i.e. just dumping objects into data pool?
>>>
>>>
>>> Don't know about -o allocsize -- benchmark it!
>>
>>
>> ...and let us know what you come up with!  I'm also using XFS for the
>> underlying filesystem on which CEPH runs (and using RBD), and would be
>> really interested to know if changing the alloc size improves performance!
>>
>> -Nick
>
>
> Hi Guys,
>
> There was a change 2.6.38 to the way that speculative preallocation works
> that basically lets small writes behave like allocsize is not set, and large
> writes behave like a large one is set:
>
> http://permalink.gmane.org/gmane.comp.file-systems.xfs.general/38403
>
> Having said that, I had my test gear all ready to go so I decided to give it
> a try:
>
> Setup:
>
> - 1 node
> - 6 OSDs with 7200rpm data disks.
> - Journals on 2 Intel 520 SSDs (3 per SSD)
> - LSI SAS2008 Controller (9211-8i)
> - Network: Localhost
> - Ceph 0.50
> - Ubuntu 12.04
> - Kernel 3.4
> - XFS mkfs options: -f -i size=2048
> - Common XFS mount options: -o noatime
> - No replication
> - 8 concurrent rados bench instances.
> - 32 concurrent 4MB ops per instance (256 concurrent ops total)
>
> Without allocsize=4M:
>
> 781.454MB/s
>
> With allocsize=4M:
>
> 453.335MB/s
>
> I'm guessing that it's perhaps slower as we've told XFS to optimize for
> large files, but the metadata in /meta is very small, and we were already
> getting benefits from the new speculative preallocation patches that were
> introduced in 2.6.38 to combat fragmentation of the 4MB objects.
>
> Mark
>>
>>
>>
>>
>>
>> --------
>> This e-mail may contain confidential and privileged material for the sole
>> use of the intended recipient.  If this email is not intended for you, or
>> you are not responsible for the delivery of this message to the intended
>> recipient, please note that this message may contain SEAKR Engineering
>> (SEAKR) Privileged/Proprietary Information.  In such a case, you are
>> strictly prohibited from downloading, photocopying, distributing or
>> otherwise using this message, its contents or attachments in any way.  If
>> you have received this message in error, please notify us immediately by
>> replying to this e-mail and delete the message from your mailbox.
>> Information contained in this message that does not relate to the business
>> of SEAKR is neither endorsed by nor attributable to SEAKR.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
