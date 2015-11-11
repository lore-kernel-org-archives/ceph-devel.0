From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Wed, 11 Nov 2015 22:53:36 +0800
Message-ID: <CAJE9aOP0=Swibo9rMLvKwqqNnUaAcyLAP+b-6QZeYkg4o+S2hQ@mail.gmail.com>
References: <CAJE9aOMW9REHMc8b3o63CwxN2doY0O3pU+QcWrErKZMvwVtznw@mail.gmail.com>
	<alpine.DEB.2.00.1511110516330.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35231 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbKKOxh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 09:53:37 -0500
Received: by qgec40 with SMTP id c40so24770414qge.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 06:53:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511110516330.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 11, 2015 at 9:25 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 11 Nov 2015, kefu chai wrote:
>> currently, scrub and repair are pretty primitive. there are several
>> improvements which need to be made:
>>
>> - user should be able to initialize scrub of a PG or an object
>>     - int scrub(pg_t, AioCompletion*)
>>     - int scrub(const string& pool, const string& nspace, const
>> string& locator, const string& oid, AioCompletion*)
>> - we need a way to query the result of the most recent scrub on a pg.
>>     - int get_inconsistent_pools(set<uint64_t>* pools);
>>     - int get_inconsistent_pgs(uint64_t pool, paged<pg_t>* pgs);
>>     - int get_inconsistent(pg_t pgid, epoch_t* cur_interval,
>> paged<inconsistent_t>*)
>
> What is paged<>?

it's a template supporting pagination for querying the scrub results.
something like:

template <typename T>
class Paged {
  const unsigned max_size;
  uint64_t current;
  uint64_t last;
  vector<T> page;
};

>
>> - the user should be able to query the content of the replica/shard
>> objects in the event of an inconsistency.
>>     - operate_on_shard(epoch_t interval, pg_shard_t pg_shard,
>> ObjectReadOperation *op, bool allow_inconsistent)
>
> This is exposing a bunch of internal types (pg_t, pg_shard_t, epoch_t) up
> through librados.  We might want to consider making them strings or just
> unsigned or similar?  I'm mostly worried about making it hard for us to
> change the types later...

oh, agreed! we should try to expose less/none internal types here. the
interface change would be a pain in the future.

>
>> - the user should be able to perform following fixes using a new
>> aio_operate_scrub(
>>                                           const std::string& oid,
>>                                           shard_id_t shard,
>>                                           AioCompletion *c,
>>                                           ObjectWriteOperation *op)
>>     - specify which replica to use for repairing a content inconsistency
>>     - delete an object if it can't exist
>>     - write_full
>>     - omap_set
>>     - setattrs
>
> For omap_set and setattrs do we want a _full-type equivalent, or would we
> support partial changes?  Partial updates won't necessary resolve an
> inconsistency, but I think (?) in the ec case the full xattr set is in
> the log event?

i think we will be try to support most of the librados APIs (the methods
of librados::IoCtx) so user is able to get/rewrite the omap and xattrs
while bypassing the check posed by OSD. i.e. be able to read
the data of an object even it's missing!

>
>> - the user should be able to repair snapset and object_info_t
>>     - ObjectWriteOperation::repair_snapset(...)
>>         - set/remove any property/attributes, for example,
>>             - to reset snapset.clone_overlap
>>             - to set snapset.clone_size
>>             - to reset the digests in object_info_t,
>> - repair will create a new version so that possibly corrupted copies
>> on down OSDs will get fixed naturally.
>>
>> so librados will offer enough information and facilities, with which a
>> smart librados client/script will be able to fix the inconsistencies
>> found in the scrub.
>>
>> as an example, if we run into a data inconsistency where the 3
>> replicas failed to agree with each other after performing a deep
>> scrub. probably we'd like to have an election to get the auth copy.
>> following pseudo code explains how we will implement this using the
>> new rados APIs for scrub and repair.
>>
>>      # something is not necessarily better than nothing
>>      rados.aio_scrub(pg, completion)
>>      completion.wait_for_complete()
>>      for pool in rados.get_inconsistent_pools():
>>           for pg in rados.get_inconsistent_pgs(pool):
>>                # rados.get_inconsistent_pgs() throws if "epoch" expires
>>
>>                for oid, inconsistent in rados.get_inconsistent_pgs(pg,
>> epoch).items():
>>                     if inconsistent.is_data_digest_mismatch():
>>                          votes = defaultdict(int)
>>                          for osd, shard_info in inconsistent.shards:
>>                               votes[shard_info.object_info.data_digest] += 1
>>                          digest, _ = mavotes, key=operator.itemgetter(1))
>>                          auth_copy = None
>>                          for osd, shard_info in inconsistent.shards.items():
>>                               if shard_info.object_info.data_digest == digest:
>>                                    auth_copy = osd
>>                                    break
>>                          repair_op = librados.ObjectWriteOperation()
>>                          repair_op.repair_pick(auth_copy,
>> inconsistent.ver, epoch)
>>                          rados.aio_operate_scrub(oid, repair_op)
>>
>> this plan was also discussed in the infernalis CDS. see
>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Scrub_and_Repair.
>
> We should definitely make sure these are surfaced in the python bindings
> from the start.  :)
>
> Sounds good to me!
> sage
>



-- 
Regards
Kefu Chai
