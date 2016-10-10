From: Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCHv2] ceph: Fix error handling in ceph_read_iter
Date: Mon, 10 Oct 2016 16:13:17 +0300
Message-ID: <57FB93ED.5030602@kyup.com>
References: <1476103098-2925-1-git-send-email-kernel@kyup.com>
 <1476104199-3259-1-git-send-email-kernel@kyup.com>
 <530F1E79-6653-45F5-BBC6-B1D9F9005D14@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34260 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbcJJNNU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 09:13:20 -0400
Received: by mail-qt0-f171.google.com with SMTP id q7so52786143qtq.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2016 06:13:19 -0700 (PDT)
In-Reply-To: <530F1E79-6653-45F5-BBC6-B1D9F9005D14@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org



On 10/10/2016 04:11 PM, Yan, Zheng wrote:
> 
>> On 10 Oct 2016, at 20:56, Nikolay Borisov <kernel@kyup.com> wrote:
>>
>> In case __ceph_do_getattr returns an error and the retry_op in
>> ceph_read_iter is not READ_INLINE, then it's possible to invoke
>> __free_page on a page which is NULL, this naturally leads to a crash.
>> This can happen when, for example, a process waiting on a MDS reply
>> receives sigterm.
>>
>> Fix this by explicitly checking whether the page is set or not.
>>
>> Signed-off-by: Nikolay Borisov <kernel@kyup.com>
>> Link: http://www.spinics.net/lists/ceph-users/msg31592.html
>> ---
>>
>> Inverted the condition, so resending with correct condition
>> this time. 
>>
>> fs/ceph/file.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 3c68e6aee2f0..7413313ae6c8 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -929,7 +929,8 @@ again:
>> 		statret = __ceph_do_getattr(inode, page,
>> 					    CEPH_STAT_CAP_INLINE_DATA, !!page);
>> 		if (statret < 0) {
>> -			 __free_page(page);
>> +			if (page)
>> +				__free_page(page);
>> 			if (statret == -ENODATA) {
>> 				BUG_ON(retry_op != READ_INLINE);
>> 				goto again;
>> — 
> Reviewed-by: Yan, Zheng <zyan@redhat.com>

I believe this needs to also be tagged as stable. To whomever is going
to merge it: can you please do that?


> 
>> 2.5.0
>>
> 
