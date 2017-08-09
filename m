From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Fwd: About the problem "export_diff relies on clone_overlap, which is
 lost when cache tier is enabled"
Date: Wed, 9 Aug 2017 12:20:50 +0800
Message-ID: <CAJACTuf1Wkh9LEw_7MO-0Oka2VoXOEeWe+A5=owVk5tRTuf_2A@mail.gmail.com>
References: <CAJACTuf6q0r0xk6jzohj94cUDRUKKuweTPv021829M-UZZWTHg@mail.gmail.com>
 <CAJACTud-qK7WDZnUGfPKP1iTPoStbDGUG28zQ0ftBTBsqQZghA@mail.gmail.com>
 <CAJACTuf3M9tMXROo6waH-_VLFpfhBibEOFM31wUbdfUZDtqh0A@mail.gmail.com>
 <CA+aFP1BG4LQCN7trZ-Z_boiGtLHZ44_Xf9D+Au0Qq1nC=seHkg@mail.gmail.com>
 <CAJACTucaKm+nZUUkQYszZtjt7K=X1uvdpUucxL+pV1AHrmewEw@mail.gmail.com>
 <CA+aFP1Dki1hw+VGZo9Nm4e=qx2P6-pCcG4PLK3FeDHJ1-pAkGA@mail.gmail.com> <CAJACTudkLVT=dcWo_FpgrVuxJ8smFD2VqLU6x2eVWyggh9UJAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34138 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdHIEUv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 00:20:51 -0400
Received: by mail-oi0-f41.google.com with SMTP id x3so51497115oia.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 21:20:51 -0700 (PDT)
In-Reply-To: <CAJACTudkLVT=dcWo_FpgrVuxJ8smFD2VqLU6x2eVWyggh9UJAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sorry, I didn't "reply all"....:-)


---------- Forwarded message ----------
From: Xuehan Xu <xxhdx1985126@gmail.com>
Date: 9 August 2017 at 12:14
Subject: Re: About the problem "export_diff relies on clone_overlap,
which is lost when cache tier is enabled"
To: dillaman@redhat.com


Um, no, I don't think they are related.

My problem is this:

At first , we tried to use "rbd export-diff" to do incremental backup
on Jewel verion ceph cluster which is cache-tier enabled. However,
when we compare the original rbd image and the backup rbd image, we
find that they are different. After a series of debugging, we found
that this is because WRITE ops' "modified_range" is not substracted
from the clone overlap of its targeting object's HEAD version when
that object's HEAD verion is in cache iter and its most recent clone
object is not, which led to the miscalculation of the
"calc_snap_set_diff" function.

For example, we did such a test: we first made created a snap for an
rbd image "test.2.img" whose size is only 4MB which means it only
contains one object; then, we sent a series of AioWrites to
"test.2.img" to promote its HEAD object into cache tier, while leaving
its clone object in the base tier only; at that time, we used
"ceph-objectstore-tool" to dump the object we wrote to, and the result
was as follows:

{
    "id": {
        "oid": "rbd_data.2aae62ae8944a.0000000000000000",
        "key": "",
        "snapid": -2,
        "hash": 2375431681,
        "max": 0,
        "pool": 4,
        "namespace": "",
        "max": 0
    },
    "info": {
        "oid": {
            "oid": "rbd_data.2aae62ae8944a.0000000000000000",
            "key": "",
            "snapid": -2,
            "hash": 2375431681,
            "max": 0,
            "pool": 4,
            "namespace": ""
        },
        "version": "4536'2728",
        "prior_version": "4536'2727",
        "last_reqid": "client.174858.0:10",
        "user_version": 14706,
        "size": 68,
        "mtime": "2017-08-09 11:30:18.263983",
        "local_mtime": "2017-08-09 11:30:18.264310",
        "lost": 0,
        "flags": 4,
        "snaps": [],
        "truncate_seq": 0,
        "truncate_size": 0,
        "data_digest": 4294967295,
        "omap_digest": 4294967295,
        "watchers": {}
    },
    "stat": {
        "size": 68,
        "blksize": 4096,
        "blocks": 16,
        "nlink": 1
    },
    "SnapSet": {
        "snap_context": {
            "seq": 28,
            "snaps": [
                28
            ]
        },
        "head_exists": 1,
        "clones": [
            {
                "snap": 28,
                "size": 68,
                "overlap": "[0~64]"
            }
        ]
    }
}

