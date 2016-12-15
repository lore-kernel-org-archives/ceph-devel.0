From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Suggestion for deduplication
Date: Fri, 16 Dec 2016 00:43:01 +0900
Message-ID: <CAFNt83ZTpmHM9j0wBAV_8HAyWGoY_c7P_6v5tBB2Pcky_Nb_qw@mail.gmail.com>
References: <CAFNt83b8gSKxBG0c+aeW0-X7sT765NoQMZO8J2Nhtmp_=gDa-A@mail.gmail.com>
 <c92e8f44-1515-254d-a96d-29583d6b33d6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:34932 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbcLOPoQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 10:44:16 -0500
Received: by mail-ua0-f177.google.com with SMTP id 12so10740094uas.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 07:43:02 -0800 (PST)
In-Reply-To: <c92e8f44-1515-254d-a96d-29583d6b33d6@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Please see my previous mail (expermient 2).

We will make a public repo after source code is reworked based on
community feedback.


thanks.

2016-12-15 20:07 GMT+09:00 Joao Eduardo Luis <joao@suse.de>:
> This looks interesting.
>
> Is there a repo we can look at with this implementation?
>
> Do you have any initial performance evaluations?
>
>   -Joao
>
>
> On 12/14/2016 10:57 AM, myoungwon oh wrote:
>>
>> Hi sage, ceph developers
>>
>> I am a system software engineer working at SK telecom.
>> We are developing Data deduplication in Ceph, based on discussions of
>> Ceph community and our own research.
>> Current status is as below, we implemented prototype, and we want to
>> share our result to Ceph community and want to get your feedback.
>>
>> 1. Motivation
>> We studied which structure deduplication is suitable for Ceph, the
>> distributed file system of shared-nothing architecture. As a result,
>> it seems the most reasonable method is to utilize data distribution
>> using hash value, which is used in Shared-nothing architecture and
>> tiering.
>> The reason is as follows
>> 1- There is no change in current structure, and there is no big
>> additional change.
>> 2- There is no need to develop and configure a separated deduplication
>> metadata server.
>> 3- EC and Replication can be selected and used. That is, since
>> deduplication is performed in cache tier, existing features of below
>> layer can be utilized as it is.
>> 4- Don't need to consider data placement, load balancing and recovery.
>> Because existing structure is used, features mentioned above will be
>> handled as in original Ceph. So only the metadata part need to be
>> handled.
>>
>> 2. Design concept
>> Main design concept is double CRUSH + cache tier.
>> (http://imgur.com/9F3jQA6)
>>
>> "double CRUSH"
>> Hash the incoming data to an OID, and assign that hash value as a new OI=
D.
>> For example, OID : DATA -->(hash)--> FP_OID : DATA
>>
>> "cache tier"
>> Redirection is required for new OID(hash value). If we use cache tier
>> which is currently implemented, we can receive request at Cache tier
>> first and then, can redirecting the request to the actual storage
>> tier.
>> Currently inline processing is possible using the proxy mode of cache
>> tier. And also inline+post processing is possible using the writeback
>> mode of cache tier.
>>
>> 3. Design detail
>> (http://imgur.com/qUQ5e44)
>>
>> "I/O flow (inline mode)
>> Write : write request -> fingerprint calculation -> search lookup
>> table(OID <-> Fingerprint(FP) OID mapping) ->
>>  (If data exist) for old FP_OID, decrease reference count through
>> setattr of Objecter -> Increase reference count
>>  through setxattr with new FP_OID -> update lookup table =E2=80=93 compl=
ete
>>
>> Read : read request -> search lookup table -> (If data exist) Request
>> data with mapped FP_OID
>>
>> "I/O flow (inline+post processing)
>> Write : flush event occur -> Request COPY_FROM by dividing object into
>> fixed size chunk -> update lookup table
>>
>> Read : promote_object requests a COPY_GET, with chunk as unit.
>>
>> "chunking"
>> Currently, 4K, 128K, 256K, and 512K chunk size are available as fixed
>> chunk size.
>>
>> "Lookup table"
>> Lookup table manages the OID and fingerprint mapping and status(number
>> of chunks, state) of deduped object.
>> The matching of OID, offset and fingerprint for each request is
>> processed through this table.
>>
>> "metadata recovery & replication"
>> Data recovery is done by the existing Ceph structure. Therefore,
>> additional implementation is needed for deduplication metadata
>> management. Newly added data structure is only a lookup table.
>> We can secure the reliability by using existing replication
>> structure.(When lookup table updated, request it to another OSDs, that
>> having same  replicated table in them for syncing of entries)
>>
>> "metadata cache"
>> Metadata & data cache is one of the important structures that
>> determine the performance of deduplication. Currently it is
>> implemented through simple LRU and Level-DB,but we are planning to
>> develop additional improved algorithms and data structures.
>>
>> 4. Prototype evaluation (inline mode, 512K chunk, RBD, Seq. write)
>>
>> "Experiment 1 (http://imgur.com/Fdq7mWr)=E2=80=9D
>>
>> X axis represents the number of stored OS images, and the Y axis
>> represents the total storage capacity as the X axis value increases.
>> (Images are based on Cent OS 7.0) In addition to being able to remove
>> the same block from the same image
>> (if the OS image number is 1), can see only an additional 50MB is
>> stored if stores similar image.
>>
>> "Experiment 2 (http://imgur.com/wHGVNMq)"
>>
>> The actual data rate, is the data stored in the ceph cluster / data
>> stored by the client. In case of Dedup ratio 20, the actual storage
>> ratio is slightly higher because of ceph and dedup metadata, but in
>> the remaining cases we can see it is close to ideal value.
>> In performance perspective, we can see the performance become half,
>> because of additional computations of Proxy structure and
>> deduplication.(current implementation (inline) must redirect write
>> message to storage tier. dedupe is done at storage tier. This can be
>> fixed later)
>>
>> 5. Weak point
>> Fragmentation issue occurs because we can't determine the chunk
>> placement. Deduplication always has a fragmentation issue, but it can
>> be worse because we can't involve in data placement.
>> However, since we use flash device as main target, the performance of
>> flash can be increased because chunks are striped.
>> If not, it would be okay with using a relatively large chunk size(256K,
>> 512K)
>>
>>
>> Thanks.
>> Regards
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
