From: Sage Weil <sage@newdream.net>
Subject: Re: Extensive attributes not getting copied when flushing HEAD
 objects from cache pool to base pool.
Date: Wed, 23 Aug 2017 16:07:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708231602050.20435@piezo.novalocal>
References: <CAJACTuf_PmJvQVvbMb2UeXugKRd9dhLRVpz7-DzSr3=-UHgv-g@mail.gmail.com> <CAJACTuczuaMokWTkBFmr1um-3k5DuEQ5ZXRm+BqkJ52F_c22sQ@mail.gmail.com> <CAJACTudxBVMtdDLbMqCtCtYm--qA8xHygO8RxA80Uy66C_iavg@mail.gmail.com>
 <CAJACTuckTMrtVG55eM8wLrzL-F=10oR_GeZq8kC0hGJaV5V89w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33541 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbdHWQIC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 12:08:02 -0400
In-Reply-To: <CAJACTuckTMrtVG55eM8wLrzL-F=10oR_GeZq8kC0hGJaV5V89w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 23 Aug 2017, Xuehan Xu wrote:
> Hi, everyone.
> 
> In ReplicatedPG::_write_copy_chunk method, I saw the following code:
> 
> if (!cop->temp_cursor.attr_complete) {
>     t->touch(cop->results.temp_oid);
>     for (map<string, bufferlist>::iterator p = cop->attrs.begin();
>     p != cop->attrs.end(); ++p) {
>     cop->results.attrs[string("_") + p->first] = p->second;
>     t->setattr(cop->results.temp_oid, string("_") + p->first,
>        p->second);
> }
>     cop->attrs.clear();
> }
> 
> It seems that user specified attrs are prefixed by "_", but why add
> "_" here, in ReplicatedPG::_write_copy_chunk? It seems that this
> method is used for copying objects in the RADOS cluster,.

That is by design.  The non-_ attributes are managed locally.