In this result, we found that the overlap for clone "28" is [0~64]. So
we specifically sent a AioWrite req to this object to write to the
offset 32 with 4 bytes of ramdon data, which we thought the overlap
should change to [0~32, 36~64]. However, the result is as follows:

{
    "id": {
        "oid": "rbd_data.2aae62ae8944a.0000000000000000",
        "key": "",
        "snapid": -2,
        "hash": 2375431681,
        "max": 0,
        "pool": 4,
        "namespace": "",
        "max": 0
    },
    "info": {
        "oid": {
            "oid": "rbd_data.2aae62ae8944a.0000000000000000",
            "key": "",
            "snapid": -2,
            "hash": 2375431681,
            "max": 0,
            "pool": 4,
            "namespace": ""
        },
        "version": "4546'2730",
        "prior_version": "4538'2729",
        "last_reqid": "client.155555.0:10",
        "user_version": 14708,
        "size": 4096,
        "mtime": "2017-08-09 11:36:20.717910",
        "local_mtime": "2017-08-09 11:36:20.719039",
        "lost": 0,
        "flags": 4,
        "snaps": [],
        "truncate_seq": 0,
        "truncate_size": 0,
        "data_digest": 4294967295,
        "omap_digest": 4294967295,
        "watchers": {}
    },
    "stat": {
        "size": 4096,
        "blksize": 4096,
        "blocks": 16,
        "nlink": 1
    },
    "SnapSet": {
        "snap_context": {
            "seq": 28,
            "snaps": [
                28
            ]
        },
        "head_exists": 1,
        "clones": [
            {
                "snap": 28,
                "size": 68,
                "overlap": "[0~64]"
            }
        ]
    }
}

It's obvious that it didn't change at all. If we do export-diff under
this circumstance, the result would be wrong. Meanwhile, in the base
tier, the "ceph-objectstore-tool" dump's result also showed that the
overlap recorded in the base tier didn't change also:
{
    "id": {
        "oid": "rbd_data.2aae62ae8944a.0000000000000000",
        "key": "",
        "snapid": -2,
        "hash": 2375431681,
        "max": 0,
        "pool": 3,
        "namespace": "",
        "max": 0
    },
    "info": {
        "oid": {
            "oid": "rbd_data.2aae62ae8944a.0000000000000000",
            "key": "",
            "snapid": -2,
            "hash": 2375431681,
            "max": 0,
            "pool": 3,
            "namespace": ""
        },
        "version": "4536'14459",
        "prior_version": "4536'14458",
        "last_reqid": "client.174834.0:10",
        "user_version": 14648,
        "size": 68,
        "mtime": "2017-08-09 11:30:01.412634",
        "local_mtime": "2017-08-09 11:30:01.413614",
        "lost": 0,
        "flags": 36,
        "snaps": [],
        "truncate_seq": 0,
        "truncate_size": 0,
        "data_digest": 4294967295,
        "omap_digest": 4294967295,
        "watchers": {}
    },
    "stat": {
        "size": 68,
        "blksize": 4096,
        "blocks": 16,
        "nlink": 1
    },
    "SnapSet": {
        "snap_context": {
            "seq": 28,
            "snaps": [
                28
            ]
        },
        "head_exists": 1,
        "clones": [
            {
                "snap": 28,
                "size": 68,
                "overlap": "[0~64]"
            }
        ]
    }
}

Then we turn to the source code to find the reason for this. And we
found that, the reason should be that, in the
ReplicatedPG::make_writeable method, when determining whether the
write op's modified range should be subtracted from the clone overlap,
it has pass two condition check: "ctx->new_snapset.clones.size() > 0"
and "is_present_clone(last_clone_oid)", as the code below shows.

  // update most recent clone_overlap and usage stats
  if (ctx->new_snapset.clones.size() > 0) {
    /* we need to check whether the most recent clone exists, if it's
been evicted,
     * it's not included in the stats */
    hobject_t last_clone_oid = soid;
    last_clone_oid.snap = ctx->new_snapset.clone_overlap.rbegin()->first;
    if (is_present_clone(last_clone_oid)) {
      interval_set<uint64_t> &newest_overlap =
ctx->new_snapset.clone_overlap.rbegin()->second;
      ctx->modified_ranges.intersection_of(newest_overlap);
      // modified_ranges is still in use by the clone
      add_interval_usage(ctx->modified_ranges, ctx->delta_stats);
      newest_overlap.subtract(ctx->modified_ranges);
    }
  }

