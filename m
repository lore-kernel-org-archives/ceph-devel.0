From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 4/4] rbd: use a single value of snap_name to mean no snap
Date: Tue, 28 Feb 2012 21:35:13 -0800
Message-ID: <4F4DB911.9060506@dreamhost.com>
References: <4F4D9BF6.5070102@dreamhost.com> <4F4D9CF1.1020101@dreamhost.com> <CAC-hyiGGAnKM92YyfUsbW17pW4a2_E0gO5Z_x5B+fNqZjDWtgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55657 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2B2FfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 00:35:14 -0500
In-Reply-To: <CAC-hyiGGAnKM92YyfUsbW17pW4a2_E0gO5Z_x5B+fNqZjDWtgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/28/2012 08:53 PM, Yehuda Sadeh Weinraub wrote:
> On Tue, Feb 28, 2012 at 7:35 PM, Alex Elder<elder@dreamhost.com>  wrote:
>>  From Josh Durgin<josh.durgin@dreamhost.com>
>>
>> There's already a constant for this anyway.
>>
>> (I changed Josh's code to use memcmp() and memcpy() instead. -Alex)
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>
>> ---
>>   drivers/block/rbd.c |    8 +++-----
>>   1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 3d0f8cf..25ed3c0 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -563,10 +563,7 @@ static int rbd_header_set_snap(struct rbd_device *dev,
>>
>>         down_write(&header->snap_rwsem);
>>
>> -       if (!snap_name ||
>> -           !*snap_name ||
>> -           strcmp(snap_name, "-") == 0 ||
>> -           strcmp(snap_name, RBD_SNAP_HEAD_NAME) == 0) {
>> +       if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME, sizeof
>
> The original code checked for snap_name, we don't do it here. Also, do
> we know that snap_name is pointing to at least
> sizeof(RBD_SNAP_HEAD_NAME)? if not (or in any case) we should use
> strcmp instead of memcmp. Also, sizeof(x) instead of sizeof x.

This function is only called in one place, within this file.
That place passes rbd_dev->snap_name as the "snap_name" argument.
rbd_dev->snap_name is an array.  So if rbd_dev is a valid structure,
rbd_dev->snap_name will not be a null pointer.

The size of that string is RBD_MAX_SNAP_NAME_LEN.  It would be
an error for sizeof(RBD_SNAP_HEAD_NAME) to exceed that length,
but I could add a check for that.  (Checking at build time would
be best but sizeof() is not available then.)

I'll put in a BUG_ON() or something, or will see if I can put in
some other kind of check.

					-Alex

>
>> RBD_SNAP_HEAD_NAME)) {
>>                 if (header->total_snaps)
>>                         snapc->seq = header->snap_seq;
>>                 else
>> @@ -2213,7 +2210,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>>         }
>>
>>         if (rbd_dev->snap_name[0] == 0)
>> -               rbd_dev->snap_name[0] = '-';
>> +               memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>> +                       sizeof RBD_SNAP_HEAD_NAME);
>>
>>         rbd_dev->obj_len = strlen(rbd_dev->obj);
>>         snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_name), "%s%s",
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

