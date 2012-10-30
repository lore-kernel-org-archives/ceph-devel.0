From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 8/8] rbd: fill rbd_spec in rbd_add_parse_args()
Date: Tue, 30 Oct 2012 13:18:50 -0700
Message-ID: <5090362A.4010007@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B16DB.6040900@inktank.com> <508F0376.90409@inktank.com> <508FD196.4010207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:65474 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2J3UTD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 16:19:03 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so269668dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 13:19:01 -0700 (PDT)
In-Reply-To: <508FD196.4010207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/30/2012 06:09 AM, Alex Elder wrote:
> On 10/29/2012 05:30 PM, Josh Durgin wrote:
>> On 10/26/2012 04:03 PM, Alex Elder wrote:
>>> Pass the address of an rbd_spec structure to rbd_add_parse_args().
>>> Use it to hold the information defining the rbd image to be mapped
>>> in an rbd_add() call.
>>>
>>> Use the result in the caller to initialize the rbd_dev->id field.
>>>
>>> This means rbd_dev is no longer needed in rbd_add_parse_args(),
>>> so get rid of it.
>>>
>>> Now that this transformation of rbd_add_parse_args() is complete,
>>> correct and expand on the its header documentation to reflect the
>>> new reality.
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>    drivers/block/rbd.c |  104
>>> ++++++++++++++++++++++++++++++++++-----------------
>>>    1 file changed, 70 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 19c7c6b..28abd31 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>
> . . .
>
>>> @@ -2973,15 +3008,15 @@ static int rbd_add_parse_args(struct rbd_device
>>> *rbd_dev,
>>>        }
>>>        *opts = rbd_opts;
>>>
>>> +    *rbd_spec = spec;
>>> +
>>>        return 0;
>>>    out_mem:
>>>        ret = -ENOMEM;
>>> +    kfree(spec->image_name);
>>> +    kfree(spec->pool_name);
>>> +    kfree(spec);
>>
>> This is missing spec->snap_name. Why not use rbd_spec_put()?
>
> You're right, and you're right.  It was an oversight.  I'll fix
> that.  Do you want me to repost?

No, the change is trivial enough. You can add my reviewed-by with that.

> In keeping with some of your previous comments I have also added
> a note to include in a future patch messages about why a map
> request failed in rbd_add() via a log message.

Sounds good.

>
> 					-Alex
>
>>>    out_err:
>>> -    kfree(rbd_dev->spec->image_name);
>>> -    rbd_dev->spec->image_name = NULL;
>>> -    rbd_dev->spec->image_name_len = 0;
>>> -    kfree(rbd_dev->spec->pool_name);
>>> -    rbd_dev->spec->pool_name = NULL;
>>>        kfree(options);
>>>
> . . .

