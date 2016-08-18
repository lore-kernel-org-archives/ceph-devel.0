From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: per-pool bluestore options
Date: Thu, 18 Aug 2016 19:16:16 +0300
Message-ID: <e161ff11-aef1-fc26-3d65-3b2b549a60a7@mirantis.com>
References: <alpine.DEB.2.11.1608131843050.17762@piezo.us.to>
 <4adc2518-07d5-f4bd-7d71-5716bfb767c1@mirantis.com>
 <alpine.DEB.2.11.1608171617250.17762@piezo.us.to>
 <26d298ca-a400-c102-92fc-6f5dd3d483f4@mirantis.com>
 <alpine.DEB.2.11.1608181513430.2394@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33967 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbcHSB3u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Aug 2016 21:29:50 -0400
Received: by mail-lf0-f48.google.com with SMTP id l89so23096170lfi.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 18:28:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608181513430.2394@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


On 18.08.2016 18:26, Sage Weil wrote:
> On Thu, 18 Aug 2016, Igor Fedotov wrote:
>> On 17.08.2016 19:27, Sage Weil wrote:
>>> On Mon, 15 Aug 2016, Igor Fedotov wrote:
>>>> On 13.08.2016 21:56, Sage Weil wrote:
>>>>> Hi Igor,
>>>>>
>>>>> I took another look at
>>>>>
>>>>> 	https://github.com/ceph/ceph/pull/10556
>>>>>
>>>>> You define three settings:
>>>>>
>>>>>     compress_hint - determines if pool contains compressible /
>>>>> incompressible
>>>>> data
>>>>>     compress_algorithm - permits to specify different compression
>>>>> algorithm
>>>>>     compress_ratio - specifies maximum compression ratio
>>>>>
>>>>> I think we should extend this to include csum-related options.  And use
>>>>> a
>>>>> consistent naming scheme that aligns with the config options where we
>>>>> just
>>>>> strip off the bluestore_ prefix.  The relevant options are:
>>>> Sounds good!
>>>> The major questions here is how do these per-pool options correlate with
>>>> corresponding per-store ones?
>>>> One might suggest per-pool options to have higher priority over per-store
>>>> one.
>>>> But I'm not sure that the best option.  Sometimes user might want to
>>>> disable/alter corresponding option without enumerating all the pools by
>>>> simple
>>>> switching at per-store level. Hence we need to consider some means for
>>>> that.
>>>>>     bluestore_csum = {true, false}
>>>>>     bluestore_csum_type = {crc32c, crc32c_{8,16}, ...}
>>>>>     bluestore_csum_min_chunk_size = 4k      (*)
>>>>>     bluestore_csum_max_chunk_size = 64k     (*)
>>>>>     bluestore_compression = {force, aggressive, passive, none}
>>>> Actually this option along with compression_hint result in a single flag:
>>>> compress or not. Any rationale for not using that simple flag?
>>> There are currently two persistent hints: compressible and incompressible.
>>> Aggressive will compress unless incompressible, whereas passive will
>>> compress if compressible.  Either way it varies per object, though, so a
>>> single flag isn't sufficient.
>> So final approach is to have bluestore_compression switch at pool level (and
>> per-store too) and compression_hint at object one, right? Hence we don't need
>> compression_hint per pool. In fact my original point was that the latter(along
>> with bluestore_compression) is IMHO an overkill and can be substituted with
>> simple enable_compression flag.
> I think so.  Having a pool compression_hint = compressible will accomplish
> the same thing as setting the pool compression = aggressive.
OK, Sounds good!
Still there is an open question how to assign such a hint to objects 
from user perspective....
>
>>>> My original idea here was to have bluestore_compression on per-store basis
>>>> and
>>>> compression_hint of per pool one. This way one can receive pretty flexible
>>>> control at both storage and pool level - see my question above.
>>> Yeah, I'm not sure how complex it's worth getting.  To get complete
>>> control, we probably need a default *and* the min/max allowed range for
>>> each option in order to bound what you can choose per-pool, but I think
>>> that is probably overkill.
>>>
>>> A bit easier would be to have
>>>
>>>    bluestore_csum_override = {,true,false}
>>>    bluestore_csum_type_override = {, crc32c, crc32c_{8,16}}
>>>    bluestore_compression_override = {, force, aggressive, passive, none}
>>>
>>> and have them blank by default (no override).  For the numeric options
>>> we'd need to use 0 to mean 'no override'.
>>>
>>> What do you think?
>> IMO per-pool settings (if set) have to override corresponding per-store
>> one by default. But one should be able to turn off that behavior with
>> 'one-click' and force specific per-store setting to prevail.
>> Hence we don't need 'override' settings at per-pool level but should have one
>> at per-store one. E.g.
>>
>> Pool A has:
>> bluestore_csum = true
>> Pool B:
>> bluestore_csum=<not set>
>> OSD:
>> bluestore_csum=  false [/force]
>>
>> if /'force' is omitted - actual settings are
>> Pool A:
>> bluestore_csum=true
>> Pool B:
>> bluestore_csum=false
>>
>> else
>> Pool A:
>> bluestore_csum=false
>> Pool B:
>> bluestore_csum=false
> Hmm, this makes parsing more complicated but is probably less confusing.
> But what about numeric values?
>
>   bluestore_compression_max_blob_size=1048576/force?
>
> This is partly why I like the (implementation) simplicity of
>
>   bluestore_compression_max_blob_size_force=1048576
>
> (or _override, whatever).
This way one gets parameter name duplication for each per-store 
parameter that has per-pool clone. E.g.

  bluestore_compression_max_blob_size for default settings

