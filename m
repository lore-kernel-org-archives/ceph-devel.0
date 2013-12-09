From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/3] libceph: block I/O when PAUSE or FULL osd map flags
 are set
Date: Mon, 09 Dec 2013 15:52:41 -0800
Message-ID: <52A657C9.2040601@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com> <1386112373-25610-2-git-send-email-josh.durgin@inktank.com> <52A28FBA.7080901@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:46065 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab3LIXwo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 18:52:44 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so3374542yhz.27
        for <ceph-devel@vger.kernel.org>; Mon, 09 Dec 2013 15:52:43 -0800 (PST)
In-Reply-To: <52A28FBA.7080901@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>, ceph-devel@vger.kernel.org

On 12/06/2013 07:02 PM, Li Wang wrote:
> I just had a quick look, did not think it thoroughly.
> (1) If possible, there is a race condition, that a former write get
> blocked by FULL, a latter write is lucky to be sent to osd after FULL ->
> NOFULL,
> then the former write is resent, to cause the old data overwrite the new
> data.

The first osdmap that contains the FULL -> NOFULL transition will queue
all paused writes to be resent in their original order (by osd_client
tid). This happens before any further writes are possible since
osdc->map_sem is locked exclusively, preventing the race.

> (2) If it keeps FULL, how long gotta the write request waiting? The
> upper fs writepage/writepages() kernel thread or sync process gotta hang
> there.

There is no upper bound on the wait. This is a conservative approach
to prevent any EIOs causing fs corruption for fses on top of rbd.
Thin-provisioned lvm devices behave this way as well, blocking when
they run out of space until more space is available. Do you have an
idea for avoiding this?

> On 2013/12/4 7:12, Josh Durgin wrote:
>> The PAUSEWR and PAUSERD flags are meant to stop the cluster from
>> processing writes and reads, respectively. The FULL flag is set when
>> the cluster determines that it is out of space, and will no longer
>> process writes.  PAUSEWR and PAUSERD are purely client-side settings
>> already implemented in userspace clients. The osd does nothing special
>> with these flags.
>>
>> When the FULL flag is set, however, the osd responds to all writes
>> with -ENOSPC. For cephfs, this makes sense, but for rbd the block
>> layer translates this into EIO.  If a cluster goes from full to
>> non-full quickly, a filesystem on top of rbd will not behave well,
>> since some writes succeed while others get EIO.
>>
>> Fix this by blocking any writes when the FULL flag is set in the osd
>> client. This is the same strategy used by userspace, so apply it by
>> default.  A follow-on patch makes this configurable.
>>
>> __map_request() is called to re-target osd requests in case the
>> available osds changed.  Add a paused field to a ceph_osd_request, and
>> set it whenever an appropriate osd map flag is set.  Avoid queueing
>> paused requests in __map_request(), but force them to be resent if
>> they become unpaused.
>>
>> Also subscribe to the next osd map from the monitor if any of these
>> flags are set, so paused requests can be unblocked as soon as
>> possible.
>>
>> Fixes: http://tracker.ceph.com/issues/6079
>>
>> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
>> ---
>>   include/linux/ceph/osd_client.h |    1 +
>>   net/ceph/osd_client.c           |   29 +++++++++++++++++++++++++++--
>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/ceph/osd_client.h
>> b/include/linux/ceph/osd_client.h
>> index 8f47625..4fb6a89 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -138,6 +138,7 @@ struct ceph_osd_request {
>>       __le64           *r_request_pool;
>>       void             *r_request_pgid;
>>       __le32           *r_request_attempts;
>> +    bool              r_paused;
>>       struct ceph_eversion *r_request_reassert_version;
>>
>>       int               r_result;
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 2b4b32a..21476be 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1232,6 +1232,22 @@ void ceph_osdc_set_request_linger(struct
>> ceph_osd_client *osdc,
>>   EXPORT_SYMBOL(ceph_osdc_set_request_linger);
>>
>>   /*
>> + * Returns whether a request should be blocked from being sent
>> + * based on the current osdmap and osd_client settings.
>> + *
>> + * Caller should hold map_sem for read.
>> + */
>> +static bool __req_should_be_paused(struct ceph_osd_client *osdc,
>> +                   struct ceph_osd_request *req)
>> +{
>> +    bool pauserd = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSERD);
>> +    bool pausewr = ceph_osdmap_flag(osdc->osdmap,
>> CEPH_OSDMAP_PAUSEWR) ||
>> +        ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL);
>> +    return (req->r_flags & CEPH_OSD_FLAG_READ && pauserd) ||
>> +        (req->r_flags & CEPH_OSD_FLAG_WRITE && pausewr);
>> +}
>> +
>> +/*
>>    * Pick an osd (the first 'up' osd in the pg), allocate the osd struct
>>    * (as needed), and set the request r_osd appropriately.  If there is
>>    * no up osd, set r_osd to NULL.  Move the request to the
>> appropriate list
>> @@ -1248,6 +1264,7 @@ static int __map_request(struct ceph_osd_client
>> *osdc,
>>       int acting[CEPH_PG_MAX_SIZE];
>>       int o = -1, num = 0;
>>       int err;
>> +    bool was_paused;
>>
>>       dout("map_request %p tid %lld\n", req, req->r_tid);
>>       err = ceph_calc_ceph_pg(&pgid, req->r_oid, osdc->osdmap,
>> @@ -1264,12 +1281,18 @@ static int __map_request(struct
>> ceph_osd_client *osdc,
>>           num = err;
>>       }
>>
>> +    was_paused = req->r_paused;
>> +    req->r_paused = __req_should_be_paused(osdc, req);
>> +    if (was_paused && !req->r_paused)
>> +        force_resend = 1;
>> +
>>       if ((!force_resend &&
>>            req->r_osd && req->r_osd->o_osd == o &&
>>            req->r_sent >= req->r_osd->o_incarnation &&
>>            req->r_num_pg_osds == num &&
>>            memcmp(req->r_pg_osds, acting, sizeof(acting[0])*num) == 0) ||
>> -        (req->r_osd == NULL && o == -1))
>> +        (req->r_osd == NULL && o == -1) ||
>> +        req->r_paused)
>>           return 0;  /* no change */
>>
>>       dout("map_request tid %llu pgid %lld.%x osd%d (was osd%d)\n",
>> @@ -1804,7 +1827,9 @@ done:
>>        * we find out when we are no longer full and stop returning
>>        * ENOSPC.
>>        */
>> -    if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
>> +    if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL) ||
>> +        ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSERD) ||
>> +        ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSEWR))
>>           ceph_monc_request_next_osdmap(&osdc->client->monc);
>>
>>       mutex_lock(&osdc->request_mutex);
>>

