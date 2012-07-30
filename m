From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: kill rbd_init_watch_dev()
Date: Mon, 30 Jul 2012 17:48:42 -0500
Message-ID: <50170F4A.8030505@inktank.com>
References: <50119656.9080709@inktank.com> <501700B1.8030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36228 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2G3Wsm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 18:48:42 -0400
Received: by yenl2 with SMTP id l2so5448394yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 15:48:42 -0700 (PDT)
In-Reply-To: <501700B1.8030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 04:46 PM, Josh Durgin wrote:
> On 07/26/2012 12:11 PM, Alex Elder wrote:
>> When an rbd image is mapped, a watch request is issued so that the
>> client will get notified in the event the image header object
>> changes.  This is done using rbd_init_watch_dev(), which calls
>> rbd_req_sync_watch().
>>
>> rbd_init_watch_dev() is organized as a loop, arranging to re-issue
>> the request after refreshing the header if -ERANGE ever gets
>> returned.  But the only way rbd_req_sync_watch() will return -ERANGE
>> is if the CEPH_OSD_OP_WATCH operation returns that, which it will
>> not.
>>
>> As a result, the whole looping structure and in fact the whole
>> function becomes excessive.  So get rid of rbd_init_watch_dev(),
>> and call rbd_req_sync_watch() directly in the one place it's used.
> 
> Instead of getting rid of this loop, we should make it
> send a compound operation consisting of (CEPH_OSD_OP_ASSERT_VER,
> CEPH_OSD_OP_WATCH). Then we will get -ERANGE if our version
> of the header is out of data, so we don't lose header updates
> before the watch is established.

I don't have compound operations going yet, but now I see why it
may have been written this way.  So I'll drop this patch, and
will make a note to re-visit this spot later.

					-Alex

> Josh
> 
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   18 +-----------------
>>   1 file changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 94d0745..71e3f3b 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -2191,22 +2191,6 @@ static void rbd_bus_del_dev(struct rbd_device
>> *rbd_dev)
>>       device_unregister(&rbd_dev->dev);
>>   }
>>
>> -static int rbd_init_watch_dev(struct rbd_device *rbd_dev)
>> -{
>> -    int ret, rc;
>> -
>> -    do {
>> -        ret = rbd_req_sync_watch(rbd_dev);
>> -        if (ret == -ERANGE) {
>> -            rc = rbd_refresh_header(rbd_dev, NULL);
>> -            if (rc < 0)
>> -                return rc;
>> -        }
>> -    } while (ret == -ERANGE);
>> -
>> -    return ret;
>> -}
>> -
>>   static atomic64_t rbd_id_max = ATOMIC64_INIT(0);
>>
>>   /*
>> @@ -2510,7 +2494,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>>       if (rc)
>>           goto err_out_bus;
>>
>> -    rc = rbd_init_watch_dev(rbd_dev);
>> +    rc = rbd_req_sync_watch(rbd_dev);
>>       if (rc)
>>           goto err_out_bus;
>>
> 
> 
> 

