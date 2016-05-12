From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: 2 related bluestore questions
Date: Thu, 12 May 2016 17:27:12 +0300
Message-ID: <fd43404b-907c-a84f-a353-74d0a66c2aa1@mirantis.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
 <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com>
 <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com>
 <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com>
 <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com>
 <2b5ebbd8-3e89-1fff-37f1-c6eb00bdcb1a@mirantis.com>
 <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com>
 <8b077a20-ace3-7824-4039-7b8e9adf88ce@mirantis.com>
 <alpine.DEB.2.11.1605110951570.15518@cpach.fuggernut.com>
 <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33353 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbcELO1R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 10:27:17 -0400
Received: by mail-lb0-f172.google.com with SMTP id jj5so11807447lbc.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 07:27:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: allen.samuels@sandisk.com, ceph-devel@vger.kernel.org



On 11.05.2016 23:54, Sage Weil wrote:
> On Wed, 11 May 2016, Sage Weil wrote:
>> On Wed, 11 May 2016, Igor Fedotov wrote:
>>
>> I like that way better!  We can just add a force_sync argument to
>> _do_write.  That also lets us trivially disable wal (by forcing sync w/
>> a config option or whatever).
>>
>> The downside is that any logically conflicting request (an overlapping
>> write or truncate or zero) needs to drain the wal events, whereas with a
>> lower-level wal description there might be cases where we can ignore the
>> wal operation.  I suspect the trivial solution of o->flush() on
>> write/truncate/zero will be pretty visible in benchmarks.  Tracking
>> in-flight wal ops with an interval_set would probably work well enough.
> Hmm, I'm not sure this will pan out.  The main problem is that if we call
> back into the write code (with a sync flag), we will have to do write
> IO, and this wreaks havoc on our otherwise (mostly) orderly state machine.
> I think it can be done if we build in a similar guard like _txc_finish_io
> so that we wait for the wal events to also complete IO in order before
> committing them.  I think.
>
> But the other problem is the checksum thing that came up in another
> thread, where the read-side of a read/modify/write might fail teh checksum
> because the wal write hit disk but the kv portion didn't commit. I see a
> few options:
>
>   1) If there are checksums and we're doing a sub-block overwrite, we
> have to write/cow it elsewhere.  This probably means min_alloc_size cow
> operations for small writes.  In which case we needn't bother doing a wal
> even in the first place--the whole point is to enable an overwrite.
>
>   2) We do loose checksum validation that will accept either the old
> checksum or the expected new checksum for the read stage.  This handles
> these two crash cases:
Probably I missed something but It seems to me that we don't have any 
'expected new checksum' for the whole new block after the crash.
What we can have are old block checksum in KV and checksum for 
overwritten portion of the block in WAL. To have full new checksum one 
has to do the read and store new checksum to KV afterwards.
Or you mean write+KV update under 'do  wal io'?
>   * kv commit of op + wal event
>     <crash here, or>
>   * do wal io (completely)
>     <crash before cleaning up wal event>
>   * kv cleanup of wal event
>
> but not the case where we only partially complete the wal io.  Which means
> there is a small probability is "corrupt" ourselves on crash (not really
> corrupt, but confuse ourselves such that we refuse to replay the
> wal events on startup).
>
>   3) Same as 2, but simply warn if we fail that read-side checksum on
> replay.  This basically introduces a *very* small window which could allow
> an ondisk corruption to get absorbed into our checksum.  This could just
> be #2 + a config option so we warn instead of erroring out.
>
>   4) Same as 2, but we try every combination of old and new data on
> block/sector boundaries to find a valid checksum on the read-side.
Still unclear for me where can we get old data from when we've just 
overwritten them?
E.g. old block  was
<1,2,3> and the new one <4> with the resulting one = <4,2,3>
We have checksums for <1,2,3> and for <4> in KV. And <4,2,3> block at 
the disk. How one can detect an error in an invalud <4,5,3> block unless 
we store checksum for <4,2,3> before the write?

>
> I think #1 is a non-starter because it turns a 4K write into a 64K read +
> seek + 64K write on an HDD.  Or forces us to run with min_alloc_size=4K on
> HDD, which would risk very bad fragmentation.
>
> Which makes we want #3 (initially) and then #4.  But... if we do the "wal
> is just a logical write", that means this weird replay handling logic
> creeps into the normal write path.
>
> I'm currently leaning toward keeping the wal events special (lower-level),
> but doing what we can to make it work with the same mid- to low-level
> helper functions (for reading and verifying blobs, etc.).
>
> sage

