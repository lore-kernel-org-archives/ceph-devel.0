From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Tue, 7 Jun 2016 21:13:27 +0800
Message-ID: <CAJE9aOPp2m38Rr7DjccHSzOVSwGipp4Hr4wVdnVpg-Utq01=hg@mail.gmail.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
 <CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
 <CAJE9aOMDLyfOVn-n18m3Ftqc3G=N-71we9qiUuhBSX+qnJBF9Q@mail.gmail.com>
 <CAN=+7FVsVFW_omt2P6HgNsCGtOh25mnOpnqCRfctY+wRrWvyrw@mail.gmail.com>
 <CAJE9aONjDEt3vUAEYJc_oBwcv8LUy-iWA0mMtY3-EvkyrFBXCg@mail.gmail.com> <CAN=+7FVA-H1oxpS7p-sZVQobPmJwoiV0hUO8ugNTB-2M-OiSwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33312 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcFGNN3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 09:13:29 -0400
Received: by mail-yw0-f179.google.com with SMTP id h19so169098495ywc.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 06:13:29 -0700 (PDT)
In-Reply-To: <CAN=+7FVA-H1oxpS7p-sZVQobPmJwoiV0hUO8ugNTB-2M-OiSwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 26, 2016 at 1:37 AM, Samuel Just <sjust@redhat.com> wrote:
> On Fri, May 20, 2016 at 4:30 AM, kefu chai <tchaikov@gmail.com> wrote:
>> On Fri, May 20, 2016 at 1:55 AM, Samuel Just <sjust@redhat.com> wrote:
>>> How would this work for an ec pool?  Maybe the osd argument should be
>>> a set of valid peers?
>>
>> maybe in the case of ec pool, we should ignore the osd argument.
>>
>> <quote from="http://pad.ceph.com/p/scrub_repair">
>> david points out that for EC pools, don't allow incorrect shards to be
>> selected as correct
>> - admin might decide to delete an object if it can't exist
>> - similar to unfound object case
>> - repair should have a use-your-best-judgement flag -- mandatory for
>> ec (if not deleting the object)
>> - for ec, if we want to read a shard, need to specify the shard id as
>> well since an osd might have two shards
>>   - request would indicate the shard
>> </quote>
>>
>> because the ec subread does not return the payload if the size or the
>> digest fails to match, and instead, an EIO is returned. on the primary
>> side, ECBackend::handle_sub_read_reply() will send more subread ops to
>> the shard(s) which is yet used if it is unable to reconstruct the
>> requested extent with shards already returned. if we want to
>> explicitly exclude the "bad" shards from being used, maybe the
>> simplest way is to remove it before calling repair-copy. and we can
>> offer an API for removing a shard. but I doubt that we need to do
>> this. as the chance of having a corrupted shard whose checksum matches
>> with its digest stored in its object-info xattr,  is very small. and
>> maybe we fix a corrupted shard in ec pool by reading the impacted
>> object, and then overwriting the original copy with the reconstructed
>> one from the good shards.
>
> I think it would be simpler to just allow the repair_write call to
> specify a set of bad shards.  For replicated pools, we simply choose
> one which is not in that set.  For EC pools, we use that information
> to avoid bad shards.

for the replicated pool, will choose a random replica from the acting set
as long as it's not listed in the black list as the authenticated copy of the
repair.

for the ec pool, the OSD does not return shards with wrong digest at all
when handling sub read requests. so we should ignore the digest mismatch
error when reading shards. because:
 - we mark a shard inconsistent if its digest does not match with the
one stored in the shard's hash_info. (please note that each shard has
the digests of all shards of that object).
 - the user could put the consistent shard reported by
list-inconsistent-obj into the blacklist. it's a little bit scary
though.

-- 
Regards
Kefu Chai
