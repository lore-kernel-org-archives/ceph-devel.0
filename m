From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Wed, 11 Nov 2015 23:43:22 +0800
Message-ID: <CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35184 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbbKKPnX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 10:43:23 -0500
Received: by qgec40 with SMTP id c40so25879730qge.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 07:43:22 -0800 (PST)
In-Reply-To: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?546L5b+X5by6?= <wonzhq@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 11, 2015 at 10:43 PM, =E7=8E=8B=E5=BF=97=E5=BC=BA <wonzhq@g=
mail.com> wrote:
> 2015-11-11 19:44 GMT+08:00 kefu chai <tchaikov@gmail.com>:
>> currently, scrub and repair are pretty primitive. there are several
>> improvements which need to be made:
>>
>> - user should be able to initialize scrub of a PG or an object
>>     - int scrub(pg_t, AioCompletion*)
>>     - int scrub(const string& pool, const string& nspace, const
>> string& locator, const string& oid, AioCompletion*)
>> - we need a way to query the result of the most recent scrub on a pg=
=2E
>>     - int get_inconsistent_pools(set<uint64_t>* pools);
>>     - int get_inconsistent_pgs(uint64_t pool, paged<pg_t>* pgs);
>>     - int get_inconsistent(pg_t pgid, epoch_t* cur_interval,
>> paged<inconsistent_t>*)
>> - the user should be able to query the content of the replica/shard
>> objects in the event of an inconsistency.
>>     - operate_on_shard(epoch_t interval, pg_shard_t pg_shard,
>> ObjectReadOperation *op, bool allow_inconsistent)
>> - the user should be able to perform following fixes using a new
>> aio_operate_scrub(
>>                                           const std::string& oid,
>>                                           shard_id_t shard,
>>                                           AioCompletion *c,
>>                                           ObjectWriteOperation *op)
>>     - specify which replica to use for repairing a content inconsist=
ency
>>     - delete an object if it can't exist
>>     - write_full
>>     - omap_set
>>     - setattrs
>> - the user should be able to repair snapset and object_info_t
>>     - ObjectWriteOperation::repair_snapset(...)
>>         - set/remove any property/attributes, for example,
>>             - to reset snapset.clone_overlap
>>             - to set snapset.clone_size
>>             - to reset the digests in object_info_t,
>> - repair will create a new version so that possibly corrupted copies
>> on down OSDs will get fixed naturally.
>>
>
> I think this exposes too much things to the user. Usually a user
> doesn't have knowledges like this. If we make it too much complicated=
,
> no one will use it at the end.

well, i tend to agree with you to some degree. this is a set of very lo=
w
level APIs exposed to user, but we will accompany them with some
ready-to-use policies to repair the typical inconsistencies. like the
sample code attached at the end of this mail. but the point here is
that we will not burden the OSD daemon will all of these complicated
logic to fix and repair things. and let the magic happen out side of
the ceph-osd in a more flexible way. for the advanced users, if they
want to explore the possibilities to fix the inconsistencies in their o=
wn
way, they won't be disappointed also.

>
>> so librados will offer enough information and facilities, with which=
 a
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
>>                # rados.get_inconsistent_pgs() throws if "epoch" expi=
res
>>
>>                for oid, inconsistent in rados.get_inconsistent_pgs(p=
g,
>> epoch).items():
>>                     if inconsistent.is_data_digest_mismatch():
>>                          votes =3D defaultdict(int)
>>                          for osd, shard_info in inconsistent.shards:
>>                               votes[shard_info.object_info.data_dige=
st] +=3D 1
>>                          digest, _ =3D mavotes, key=3Doperator.itemg=
etter(1))
>>                          auth_copy =3D None
>>                          for osd, shard_info in inconsistent.shards.=
items():
>>                               if shard_info.object_info.data_digest =
=3D=3D digest:
>>                                    auth_copy =3D osd
>>                                    break
>>                          repair_op =3D librados.ObjectWriteOperation=
()
>>                          repair_op.repair_pick(auth_copy,
>> inconsistent.ver, epoch)
>>                          rados.aio_operate_scrub(oid, repair_op)
>>
>> this plan was also discussed in the infernalis CDS. see
>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Scrub_and_Repair.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
