From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Data-at-rest compression at EC pools blueprint
Date: Thu, 1 Oct 2015 15:43:06 +0300
Message-ID: <560D2A5A.3010908@mirantis.com>
References: <560C0356.90401@mirantis.com>
 <CAN=+7FUzyWRJ+PWbuJv1T2=uORFTPmr8_XRpMthAiy10oT+caQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35541 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbJAMnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 08:43:11 -0400
Received: by laer8 with SMTP id r8so73657288lae.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Oct 2015 05:43:09 -0700 (PDT)
In-Reply-To: <CAN=+7FUzyWRJ+PWbuJv1T2=uORFTPmr8_XRpMthAiy10oT+caQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Samuel,
thanks a lot for prompt feedback.

On 30.09.2015 21:40, Samuel Just wrote:
> Seems like a reasonable start.  Quick back-of-the-envelope calculation
> suggests 2k of (logical_offset, compressed_offset) pairs per 1MB of
> data with 8MB/pair and 4k chunks, which is probably ok to stuff into
> an xattr.  You should restructure the blueprint to make it independent
> of EC.  ReplicatedPG can do this before feeding the writes to the
> backend (whichever backend is used) --
I probably understand your concerns about having code unrelated to 
Erasure Coding at EC pool level. But there is a couple of issues with 
such a split:
1) Direct EC pool users are unable to benefit from compression. Sage 
mentioned the need for that during our previous discussion.
2)  Users are unable to access "compressed" data if cache tier has gone 
or they intentionally bypass it. E.g. this might be caused by cache tier 
removal/disablement. Despite that's probably an artificial use case but 
it's  easily reproducible in current Ceph deployments.

Given that I'd prefer to start considering EC pools as "low-cost 
backing" pools with more or less equal space saving features 
(compression and EC) rather than Erasure Code stuff with embedded 
compression... Surely this is rather word/conception juggling....

Anyway I'm open to other suggestions how one can overcome mentioned 
drawbacks.

> the pool alignment parameter
> could be set on a replicated pool to enforce aligned appends on a
> compressed replicated pool.
IMO replicated pool ( I thinks that's rather cache tier agent) already 
performs aligned appends to backing storage.

Thanks,
Igor.
> -Sam
>
> On Wed, Sep 30, 2015 at 8:44 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> Folks,
>>
>> I've just added a blueprint about adding compression to EC pools as per our
>> previous discussion.
>> Please find it at
>> http://tracker.ceph.com/projects/ceph/wiki/Submissions
>>
>> Not sure I did that in proper manner - by attaching a new file. Other
>> blueprints look different at this page. Can't undo though.
>> Sorry about that.
>>
>> And please point out different way to publish my blueprint if needed.
>>
>> Any way - comments and reviews on the content are welcome.
>>
>> Thanks.,
>> Igor.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

