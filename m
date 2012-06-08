From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Fri, 08 Jun 2012 14:32:05 +0800
Message-ID: <4FD19C65.8040309@intel.com>
References: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com> <4FCF64C8.7060506@dreamhost.com> <4FD19901.3010100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62846 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760000Ab2FHGcH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jun 2012 02:32:07 -0400
In-Reply-To: <4FD19901.3010100@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: elder@inktank.com, Alex Elder <elder@dreamhost.com>, ceph-devel@vger.kernel.org

On 06/08/2012 02:17 PM, Hannes Reinecke wrote:
> On 06/06/2012 04:10 PM, Alex Elder wrote:
>> On 06/06/2012 03:03 AM, Yan, Zheng wrote:
>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>
>>> The bug can cause NULL pointer dereference in write_partial_msg_pages
>>
>> Although this looks simple enough, I want to study it a little more
>> before committing it.  I've been wanting to walk through this bit
>> of code anyway so I'll do that today.
>>
>> One quick observation though:  m->bio_iter really ought to be
>> initialized only within #ifdef CONFIG_BLOCK (although I see it's
>> defined without it in the structure definition).  At some point
>> I'll put together a cleanup patch to do that everywhere; feel free
>> to do that yourself if you are so inclined.
>>
>> 					-Alex
>>
>>> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>>> ---
>>>  net/ceph/messenger.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>>> index 1a80907..785b953 100644
>>> --- a/net/ceph/messenger.c
>>> +++ b/net/ceph/messenger.c
>>> @@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_connection *con)
>>>  	     le32_to_cpu(con->out_msg->footer.front_crc),
>>>  	     le32_to_cpu(con->out_msg->footer.middle_crc));
>>>  
>>> +	m->bio_iter = NULL;
>>>  	/* is there a data payload? */
>>>  	if (le32_to_cpu(m->hdr.data_len) > 0) {
>>>  		/* initialize page iterator */
>>
> Incidentally, we've come across the same issue. First thing which
> struck me was this:
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 524f4e4..759d4d2 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -874,7 +874,7 @@ static int write_partial_msg_pages(struct
> ceph_connection *c
> on)
>                         page = list_first_entry(&msg->pagelist->head,
>                                                 struct page, lru);
>  #ifdef CONFIG_BLOCK
> -               } else if (msg->bio) {
> +               } else if (msg->bio_iter) {
>                         struct bio_vec *bv;
> 
>                         bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
> 
> We've called bio_list_init() a few lines above; however, it might
> return with a NULL bio_iter. So for consistency we should be
> checking for ->bio_iter here, as this is what we'll be using
> afterwards anyway.
> 
Only when msg->bio is NULL, bio_list_init() can return with a NULL bio_iter.
So I think this change is not necessary.

Regards
Yan, Zheng