and
  bluestore_compression_max_blob_size_force for override ones.

Can't say that's pretty elegant..
What's about a single generic parameter that denotes per-collection params to be banned, e.g.

bluestore_force_per_store_settings = *
bluestore_force_per_store_settings = bluestore_compression
bluestore_force_per_store_settings = bluestore_compression, bluestore_csum, bluestore_csum_type


or bluestore_disable_per_collection_settings = a,b,c ?

Alternative per-collection enable option seems a bit less convenient here IMHO.

>> An additional 'bluestore_force_all_settings=true' can be introduced to force
>> all per-store settings to prevail too.
> Or maybe
>
>   bluestore_ignore_per_collection_settings=true
> or the converse
>   bluestore_per_collection_settings=false
>
> to be precise?
>
>>>>>     bluestore_compression_algorithm = {snappy, zlib, ...}
>>>>>     bluestore_compression_min_blob_size = 256k
>>>>>     bluestore_compression_max_blob_size = 4M
>>>>>     bluestore_compression_required_ratio = .875
>>>>>
>>>>> (*) These currently have a different name but aren't used yet.  Working
>>>>> on
>>>>> a PR to change that.
>>>>>
>>>>> What's missing is your 'compress_hint'.  We can call that
>>>>> 'compression_hint' to align with the names above?
>>>>>
>>>>>     compression_hint = {compressible, incompressible, ...}
>>>>>
>>>>> The main changes from your PR that I think we need to make are:
>>>>>
>>>>> * These options should be part of the pool_opts_t structure in pg_pool_t
>>>>> (which is a set of optional key/value-like parameters for the pool).
>>>>>
>>>>> * We can add a new ObjectStore operation that passes down parameters for
>>>>> a
>>>>> collection, and have the OSD pass these all in for each PG collection
>>>>> when
>>>>> the pool properties change.  That way ObjectStore doesn't need to
>>>>> persist
>>>>> these options at all--just store the ones it understands in memory, and
>>>>> the OSD will always reset them on startup etc.
>>>> One, probably silly, question here - do pool and collection have 1 to 1
>>>> relation? It seemed to me that they don't and hence we can't store
>>>> per-pool
>>>> settings at collection level without some additional mapping: pool ->
>>>> setting.
>>>> Also this requires some means to remove pool settings entry when pool goes
>>>> away...
>>> It's 1:1 mapping of PG to collection, but lots of PGs per pool.  So when
>>> the OSD gets a pool change, it'll set the same flags for all local PGs in
>>> that pool.  A bit of duplication, but it keeps the interface
>>> uncomplicated (no need to teach ObjectStore about pools).
>> And PG belongs to single pool only, right?
> Right.
>
> sage

