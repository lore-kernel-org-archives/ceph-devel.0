From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] libceph: fix oops in ceph_msg_data_pagelist_advance()
Date: Sun, 23 Mar 2014 07:38:16 +0800
Message-ID: <CAAM7YAnCYeNJMzM2sTs-56Qz+j0d68zKvMsqio3zUB=GwdnN2Q@mail.gmail.com>
References: <1395528897-26031-1-git-send-email-zheng.z.yan@intel.com>
	<532E1866.4070402@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:54016 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaCVXiR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Mar 2014 19:38:17 -0400
Received: by mail-la0-f47.google.com with SMTP id y1so2644015lam.20
        for <ceph-devel@vger.kernel.org>; Sat, 22 Mar 2014 16:38:16 -0700 (PDT)
In-Reply-To: <532E1866.4070402@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Mar 23, 2014 at 7:10 AM, Alex Elder <elder@ieee.org> wrote:
> On 03/22/2014 05:54 PM, Yan, Zheng wrote:
>> When there is no more data, ceph_msg_data_pagelist_advance() should
>> not move on to the next page.
>
> Without looking very hard at this, this looks right.
> Does ceph_msg_data_pages_advance() need the same fix?
> And ceph_msg_data_bio_advance()?
>
ceph_msg_data_pages_advance() needs it, ceph_msg_data_bio_advance() does not.


> I'm going to spend a little more time to refresh my
> memory on these things.
>
>                                         -Alex
>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  net/ceph/messenger.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 30efc5c..8859f2e 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -1004,6 +1004,9 @@ static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
>>       if (!bytes || cursor->offset & ~PAGE_MASK)
>>               return false;   /* more bytes to process in the current page */
>>
>> +     if (!cursor->resid)
>> +             return false;   /* no more data */
>> +
>>       /* Move on to the next page */
>>
>>       BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
