From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: [rgw multisite] disable specified bucket data sync
Date: Mon, 15 Aug 2016 21:56:00 -0700
Message-ID: <CADRKj5RC9N1rWzVxk--v4OpQipZb0Y+nV20b6fuhS+tVU=e6NA@mail.gmail.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314C2FD8@H3CMLB12-EX.srv.huawei-3com.com>
 <0bf06e63-8d0c-ec3b-9af7-02454e7af35b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36855 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcHPE4C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 00:56:02 -0400
Received: by mail-ua0-f170.google.com with SMTP id 97so104290586uav.3
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 21:56:02 -0700 (PDT)
In-Reply-To: <0bf06e63-8d0c-ec3b-9af7-02454e7af35b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Zhangzengran <zhangzengran@h3c.com>, "idealguo@139.com" <idealguo@139.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Aug 15, 2016 at 1:48 PM, Casey Bodley <cbodley@redhat.com> wrote:
> The ability to disable sync per-bucket could certainly be added, but it
> would take some work to get right.
>
> First you'd need a radosgw-admin command to enable/disable sync on a given
> bucket, and store that flag with the bucket instance. We read the bucket
> instance before starting sync on each bucket, so you could skip the sync
> depending on that flag.

That would be the bucket info (that corresponds to a specific bucket instance).

>
> However, each zone is trying to sync data from all other zones in its
> zonegroup. So disabling it on zone A, for example, will only prevent zone A
> from pulling changes from other zones. The other zones would still be
> pulling changes from zone A, because they have their own copy of the bucket
> instance. So you'd probably want some way to coordinate this setting between

Not quite. The bucket info is a metadata entity, so it's being
modified on the master and synced to all other zones. Similar to other
bucket metadata changes, we can have the zone where the change is
requested on forward the request to the master.

> zones.
>
> The other challenge would be in the interaction with the 'data changes log'.
> Each zone maintains a log of bucket names that have local changes (you can
> view this with 'radosgw-admin datalog list'). Other zones read from this log
> to decide which buckets they need to sync. However, say that zone A reads
> about a change to bucket1 on zone B. If sync on bucket1 is disabled, zone A
> skips the sync and advances its position in zone B's datalog. So if sync on
> bucket1 is later enabled, zone A won't remember that it needs to sync from
> B.

Yeah, need to add entry to the data log whenever we enable (not sure
about disable) sync on a bucket.

>
> So I think the trick would be to add special entries to the datalog when
> buckets are enabled/disabled, so that other zones will know to a) update
> their local bucket instance, and b) restart sync if enabled. We might also
> want to restrict the radosgw-admin command to the zonegroup's master zone so
> we can avoid races between enable/disable from different zones.

We should do it the same way we do other bucket metadata changes,
potentially just reuse that code path.

>

One thing that I would do differently is that instead of having a
single flag on the bucket info to specify whether a bucket is getting
synced or not, I'd have a more detailed mapping of different zone
relationships. For each zone it'd specify which zones it's syncing
this bucket from. By default the map will be empty, and there will be
another flag that will override it that will just mean 'sync from all'
(default as true). This is pretty much in line with some changes that
I'm planning for the zones themselves, so having a per-bucket sync
config makes sense. It'll also be a step towards implementing the
swift container sync api.

Yehuda

> Casey
>
>
>
> On 08/02/2016 09:16 PM, Zhangzengran wrote:
>>>>
>>>> Hi Casey:
>>>>           Why don’t support stopping specified bucket data sync. Is
>>>> there any difficulty in implementing the feature?
>>>>           Or am I missing something?
>>>>
>>>>           Thank you !
>>>
>>>
>>> Hi,
>>>
>>> What would you like to get out of this feature? A way to disable sync on
>>> a given bucket temporarily, and turn it back on later? Or just a way to have
>>> a subset of buckets that don't ever participate in sync?
>>>
>>> Do you have a use case for the first? That's not something we'd
>>> considered.
>>>
>>> If you just want to have some buckets that never sync, you might consider
>>> serving those out of a separate gateway, in a zone that isn't part of a
>>> multisite configuration.
>>>
>>> Thanks,
>>> Casey
>>
>> deploy a separate none-sync zone with different endpoint may not a good
>> choice. we hope enable/disable a specified bucket sync could be somewhat
>> flexible. :)
>>
>> -------------------------------------------------------------------------------------------------------------------------------------
>> 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
>> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
>> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
>> 邮件！
>> This e-mail and its attachments contain confidential information from H3C,
>> which is
>> intended only for the person or entity whose address is listed above. Any
>> use of the
>> information contained herein in any way (including, but not limited to,
>> total or partial
>> disclosure, reproduction, or dissemination) by persons other than the
>> intended
>> recipient(s) is prohibited. If you receive this e-mail in error, please
>> notify the sender
>> by phone or email immediately and delete it!
>> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay� ʇڙ�,j ��f���h���z� �w���
>> ���j:+v���w�j�m���� ����zZ+�����ݢj"��!tml=
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