In this case, the clone_overlap is not preserved because there is no code 
to attempt to preserve it across the cache tier.  (And blindly copying the 
_ attribute wouldn't work.)

I'm not sure what the issues would be with passing that metadata across 
the promote and flush operations...  I imagine it will be a bit fragile, 
though.

Is this something that is really worth fixing?

sage


> 
> On 23 August 2017 at 15:40, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> > It seems that when calling ReplicatedPG::getattrs_maybe_cache in
> > ReplicatedPG::fill_in_copy_get, "user_only" should be false. Is this
> > right?
> >
> > On 23 August 2017 at 15:25, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> >> I submitted an issue for this:
> >> http://tracker.ceph.com/issues/21072?next_issue_id=21071
> >>
> >> On 23 August 2017 at 15:24, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> >>> Hi, everyone.
> >>>
> >>> Recently, we did a test as follows:
> >>>
> >>> We enabled cache tier and added a cache pool "vms_back_cache" on top
> >>> of the base pool "vms_back". we first created an object, and then
> >>> created a snap in the base pool and writing to that object again,
> >>> which would make the object be promoted into the cache pool. At this
> >>> time, we used "ceph-objectstore-tool" to dump the object, and the
> >>> result is as follows:
> >>>
> >>> {
> >>>     "id": {
> >>>         "oid": "test.obj.6",
> >>>         "key": "",
> >>>         "snapid": -2,
> >>>         "hash": 750422257,
> >>>         "max": 0,
> >>>         "pool": 11,
> >>>         "namespace": "",
> >>>         "max": 0
> >>>     },
> >>>     "info": {
> >>>         "oid": {
> >>>             "oid": "test.obj.6",
> >>>             "key": "",
> >>>             "snapid": -2,
> >>>             "hash": 750422257,
> >>>             "max": 0,
> >>>             "pool": 11,
> >>>             "namespace": ""
> >>>         },
> >>>         "version": "5010'5",
> >>>         "prior_version": "4991'3",
> >>>         "last_reqid": "client.175338.0:1",
> >>>         "user_version": 5,
> >>>         "size": 4194303,
> >>>         "mtime": "2017-08-23 15:09:03.459892",
> >>>         "local_mtime": "2017-08-23 15:09:03.461111",
> >>>         "lost": 0,
> >>>         "flags": 4,
> >>>         "snaps": [],
> >>>         "truncate_seq": 0,
> >>>         "truncate_size": 0,
> >>>         "data_digest": 4294967295,
> >>>         "omap_digest": 4294967295,
> >>>         "watchers": {}
> >>>     },
> >>>     "stat": {
> >>>         "size": 4194303,
> >>>         "blksize": 4096,
> >>>         "blocks": 8200,
> >>>         "nlink": 1
> >>>     },
> >>>     "SnapSet": {
> >>>         "snap_context": {
> >>>             "seq": 13,
> >>>             "snaps": [
> >>>                 13
> >>>             ]
> >>>         },
> >>>         "head_exists": 1,
> >>>         "clones": [
> >>>             {
> >>>                 "snap": 13,
> >>>                 "size": 4194303,
> >>>                 "overlap": "[0~100,115~4194188]"
> >>>             }
> >>>         ]
> >>>     }
> >>> }
> >>>
> >>> Then we did cache-flush and cache-evict to flush that object down to
> >>> the base pool, and, again, used "ceph-objectstore-tool" to dump the
> >>> object in the base pool:
> >>>
> >>> {
> >>>     "id": {
> >>>         "oid": "test.obj.6",
> >>>         "key": "",
> >>>         "snapid": -2,
> >>>         "hash": 750422257,
> >>>         "max": 0,
> >>>         "pool": 10,
> >>>         "namespace": "",
> >>>         "max": 0
> >>>     },
> >>>     "info": {
> >>>         "oid": {
> >>>             "oid": "test.obj.6",
> >>>             "key": "",
> >>>             "snapid": -2,
> >>>             "hash": 750422257,
> >>>             "max": 0,
> >>>             "pool": 10,
> >>>             "namespace": ""
> >>>         },
> >>>         "version": "5015'4",
> >>>         "prior_version": "4991'2",
> >>>         "last_reqid": "osd.34.5013:1",
> >>>         "user_version": 5,
> >>>         "size": 4194303,
> >>>         "mtime": "2017-08-23 15:09:03.459892",
> >>>         "local_mtime": "2017-08-23 15:10:48.122138",
> >>>         "lost": 0,
> >>>         "flags": 52,
> >>>         "snaps": [],
> >>>         "truncate_seq": 0,
> >>>         "truncate_size": 0,
> >>>         "data_digest": 163942140,
> >>>         "omap_digest": 4294967295,
> >>>         "watchers": {}
> >>>     },
> >>>     "stat": {
> >>>         "size": 4194303,
> >>>         "blksize": 4096,
> >>>         "blocks": 8200,
> >>>         "nlink": 1
> >>>     },
> >>>     "SnapSet": {
> >>>         "snap_context": {
> >>>             "seq": 13,
> >>>             "snaps": [
> >>>                 13
> >>>             ]
> >>>         },
> >>>         "head_exists": 1,
> >>>         "clones": [
> >>>             {
> >>>                 "snap": 13,
> >>>                 "size": 4194303,
> >>>                 "overlap": "[]"
> >>>             }
> >>>         ]
> >>>     }
> >>> }
> >>>
> >>> As is shown, the "overlap" field is empty.
> >>> In the osd log, we found the following records:
> >>>
> >>> 2017-08-23 12:46:36.083014 7f675c704700 20 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]  got
> >>> attrs
> >>> 2017-08-23 12:46:36.083021 7f675c704700 15
> >>> filestore(/home/xuxuehan/github-xxh-fork/ceph/src/dev/osd0) read
> >>> 3.3_head/#3:dd4db749:test-rados-api-xxh02v.ops.corp.qihoo.net-10886-3::foo:head#
> >>> 0~8
> >>> 2017-08-23 12:46:36.083398 7f675c704700 10
> >>> filestore(/home/xuxuehan/github-xxh-fork/ceph/src/dev/osd0)
> >>> FileStore::read
> >>> 3.3_head/#3:dd4db749:test-rados-api-xxh02v.ops.corp.qihoo.net-10886-3::foo:head#
> >>> 0~8/8
> >>> 2017-08-23 12:46:36.083414 7f675c704700 20 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]  got
> >>> data
> >>> 2017-08-23 12:46:36.083444 7f675c704700 20 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]
> >>> cursor.is_complete=0 0 attrs 8 bytes 0 omap header bytes 0 omap data
> >>> bytes in 0 keys 0 reqids
> >>> 2017-08-23 12:46:36.083457 7f675c704700 10 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]
> >>> dropping ondisk_read_lock
> >>> 2017-08-23 12:46:36.083467 7f675c704700 15 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]
> >>> do_osd_op_effects osd.0 con 0x7f67874f0d00
> >>> 2017-08-23 12:46:36.083478 7f675c704700 15 osd.0 pg_epoch: 19 pg[3.3(
> >>> v 15'2 (0'0,15'2] local-les=15 n=2 ec=14 les/c/f 15/15/0 14/14/14)
> >>> [0,2,1] r=0 lpr=14 crt=0'0 lcod 15'1 mlcod 15'1 active+clean]
> >>> log_op_stats osd_op(osd.0.6:2 3.92edb2bb
> >>> test-rados-api-xxh02v.ops.corp
> >>>
> >>> It seems that, when doing "copy-get", no extensive attributes are
> >>> copied. We believe that it's the following code that led to this
> >>> result:
> >>>
> >>> int ReplicatedPG::getattrs_maybe_cache(ObjectContextRef obc,
> >>>         map<string, bufferlist> *out,
> >>>         bool user_only) {
> >>>     int r = 0;
> >>>     if (pool.info.require_rollback()) {
> >>>         if (out)
> >>>             *out = obc->attr_cache;
> >>>     } else {
> >>>         r = pgbackend->objects_get_attrs(obc->obs.oi.soid, out);
> >>>     }
> >>>     if (out && user_only) {
> >>>         map<string, bufferlist> tmp;
> >>>         for (map<string, bufferlist>::iterator i = out->begin();
> >>>                 i != out->end(); ++i) {
> >>>             if (i->first.size() > 1 && i->first[0] == '_')
> >>>                 tmp[i->first.substr(1, i->first.size())].claim(i->second);
> >>>         }
> >>>         tmp.swap(*out);
> >>>     }
> >>>     return r;
> >>> }
> >>>
> >>> It seems that when "user_only" is true, extensive attributes without a
> >>> '_' as the starting character in its name would be filtered out. Is it
> >>> supposed to be doing things in this way?
> >>> And we found that there are only two places in the source code that
> >>> invoked ReplicatedPG::getattrs_maybe_cache, in both of which
> >>> "user_only" is true. Why add this parameter?
> >>>
> >>> By the way, we also found that these codes are added in commit
> >>> 78d9c0072bfde30917aea4820a811d7fc9f10522, but we don't understand the
> >>> purpose of it.
> >>>
> >>> Thank you:-)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
