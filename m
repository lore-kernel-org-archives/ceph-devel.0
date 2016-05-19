From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Thu, 19 May 2016 21:09:40 +0800
Message-ID: <CAJE9aOMDLyfOVn-n18m3Ftqc3G=N-71we9qiUuhBSX+qnJBF9Q@mail.gmail.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
	<CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36200 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbcESNJm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 09:09:42 -0400
Received: by mail-yw0-f182.google.com with SMTP id x189so77039654ywe.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 06:09:41 -0700 (PDT)
In-Reply-To: <CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi cephers,

I'd like to keep you guys posted on the progress of the scrub/repair
feature. And also want to valuable comments/suggestions on it from
you! Now, I am working on the repair-write API for the scrub/repair
feature.

the API looks like:

    /**
     * Rewrite the object with the replica hosted by specified osd
     *
     * @param osd from which OSD we will copy the data
     * @param version the version of rewritten object
     * @param what the flags indicating what we will copy
     */
    int repair_copy(const std::string& oid, uint64_t version, uint32_t
what, int32_t osd, uint32_t epoch);

in which,
- `version` is the version of the object you expect to be repairing in
case of a racing write;
- `what` is an OR'ed flags of follow enum:
- `epoch` like the other scrub/repairing APIs, epoch indicating the
scrub interval is passed in.

struct repair_copy_t {
  enum {
    DATA =3D 1 << 0,
    OMAP =3D 1 << 1,
    ATTR =3D 1 << 2,
  };
};

a new REPAIR_COPY OSD op is introduced to enable the OSD side to copy
the shard/replica from specified source OSD to the acting set. and the
machinery of copy_from is reused to implement this feature. so after
rewriting the object, a version is increased, so that possibly corrupt
copies on down OSDs will get fixed naturally.

for the code, see
- https://github.com/ceph/ceph/pull/9203

for the draft design, see
- http://tracker.ceph.com/issues/13508
- http://pad.ceph.com/p/scrub_repair

the API for fixing snapset will be added later.

On Wed, Nov 11, 2015 at 11:43 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Wed, Nov 11, 2015 at 10:43 PM, =E7=8E=8B=E5=BF=97=E5=BC=BA <wonzhq=
@gmail.com> wrote:
>> 2015-11-11 19:44 GMT+08:00 kefu chai <tchaikov@gmail.com>:
>>> currently, scrub and repair are pretty primitive. there are several
>>> improvements which need to be made:
>>>
>>> - user should be able to initialize scrub of a PG or an object
>>>     - int scrub(pg_t, AioCompletion*)
>>>     - int scrub(const string& pool, const string& nspace, const
>>> string& locator, const string& oid, AioCompletion*)
>>> - we need a way to query the result of the most recent scrub on a p=
g.
>>>     - int get_inconsistent_pools(set<uint64_t>* pools);
>>>     - int get_inconsistent_pgs(uint64_t pool, paged<pg_t>* pgs);
>>>     - int get_inconsistent(pg_t pgid, epoch_t* cur_interval,
>>> paged<inconsistent_t>*)
>>> - the user should be able to query the content of the replica/shard
>>> objects in the event of an inconsistency.
>>>     - operate_on_shard(epoch_t interval, pg_shard_t pg_shard,
>>> ObjectReadOperation *op, bool allow_inconsistent)
>>> - the user should be able to perform following fixes using a new
>>> aio_operate_scrub(
>>>                                           const std::string& oid,
>>>                                           shard_id_t shard,
>>>                                           AioCompletion *c,
>>>                                           ObjectWriteOperation *op)
>>>     - specify which replica to use for repairing a content inconsis=
tency
>>>     - delete an object if it can't exist
>>>     - write_full
>>>     - omap_set
>>>     - setattrs
>>> - the user should be able to repair snapset and object_info_t
>>>     - ObjectWriteOperation::repair_snapset(...)
>>>         - set/remove any property/attributes, for example,
>>>             - to reset snapset.clone_overlap
>>>             - to set snapset.clone_size
>>>             - to reset the digests in object_info_t,
>>> - repair will create a new version so that possibly corrupted copie=
s
>>> on down OSDs will get fixed naturally.
>>>
>>
>> I think this exposes too much things to the user. Usually a user
>> doesn't have knowledges like this. If we make it too much complicate=
d,
>> no one will use it at the end.
>
> well, i tend to agree with you to some degree. this is a set of very =
low
> level APIs exposed to user, but we will accompany them with some
> ready-to-use policies to repair the typical inconsistencies. like the
> sample code attached at the end of this mail. but the point here is
> that we will not burden the OSD daemon will all of these complicated
> logic to fix and repair things. and let the magic happen out side of
> the ceph-osd in a more flexible way. for the advanced users, if they
> want to explore the possibilities to fix the inconsistencies in their=
 own
> way, they won't be disappointed also.
>
>>
>>> so librados will offer enough information and facilities, with whic=
h a
>>> smart librados client/script will be able to fix the inconsistencie=
s
>>> found in the scrub.
>>>
>>> as an example, if we run into a data inconsistency where the 3
>>> replicas failed to agree with each other after performing a deep
>>> scrub. probably we'd like to have an election to get the auth copy.
>>> following pseudo code explains how we will implement this using the
>>> new rados APIs for scrub and repair.
>>>
>>>      # something is not necessarily better than nothing
>>>      rados.aio_scrub(pg, completion)
>>>      completion.wait_for_complete()
>>>      for pool in rados.get_inconsistent_pools():
>>>           for pg in rados.get_inconsistent_pgs(pool):
>>>                # rados.get_inconsistent_pgs() throws if "epoch" exp=
ires
>>>
>>>                for oid, inconsistent in rados.get_inconsistent_pgs(=
pg,
>>> epoch).items():
>>>                     if inconsistent.is_data_digest_mismatch():
>>>                          votes =3D defaultdict(int)
>>>                          for osd, shard_info in inconsistent.shards=
:
>>>                               votes[shard_info.object_info.data_dig=
est] +=3D 1
>>>                          digest, _ =3D mavotes, key=3Doperator.item=
getter(1))
>>>                          auth_copy =3D None
>>>                          for osd, shard_info in inconsistent.shards=
=2Eitems():
>>>                               if shard_info.object_info.data_digest=
 =3D=3D digest:
>>>                                    auth_copy =3D osd
>>>                                    break
>>>                          repair_op =3D librados.ObjectWriteOperatio=
n()
>>>                          repair_op.repair_pick(auth_copy,
>>> inconsistent.ver, epoch)
>>>                          rados.aio_operate_scrub(oid, repair_op)
>>>
>>> this plan was also discussed in the infernalis CDS. see
>>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Scrub_and_Repair.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai



--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
