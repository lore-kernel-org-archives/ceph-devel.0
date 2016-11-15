From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: A way to reduce compression overhead
Date: Tue, 15 Nov 2016 16:14:33 +0300
Message-ID: <a3f50c37-dfb1-a516-f768-2074204227d1@mirantis.com>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
 <alpine.DEB.2.11.1611082019530.29278@piezo.us.to>
 <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com>
 <alpine.DEB.2.11.1611112330530.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38315 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932987AbcKONPI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 08:15:08 -0500
Received: by mail-it0-f50.google.com with SMTP id o1so773088ito.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2016 05:15:08 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611112330530.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
please find inline.
On 12.11.2016 2:42, Sage Weil wrote:
> On Wed, 9 Nov 2016, Igor Fedotov wrote:
>
> The concern I have here is that it probably won't map well onto EC.  The
> primary can't easily have the local ObjectStore chunking things up and
> then "pass it to the replica".. there's an intermediate layer between the
> replication code and the ObjectStore (and is getting a bit more
> sophisticated with the coming EC changes).
>
> I think the simplest approach here would be to keep it simple.  For
> example, a min_alloc_size and max compressed chunk size specified for the
> pool.  The intermediate layer can apply the EC striping parameters, and
> then chunk/compress accordingly.
>
> I agree that worrying about client-side compression seems like a lot at
> this stage, but it's going to be the very next thing we ask about, so we
> should consider it to make sure we don't put up any major roadblocks.
>
> Either way, though, we should probably wait for the EC overwrite changes
> to land...
Got it, thanks. Will start working on POC meanwhile.
>
> As for GC,
>
>>> I'm curious what you have in mind!  The blob_depth as currently
>>> implemented is not terribly reliable...
>> General idea is to estimate allocated vs stored ratio for the blob(s) under
>> the extent being written.
>> Where stored and allocated are measured in allocation units. And can be
>> calculated using blobs ref_map.
>> If that ratio is greater than 1 (+-some correction) - we need to perform GC
>> for these blobs. Given the fact we do that after compression preprocessing
>> it's expensive to merge the compressed extent being written and old shards.
>> Hence that shards are written as standalone extents as opposed to current
>> implementation when we try to merge both new and existing extents into  a
>> single entity. Not a big drawback IMHO. Evidently this is valid for new
>> compressed extents (that are AU aligned) only. Uncompressed ones can be merged
>> in any fashion.
>> This is just a draft hence comments are highly appreciated.
> Yeah, I think this is a more sensible approach (focusing on allocated vs
> referenced).  It seems like the most straightforward thing to do is
> actually look at the old_extents in the wctx--since those are the ref_maps
> that will become less referenced than before--in order to identify which
> blobs might need rewriting.  Avoiding the merge case vastly simplifies it.
> That also isn't any persistent metadata that we have to maintain (that
> might become incorrect or inconsistent).
>
> We'd probably do the _do_write_data (which will do the various
> punch_hole's), then check for any gc work, then do the final
> _do_alloc_write and _wctx_finish?
>
Sounds good. Still need a detailed consistent algorithm though - working 
on that.
>

