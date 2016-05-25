From: Samuel Just <sjust@redhat.com>
Subject: Re: new scrub and repair discussion
Date: Wed, 25 May 2016 10:37:30 -0700
Message-ID: <CAN=+7FVA-H1oxpS7p-sZVQobPmJwoiV0hUO8ugNTB-2M-OiSwg@mail.gmail.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
	<CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
	<CAJE9aOMDLyfOVn-n18m3Ftqc3G=N-71we9qiUuhBSX+qnJBF9Q@mail.gmail.com>
	<CAN=+7FVsVFW_omt2P6HgNsCGtOh25mnOpnqCRfctY+wRrWvyrw@mail.gmail.com>
	<CAJE9aONjDEt3vUAEYJc_oBwcv8LUy-iWA0mMtY3-EvkyrFBXCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33306 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbcEYRhb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 13:37:31 -0400
Received: by mail-qk0-f180.google.com with SMTP id n63so39756998qkf.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 10:37:31 -0700 (PDT)
In-Reply-To: <CAJE9aONjDEt3vUAEYJc_oBwcv8LUy-iWA0mMtY3-EvkyrFBXCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 20, 2016 at 4:30 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Fri, May 20, 2016 at 1:55 AM, Samuel Just <sjust@redhat.com> wrote=
:
>> How would this work for an ec pool?  Maybe the osd argument should b=
e
>> a set of valid peers?
>
> maybe in the case of ec pool, we should ignore the osd argument.
>
> <quote from=3D"http://pad.ceph.com/p/scrub_repair">
> david points out that for EC pools, don't allow incorrect shards to b=
e
> selected as correct
> - admin might decide to delete an object if it can't exist
> - similar to unfound object case
> - repair should have a use-your-best-judgement flag -- mandatory for
> ec (if not deleting the object)
> - for ec, if we want to read a shard, need to specify the shard id as
> well since an osd might have two shards
>   - request would indicate the shard
> </quote>
>
> because the ec subread does not return the payload if the size or the
> digest fails to match, and instead, an EIO is returned. on the primar=
y
> side, ECBackend::handle_sub_read_reply() will send more subread ops t=
o
> the shard(s) which is yet used if it is unable to reconstruct the
> requested extent with shards already returned. if we want to
> explicitly exclude the "bad" shards from being used, maybe the
> simplest way is to remove it before calling repair-copy. and we can
> offer an API for removing a shard. but I doubt that we need to do
> this. as the chance of having a corrupted shard whose checksum matche=
s
> with its digest stored in its object-info xattr,  is very small. and
> maybe we fix a corrupted shard in ec pool by reading the impacted
> object, and then overwriting the original copy with the reconstructed
> one from the good shards.

I think it would be simpler to just allow the repair_write call to
specify a set of bad shards.  For replicated pools, we simply choose
one which is not in that set.  For EC pools, we use that information
to avoid bad shards.

>
> <quote from=3D"http://pad.ceph.com/p/scrub_repair">
> repair (need a flag to aio_operate  write variant to allow overwritin=
g
> an unfound object) (needs to bypass snapshotting) (allow to write to =
a
> clone?) (require x cap bit?)
>  delete
>  writefull ...
>  omap_set_...
>  setattrs ...
> </quote>
>
> do we still need the REPAIR_WRITE flag for overwriting an unfound
> object? i removed an object in osd's store directory, and the
> repair-copy does fix it for me. or I misunderstand this line...
>

It may not be necessary for this mechanism to repair unfound objects,
I merged a new version of that system in the last cycle.  I guess it
depends on what you'd consider most convenient.
-Sam

>> -Sam
>>
>> On Thu, May 19, 2016 at 6:09 AM, kefu chai <tchaikov@gmail.com> wrot=
e:
>>> hi cephers,
>>>
>>> I'd like to keep you guys posted on the progress of the scrub/repai=
r
>>> feature. And also want to valuable comments/suggestions on it from
>>> you! Now, I am working on the repair-write API for the scrub/repair
>>> feature.
>>>
>>> the API looks like:
>>>
>>>     /**
>>>      * Rewrite the object with the replica hosted by specified osd
>>>      *
>>>      * @param osd from which OSD we will copy the data
>>>      * @param version the version of rewritten object
>>>      * @param what the flags indicating what we will copy
>>>      */
>>>     int repair_copy(const std::string& oid, uint64_t version, uint3=
2_t
>>> what, int32_t osd, uint32_t epoch);
>>>
>>> in which,
>>> - `version` is the version of the object you expect to be repairing=
 in
