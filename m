From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for watch/notify2
Date: Wed, 17 Jun 2015 16:41:02 +0300
Message-ID: <CAOi1vP_gS-0smEFYzZRggQ0msPVUkgjou-HqM=kG8UL57qdkfg@mail.gmail.com>
References: <cover.1434124007.git.dfuller@redhat.com>
	<1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com>
	<5580AEC9.9020908@redhat.com>
	<16ACAFCB-0E28-4762-BDF9-E68B7FE5D817@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36739 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbbFQNlD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 09:41:03 -0400
Received: by wgzl5 with SMTP id l5so37430258wgz.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 06:41:02 -0700 (PDT)
In-Reply-To: <16ACAFCB-0E28-4762-BDF9-E68B7FE5D817@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 17, 2015 at 4:28 PM, Douglas Fuller <dfuller@redhat.com> wr=
ote:
>
>> On Jun 16, 2015, at 7:18 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>>
>> On 06/12/2015 08:56 AM, Douglas Fuller wrote:
>>>
>>> @@ -3132,6 +3132,26 @@ static void rbd_watch_cb(u64 ver, u64 notify=
_id, u8 opcode, s32 return_code,
>>>              rbd_warn(rbd_dev, "notify_ack ret %d", ret);
>>>  }
>>>
>>> +static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
>>> +{
>>> +    struct rbd_device *rbd_dev =3D (struct rbd_device *)arg;
>>> +    int ret;
>>> +
>>> +    dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_na=
me,
>>> +            err, cookie);
>>> +    rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
>>> +             rbd_dev->header_name, err, cookie);
>>> +
>>> +    /* reset watch */
>>> +    rbd_dev_refresh(rbd_dev);
>>> +    rbd_dev_header_unwatch_sync(rbd_dev);
>>> +    ret =3D rbd_dev_header_watch_sync(rbd_dev);
>>> +    BUG_ON(ret); /* XXX: was the image deleted? can we be more gra=
ceful? */
>>> +    rbd_dev_refresh(rbd_dev);
>>
>> Why refresh before and after unwatching? Only the second one seems
>> necessary.
>
> The first one isn=E2=80=99t strictly necessary; I can remove it if yo=
u want.
>
> If we get a watch error, we may very well have a situation in which w=
e need to stop I/O to the device because the underlying image has been =
deleted or its features have changed. We don=E2=80=99t actually do that=
 yet (we just print a warning message), but the extra refresh was to ha=
ndle that case early, even before we bothered trying to re-establish th=
e watch.--

We should remove it, for consistency if nothing else.  Also, when you
are mapping image, it's rbd_dev_header_watch_sync() that fails if the
header object doesn't exist and such.  So I'd rather it failing in the
same place if an image got deleted from under a client or something
else went wrong instead of keeping in mind that it's the get_size (or
whatever) method that is called first on refresh and expect failures
there.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
