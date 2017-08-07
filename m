From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: About the problem "export_diff relies on clone_overlap, which is
 lost when cache tier is enabled"
Date: Mon, 7 Aug 2017 16:48:51 -0400
Message-ID: <CA+aFP1BG4LQCN7trZ-Z_boiGtLHZ44_Xf9D+Au0Qq1nC=seHkg@mail.gmail.com>
References: <CAJACTuf6q0r0xk6jzohj94cUDRUKKuweTPv021829M-UZZWTHg@mail.gmail.com>
 <CAJACTud-qK7WDZnUGfPKP1iTPoStbDGUG28zQ0ftBTBsqQZghA@mail.gmail.com> <CAJACTuf3M9tMXROo6waH-_VLFpfhBibEOFM31wUbdfUZDtqh0A@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36399 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGUsw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 16:48:52 -0400
Received: by mail-yw0-f170.google.com with SMTP id u207so9959834ywc.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Aug 2017 13:48:52 -0700 (PDT)
In-Reply-To: <CAJACTuf3M9tMXROo6waH-_VLFpfhBibEOFM31wUbdfUZDtqh0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Could you just proxy the "list snaps" op from the cache tier down to
the base tier and combine the cache tier + base tier results? Reading
the associated ticket, it seems kludgy to me to attempt to work around
this within librbd by just refusing the provide intra-object diffs if
cache tiering is in-use.

On Sat, Aug 5, 2017 at 11:56 AM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everyone.
>
> Trying to solve the issue "http://tracker.ceph.com/issues/20896", I
> just did another test: I did some writes to an object
> "rbd_data.1ebc6238e1f29.0000000000000000" to raise its "HEAD" object
> to the cache tier, after which I specifically write to its offset 0x40
> with 4 bytes of random data. Then I used "ceph-objectstore-tool" to
> dump its "HEAD" version in the base tier, the result is as
> follows(before I raise it to cache tier, there is three snaps the
> latest of which is 26):
>
> {
>     "id": {
>         "oid": "rbd_data.1ebc6238e1f29.0000000000000000",
>         "key": "",
>         "snapid": -2,
>         "hash": 1655893237,
>         "max": 0,
>         "pool": 3,
>         "namespace": "",
>         "max": 0
>     },
>     "info": {
>         "oid": {
>             "oid": "rbd_data.1ebc6238e1f29.0000000000000000",
>             "key": "",
>             "snapid": -2,
>             "hash": 1655893237,
>             "max": 0,
>             "pool": 3,
>             "namespace": ""
>         },
>         "version": "4219'16423",
>         "prior_version": "3978'16310",
>         "last_reqid": "osd.70.4213:2359",
>         "user_version": 17205,
>         "size": 4194304,
>         "mtime": "2017-08-03 22:07:34.656122",
>         "local_mtime": "2017-08-05 23:02:33.628734",
>         "lost": 0,
>         "flags": 52,
>         "snaps": [],
>         "truncate_seq": 0,
>         "truncate_size": 0,
>         "data_digest": 2822203961,
>         "omap_digest": 4294967295,
>         "watchers": {}
>     },
>     "stat": {
>         "size": 4194304,
>         "blksize": 4096,
>         "blocks": 8200,
>         "nlink": 1
>     },
>     "SnapSet": {
>         "snap_context": {
>             "seq": 26,
>             "snaps": [
>                 26,
>                 25,
>                 16
>             ]
>         },
>         "head_exists": 1,
>         "clones": [
>             {
>                 "snap": 16,
>                 "size": 4194304,
>                 "overlap": "[4~4194300]"
>             },
>             {
>                 "snap": 25,
>                 "size": 4194304,
>                 "overlap": "[]"
>             },
>             {
>                 "snap": 26,
>                 "size": 4194304,
>                 "overlap": "[]"
>             }
>         ]
>     }
> }
>
> As we can see, its clone_overlap for snap 26 is empty, which,
> combining with the previous test described in
> http://tracker.ceph.com/issues/20896, means that the writes' "modified
> range" is neither recorded in the cache tier nor in the base tier.
>
> I think maybe we really should move the clone overlap modification out
> of the IF block which has the condition check "is_present_clone". As
> for now, I can't see any other way to fix this problem.
>
> Am I right about this?
>
> On 4 August 2017 at 03:14, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> I mean I think it's the condition check "is_present_clone" that
>> prevent the clone overlap to record the client write operations
>> modified range when the target "HEAD" object exists without its most
>> recent clone object, and if I'm right, just move the clone overlap
>> modification out of the "is_present_clone" condition check block is
>> enough to solve this case, just like the PR
>> "https://github.com/ceph/ceph/pull/16790", and this fix wouldn't cause
>> other problems.
>>
>> In our test, this fix solved the problem successfully, however, we
>> can't confirm it won't cause new problems yet.
>>
>> So if anyone see this and knows the answer, please help us. Thank you:-)
>>
>> On 4 August 2017 at 11:41, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>> Hi, grep:-)
>>>
>>> I finally got what you mean in https://github.com/ceph/ceph/pull/16790.
>>>
>>> I agree with you in that " clone overlap is supposed to be tracking
>>> which data is the same on disk".
>>>
>>> My thought is that, "ObjectContext::new_snapset.clones" is already an
>>> indicator about whether there are clone objects on disk, so, in the
>>> scenario of "cache tier", although a clone oid does not corresponds to
>>> a "present clone" in cache tier, as long as
>>> "ObjectContext::new_snapset.clones" is not empty, there must a one
>>> such clone object in the base tier. And, as long as
>>> "ObjectContext::new_snapset.clones" has a strict "one-to-one"
>>> correspondence to "ObjectContext::new_snapset.clone_overlap", passing
>>> the condition check "if (ctx->new_snapset.clones.size() > 0)" is
>>> enough to make the judgement that the clone object exists.
>>>
>>> So, if I'm right, passing the condition check "if
>>> (ctx->new_snapset.clones.size() > 0)" is already enough for us to do
>>> "newest_overlap.subtract(ctx->modified_ranges)", it doesn't have to
>>> pass "is_present_clone".
>>>
>>> Am I right about this? Or am I missing anything?
>>>
>>> Please help us, thank you:-)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
