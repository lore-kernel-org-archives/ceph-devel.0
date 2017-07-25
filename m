From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] libceph: fix osd request encoding regression
Date: Tue, 25 Jul 2017 21:14:46 +0800
Message-ID: <E6E0CA48-9FA8-4288-8FF3-27283C1B97DC@redhat.com>
References: <20170724132802.7916-1-zyan@redhat.com>
 <CAOi1vP-oN-_1u3h2owk++=tF9TSRKrDJMBuxAF4FUG1vDy5gvg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbdGYNNR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 25 Jul 2017 09:13:17 -0400
In-Reply-To: <CAOi1vP-oN-_1u3h2owk++=tF9TSRKrDJMBuxAF4FUG1vDy5gvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On 25 Jul 2017, at 21:01, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Mon, Jul 24, 2017 at 3:28 PM, Yan, Zheng <zyan@redhat.com> wrote:
>> The new BUG_ON in encode_request_partial() verifies that space used
>> by encoding request front is exactly equal to request message size.
>> This is wrong because request messages allocated from mempool always
>> have size PAGE_SIZE.
>> 
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> net/ceph/osd_client.c | 17 +++++++++--------
>> 1 file changed, 9 insertions(+), 8 deletions(-)
>> 
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 5c9d696..81f6199 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1913,10 +1913,11 @@ static void encode_request_partial(struct ceph_osd_request *req,
>>        }
>> 
>>        ceph_encode_32(&p, req->r_attempts); /* retry_attempt */
>> -       BUG_ON(p != end - 8); /* space for features */
>> +       BUG_ON(p + 8 > end); /* space for features */
>> 
>>        msg->hdr.version = cpu_to_le16(8); /* MOSDOp v8 */
>> -       /* front_len is finalized in encode_request_finish() */
>> +       msg->front.iov_len = p + 8 - msg->front.iov_base;
>> +       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>>        msg->hdr.data_len = cpu_to_le32(data_len);
>>        /*
>>         * The header "data_off" is a hint to the receiver allowing it
>> @@ -1932,7 +1933,7 @@ static void encode_request_partial(struct ceph_osd_request *req,
>> static void encode_request_finish(struct ceph_msg *msg)
>> {
>>        void *p = msg->front.iov_base;
>> -       void *const end = p + msg->front_alloc_len;
>> +       void *const end = p + msg->front.iov_len;
>> 
>>        if (CEPH_HAVE_FEATURE(msg->con->peer_features, RESEND_ON_SPLIT)) {
>>                /* luminous OSD -- encode features and be done */
>> @@ -2008,11 +2009,11 @@ static void encode_request_finish(struct ceph_msg *msg)
>>                p += tail_len;
>> 
>>                msg->hdr.version = cpu_to_le16(4); /* MOSDOp v4 */
>> -       }
>> 
>> -       BUG_ON(p > end);
>> -       msg->front.iov_len = p - msg->front.iov_base;
>> -       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>> +               BUG_ON(p > end);
>> +               msg->front.iov_len = p - msg->front.iov_base;
>> +               msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>> +       }
>> 
>>        dout("%s msg %p tid %llu %u+%u+%u v%d\n", __func__, msg,
>>             le64_to_cpu(msg->hdr.tid), le32_to_cpu(msg->hdr.front_len),
>> @@ -3981,7 +3982,7 @@ static struct ceph_msg *create_backoff_message(
>>                return NULL;
>> 
>>        p = msg->front.iov_base;
>> -       end = p + msg->front_alloc_len;
>> +       end = p + msg->front.iov_len;
>> 
>>        encode_spgid(&p, &backoff->spgid);
>>        ceph_encode_32(&p, map_epoch);
> 
> Hi Zheng,
> 
> How about the attached patch instead?  It's shorter and more
> importantly preserves the existing structure.

does encode_request_finish() get called each time we re-send a message?
If it does, your patch seems incorrect. encode_request_finish() appends extra
8 bytes to the message each time it get called.

> 
> What is create_backoff_message() hunk for?  Backoff messages are
> never allocated out of ceph_msgpool.

For unifying the code.

Regards
Yan, Zheng


> 
> Thanks,
> 
>                Ilya
> <0001-libceph-make-encode_request_-work-with-r_mempool-req.patch>