>>> case of a racing write;
>>> - `what` is an OR'ed flags of follow enum:
>>> - `epoch` like the other scrub/repairing APIs, epoch indicating the
>>> scrub interval is passed in.
>>>
>>> struct repair_copy_t {
>>>   enum {
>>>     DATA =3D 1 << 0,
>>>     OMAP =3D 1 << 1,
>>>     ATTR =3D 1 << 2,
>>>   };
>>> };
>>>
>>> a new REPAIR_COPY OSD op is introduced to enable the OSD side to co=
py
>>> the shard/replica from specified source OSD to the acting set. and =
the
>>> machinery of copy_from is reused to implement this feature. so afte=
r
>>> rewriting the object, a version is increased, so that possibly corr=
upt
>>> copies on down OSDs will get fixed naturally.
>>>
>>> for the code, see
>>> - https://github.com/ceph/ceph/pull/9203
>>>
>>> for the draft design, see
>>> - http://tracker.ceph.com/issues/13508
>>> - http://pad.ceph.com/p/scrub_repair
>>>
>>> the API for fixing snapset will be added later.
>>>
>>> On Wed, Nov 11, 2015 at 11:43 PM, kefu chai <tchaikov@gmail.com> wr=
ote:
>>>> On Wed, Nov 11, 2015 at 10:43 PM, =E7=8E=8B=E5=BF=97=E5=BC=BA <won=
zhq@gmail.com> wrote:
>>>>> 2015-11-11 19:44 GMT+08:00 kefu chai <tchaikov@gmail.com>:
>>>>>> currently, scrub and repair are pretty primitive. there are seve=
ral
>>>>>> improvements which need to be made:
>>>>>>
>>>>>> - user should be able to initialize scrub of a PG or an object
>>>>>>     - int scrub(pg_t, AioCompletion*)
>>>>>>     - int scrub(const string& pool, const string& nspace, const
>>>>>> string& locator, const string& oid, AioCompletion*)
>>>>>> - we need a way to query the result of the most recent scrub on =
a pg.
>>>>>>     - int get_inconsistent_pools(set<uint64_t>* pools);
>>>>>>     - int get_inconsistent_pgs(uint64_t pool, paged<pg_t>* pgs);
>>>>>>     - int get_inconsistent(pg_t pgid, epoch_t* cur_interval,
>>>>>> paged<inconsistent_t>*)
>>>>>> - the user should be able to query the content of the replica/sh=
ard
>>>>>> objects in the event of an inconsistency.
>>>>>>     - operate_on_shard(epoch_t interval, pg_shard_t pg_shard,
>>>>>> ObjectReadOperation *op, bool allow_inconsistent)
>>>>>> - the user should be able to perform following fixes using a new
>>>>>> aio_operate_scrub(
>>>>>>                                           const std::string& oid=
,
>>>>>>                                           shard_id_t shard,
>>>>>>                                           AioCompletion *c,
>>>>>>                                           ObjectWriteOperation *=
op)
>>>>>>     - specify which replica to use for repairing a content incon=
sistency
>>>>>>     - delete an object if it can't exist
>>>>>>     - write_full
>>>>>>     - omap_set
>>>>>>     - setattrs
>>>>>> - the user should be able to repair snapset and object_info_t
>>>>>>     - ObjectWriteOperation::repair_snapset(...)
>>>>>>         - set/remove any property/attributes, for example,
>>>>>>             - to reset snapset.clone_overlap
>>>>>>             - to set snapset.clone_size
>>>>>>             - to reset the digests in object_info_t,
>>>>>> - repair will create a new version so that possibly corrupted co=
pies
>>>>>> on down OSDs will get fixed naturally.
>>>>>>
>>>>>
>>>>> I think this exposes too much things to the user. Usually a user
>>>>> doesn't have knowledges like this. If we make it too much complic=
ated,
>>>>> no one will use it at the end.
>>>>
>>>> well, i tend to agree with you to some degree. this is a set of ve=
ry low
>>>> level APIs exposed to user, but we will accompany them with some
>>>> ready-to-use policies to repair the typical inconsistencies. like =
the
>>>> sample code attached at the end of this mail. but the point here i=
s
>>>> that we will not burden the OSD daemon will all of these complicat=
ed
>>>> logic to fix and repair things. and let the magic happen out side =
of
>>>> the ceph-osd in a more flexible way. for the advanced users, if th=
ey
>>>> want to explore the possibilities to fix the inconsistencies in th=
eir own
>>>> way, they won't be disappointed also.
>>>>
>>>>>
>>>>>> so librados will offer enough information and facilities, with w=
hich a
>>>>>> smart librados client/script will be able to fix the inconsisten=
cies
>>>>>> found in the scrub.
>>>>>>
>>>>>> as an example, if we run into a data inconsistency where the 3
>>>>>> replicas failed to agree with each other after performing a deep
>>>>>> scrub. probably we'd like to have an election to get the auth co=
py.
>>>>>> following pseudo code explains how we will implement this using =
the
>>>>>> new rados APIs for scrub and repair.
>>>>>>
>>>>>>      # something is not necessarily better than nothing
>>>>>>      rados.aio_scrub(pg, completion)
>>>>>>      completion.wait_for_complete()
>>>>>>      for pool in rados.get_inconsistent_pools():
>>>>>>           for pg in rados.get_inconsistent_pgs(pool):
>>>>>>                # rados.get_inconsistent_pgs() throws if "epoch" =
expires
>>>>>>
>>>>>>                for oid, inconsistent in rados.get_inconsistent_p=
gs(pg,
>>>>>> epoch).items():
>>>>>>                     if inconsistent.is_data_digest_mismatch():
>>>>>>                          votes =3D defaultdict(int)
>>>>>>                          for osd, shard_info in inconsistent.sha=
rds:
>>>>>>                               votes[shard_info.object_info.data_=
digest] +=3D 1
>>>>>>                          digest, _ =3D mavotes, key=3Doperator.i=
temgetter(1))
>>>>>>                          auth_copy =3D None
>>>>>>                          for osd, shard_info in inconsistent.sha=
rds.items():
>>>>>>                               if shard_info.object_info.data_dig=
est =3D=3D digest:
>>>>>>                                    auth_copy =3D osd
>>>>>>                                    break
>>>>>>                          repair_op =3D librados.ObjectWriteOpera=
tion()
>>>>>>                          repair_op.repair_pick(auth_copy,
>>>>>> inconsistent.ver, epoch)
>>>>>>                          rados.aio_operate_scrub(oid, repair_op)
>>>>>>
>>>>>> this plan was also discussed in the infernalis CDS. see
>>>>>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Scrub_and_Repai=
r.
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>
>>>>
>>>>
>>>> --
>>>> Regards
>>>> Kefu Chai
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
