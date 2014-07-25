From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 7/8] rbd: do not read in parent info before snap context
Date: Fri, 25 Jul 2014 12:36:32 +0400
Message-ID: <CALFYKtAzJZktOMBRHqfCF4mbqMgwF07JpuAsxOHFYEoWABeSsQ@mail.gmail.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
	<1406191369-6746-8-git-send-email-ilya.dryomov@inktank.com>
	<53D211F4.7060006@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34197 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759735AbaGYIge (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 04:36:34 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so4241049qac.33
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 01:36:32 -0700 (PDT)
In-Reply-To: <53D211F4.7060006@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 25, 2014 at 12:14 PM, Alex Elder <elder@ieee.org> wrote:
> On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
>> Currently rbd_dev_v2_header_info() reads in parent info before the snap
>> context is read in.  This is wrong, because we may need to look at the
>> the parent_overlap value of the snapshot instead of that of the base
>
> I had some trouble understanding this.
>
> The parent image, snapshot id and overlap, are together a property
> of a particular image (and associated with its header object).
> Nothing about that is dependent on the child image snapshots
> or snapshot id.
>
> However...
>
>> image, for example when mapping a snapshot - see next commit.  (When
>> mapping a snapshot, all we got is its name and we need the snap context
>> to translate that name into an id to know which parent info to look
>> for).
>
> I finally figured out what path through the code you
> were talking about.  Here's what I see.
>
> On the initial probe (previously), we have:
>   rbd_add()
>     do_rbd_add()
>       rbd_dev_image_probe()
>        |rbd_dev_header_info()
>        | |rbd_dev_v2_header_info()
>        | | |rbd_dev_v2_parent_info()
>        | | | --> expects rbd_dev->spec->snap_id to be valid
>        | | |rbd_dev_v2_snap_context()
>        | | | --> this fills in the snapshot context
>        |rbd_spec_fill_snap_id()
>        | | --> fills rbd_dev->spec->snap_id
>        |rbd_dev_probe_parent()
>
> So clearly, at least when mapping a snapshot, we would not
> get the desired result.  We'll be unable to look up the id
> for the named snapshot, so would get ENOENT.
>
> Now you've pulled getting the parent info back out
> into rbd_dev_image_probe():
>   rbd_add()
>     do_rbd_add()
>       rbd_dev_image_probe()
>        |rbd_dev_header_info()
>        | |rbd_dev_v2_header_info()
>        | | |rbd_dev_v2_snap_context()
>        | | | --> this fills in the snapshot context
>        |rbd_spec_fill_snap_id()
>        | | --> fills rbd_dev->spec->snap_id
>        |rbd_dev_v2_parent_info()
>        | | --> rbd_dev->spec->snap_id will be valid
>        |rbd_dev_probe_parent()
>
> In the refresh path it's similar.  You move the
> rbd_dev_v2_parent_info() call into rbd_dev_refresh()
> instead of it happening in rbd_dev_v2_header_info().
> Missing the ordering problem here might have caused
> even more subtle problems (due to using an apparently
> valid but possibly out-of-date snapshot context).
>
> Given this understanding I'd say your change looks
> good.

Yeah, basically any time we read in snapshot metadata (both when
mapping a snapshot or following a chain of parent images) we need to
look at the parent_overlap of the snapshot (i.e. the parent_overlap of
the base image at the time the snapshot was taken).  That requires
having snap_id at hand when the call to rbd_dev_v2_parent_info() is
made.

>
>> The approach taken here is to make sure rbd_dev_v2_parent_info() is
>> called after the snap context has been read in.  The other approach
>> would be to add a parent_overlap field to struct rbd_mapping and
>> maintain it the same way rbd_mapping::size is maintained.  The reason
>> I chose the first approach is that the value of keeping around both
>> base image values and the actual mapping values is unclear to me.
>
> I'll think about this and respond to your followup e-mail.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  drivers/block/rbd.c |   64 ++++++++++++++++++++++++---------------------------
>>  1 file changed, 30 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 16f388f2960b..c4606987e9d1 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -515,6 +515,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
>>  static int rbd_dev_refresh(struct rbd_device *rbd_dev);
>>  static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
>>  static int rbd_dev_header_info(struct rbd_device *rbd_dev);
>> +static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
>>  static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
>>                                       u64 snap_id);
>>  static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
>> @@ -3513,6 +3514,18 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>       mapping_size = rbd_dev->mapping.size;
>>
>>       ret = rbd_dev_header_info(rbd_dev);
>
> This looked odd.  But I guess I didn't notice you
> didn't check the return value when you first added
> this line a few patches ago...

This is what rbd_dev_refresh() did before any of my changes.  It would
go ahead with trying to update mapping size and validating snapshot
existance even if rbd_dev_v{1,2}_header_info() had failed.

>
>> +     if (ret)
>> +             return ret;

I'll move this bit to "harden rbd_dev_refresh()" commit.

Thanks,

                Ilya