We thought that the latter condition check
"is_present_clone(last_clone_oid)" might not be reasonable to be a
judgement base for the determination of whether to subtract the clone
overlap with write ops' modified range, so we changed to code above to
the following, which moved the subtraction out of the latter condition
check, and submitted a pr for this:
https://github.com/ceph/ceph/pull/16790:

  // update most recent clone_overlap and usage stats
  if (ctx->new_snapset.clones.size() > 0) {
    /* we need to check whether the most recent clone exists, if it's
been evicted,
     * it's not included in the stats */
    hobject_t last_clone_oid = soid;
    last_clone_oid.snap = ctx->new_snapset.clone_overlap.rbegin()->first;
    interval_set<uint64_t> &newest_overlap =
ctx->new_snapset.clone_overlap.rbegin()->second;
    ctx->modified_ranges.intersection_of(newest_overlap);
    newest_overlap.subtract(ctx->modified_ranges);

    if (is_present_clone(last_clone_oid)) {
      // modified_ranges is still in use by the clone
      add_interval_usage(ctx->modified_ranges, ctx->delta_stats);
    }
  }

In our test, this change solved the problem successfully, however, we
can't confirm that this change won't cause any new problems. So, here
we are discussing how to solve this problem:-)

On 9 August 2017 at 09:26, Jason Dillaman <jdillama@redhat.com> wrote:
> Is this issue related to https://github.com/ceph/ceph/pull/10626?
>
> On Mon, Aug 7, 2017 at 8:07 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> OK, I'll try that. Thank you:-)
>>
>> On 8 August 2017 at 04:48, Jason Dillaman <jdillama@redhat.com> wrote:
>>> Could you just proxy the "list snaps" op from the cache tier down to
>>> the base tier and combine the cache tier + base tier results? Reading
>>> the associated ticket, it seems kludgy to me to attempt to work around
>>> this within librbd by just refusing the provide intra-object diffs if
>>> cache tiering is in-use.
>>>
>>> On Sat, Aug 5, 2017 at 11:56 AM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>> Hi, everyone.
>>>>
>>>> Trying to solve the issue "http://tracker.ceph.com/issues/20896", I
>>>> just did another test: I did some writes to an object
>>>> "rbd_data.1ebc6238e1f29.0000000000000000" to raise its "HEAD" object
>>>> to the cache tier, after which I specifically write to its offset 0x40
>>>> with 4 bytes of random data. Then I used "ceph-objectstore-tool" to
>>>> dump its "HEAD" version in the base tier, the result is as
>>>> follows(before I raise it to cache tier, there is three snaps the
>>>> latest of which is 26):
>>>>
>>>> {
>>>>     "id": {
>>>>         "oid": "rbd_data.1ebc6238e1f29.0000000000000000",
>>>>         "key": "",
>>>>         "snapid": -2,
>>>>         "hash": 1655893237,
>>>>         "max": 0,
>>>>         "pool": 3,
>>>>         "namespace": "",
>>>>         "max": 0
>>>>     },
>>>>     "info": {
>>>>         "oid": {
>>>>             "oid": "rbd_data.1ebc6238e1f29.0000000000000000",
>>>>             "key": "",
>>>>             "snapid": -2,
>>>>             "hash": 1655893237,
>>>>             "max": 0,
>>>>             "pool": 3,
>>>>             "namespace": ""
>>>>         },
>>>>         "version": "4219'16423",
>>>>         "prior_version": "3978'16310",
>>>>         "last_reqid": "osd.70.4213:2359",
>>>>         "user_version": 17205,
>>>>         "size": 4194304,
>>>>         "mtime": "2017-08-03 22:07:34.656122",
>>>>         "local_mtime": "2017-08-05 23:02:33.628734",
>>>>         "lost": 0,
>>>>         "flags": 52,
>>>>         "snaps": [],
>>>>         "truncate_seq": 0,
>>>>         "truncate_size": 0,
>>>>         "data_digest": 2822203961,
>>>>         "omap_digest": 4294967295,
>>>>         "watchers": {}
>>>>     },
>>>>     "stat": {
>>>>         "size": 4194304,
>>>>         "blksize": 4096,
>>>>         "blocks": 8200,
>>>>         "nlink": 1
>>>>     },
>>>>     "SnapSet": {
>>>>         "snap_context": {
>>>>             "seq": 26,
>>>>             "snaps": [
>>>>                 26,
>>>>                 25,
>>>>                 16
>>>>             ]
>>>>         },
>>>>         "head_exists": 1,
>>>>         "clones": [
>>>>             {
>>>>                 "snap": 16,
>>>>                 "size": 4194304,
>>>>                 "overlap": "[4~4194300]"
>>>>             },
>>>>             {
>>>>                 "snap": 25,
>>>>                 "size": 4194304,
>>>>                 "overlap": "[]"
>>>>             },
>>>>             {
>>>>                 "snap": 26,
>>>>                 "size": 4194304,
>>>>                 "overlap": "[]"
>>>>             }
>>>>         ]
>>>>     }
>>>> }
>>>>
>>>> As we can see, its clone_overlap for snap 26 is empty, which,
>>>> combining with the previous test described in
>>>> http://tracker.ceph.com/issues/20896, means that the writes' "modified
>>>> range" is neither recorded in the cache tier nor in the base tier.
>>>>
>>>> I think maybe we really should move the clone overlap modification out
>>>> of the IF block which has the condition check "is_present_clone". As
>>>> for now, I can't see any other way to fix this problem.
>>>>
>>>> Am I right about this?
>>>>
>>>> On 4 August 2017 at 03:14, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>>> I mean I think it's the condition check "is_present_clone" that
>>>>> prevent the clone overlap to record the client write operations
>>>>> modified range when the target "HEAD" object exists without its most
>>>>> recent clone object, and if I'm right, just move the clone overlap
>>>>> modification out of the "is_present_clone" condition check block is
>>>>> enough to solve this case, just like the PR
>>>>> "https://github.com/ceph/ceph/pull/16790", and this fix wouldn't cause
>>>>> other problems.
>>>>>
>>>>> In our test, this fix solved the problem successfully, however, we
>>>>> can't confirm it won't cause new problems yet.
>>>>>
>>>>> So if anyone see this and knows the answer, please help us. Thank you:-)
>>>>>
>>>>> On 4 August 2017 at 11:41, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>>>> Hi, grep:-)
>>>>>>
>>>>>> I finally got what you mean in https://github.com/ceph/ceph/pull/16790.
>>>>>>
>>>>>> I agree with you in that " clone overlap is supposed to be tracking
>>>>>> which data is the same on disk".
>>>>>>
>>>>>> My thought is that, "ObjectContext::new_snapset.clones" is already an
>>>>>> indicator about whether there are clone objects on disk, so, in the
>>>>>> scenario of "cache tier", although a clone oid does not corresponds to
>>>>>> a "present clone" in cache tier, as long as
>>>>>> "ObjectContext::new_snapset.clones" is not empty, there must a one
>>>>>> such clone object in the base tier. And, as long as
>>>>>> "ObjectContext::new_snapset.clones" has a strict "one-to-one"
>>>>>> correspondence to "ObjectContext::new_snapset.clone_overlap", passing
>>>>>> the condition check "if (ctx->new_snapset.clones.size() > 0)" is
>>>>>> enough to make the judgement that the clone object exists.
>>>>>>
>>>>>> So, if I'm right, passing the condition check "if
>>>>>> (ctx->new_snapset.clones.size() > 0)" is already enough for us to do
>>>>>> "newest_overlap.subtract(ctx->modified_ranges)", it doesn't have to
>>>>>> pass "is_present_clone".
>>>>>>
>>>>>> Am I right about this? Or am I missing anything?
>>>>>>
>>>>>> Please help us, thank you:-)
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Jason
>
>
>
> --
> Jason
