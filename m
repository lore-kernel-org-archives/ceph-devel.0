From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 1/3] ceph: fix potential mdsc use-after-free crash
Date: Wed, 1 Jul 2020 19:57:18 +0800
Message-ID: <2ec6a518-973e-0c87-98c8-180d8b8a0feb@redhat.com>
References: <1593582768-2954-1-git-send-email-xiubli@redhat.com>
 <c586bbc39a666391c86be355b5c7cb32a5baa532.camel@kernel.org>
 <daef4fc2-b206-d1cb-5946-2b97a2062628@redhat.com>
 <ad6ab748fa35d34f14486cd69389fc44eb373ce7.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730103AbgGAL53 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2020 07:57:29 -0400
In-Reply-To: <ad6ab748fa35d34f14486cd69389fc44eb373ce7.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/7/1 19:55, Jeff Layton wrote:
> On Wed, 2020-07-01 at 19:25 +0800, Xiubo Li wrote:
>> On 2020/7/1 19:17, Jeff Layton wrote:
>>> On Wed, 2020-07-01 at 01:52 -0400, xiubli@redhat.com wrote:
>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> Make sure the delayed work stopped before releasing the resources.
>>>>
>>>> Because the cancel_delayed_work_sync() will only guarantee that the
>>>> work finishes executing if the work is already in the ->worklist.
>>>> That means after the cancel_delayed_work_sync() returns and in case
>>>> if the work will re-arm itself, it will leave the work requeued. And
>>>> if we release the resources before the delayed work to run again we
>>>> will hit the use-after-free bug.
>>>>
>>>> URL: https://tracker.ceph.com/issues/46293
>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>> ---
>>>>    fs/ceph/mds_client.c | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>> index d5e523c..9a09d12 100644
>>>> --- a/fs/ceph/mds_client.c
>>>> +++ b/fs/ceph/mds_client.c
>>>> @@ -4330,6 +4330,9 @@ static void delayed_work(struct work_struct *work)
>>>>    
>>>>    	dout("mdsc delayed_work\n");
>>>>    
>>>> +	if (mdsc->stopping)
>>>> +		return;
>>>> +
>>>>    	mutex_lock(&mdsc->mutex);
>>>>    	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
>>>>    	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
>>>> @@ -4689,7 +4692,16 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
>>>>    static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
>>>>    {
>>>>    	dout("stop\n");
>>>> -	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
>>>> +	/*
>>>> +	 * Make sure the delayed work stopped before releasing
>>>> +	 * the resources.
>>>> +	 *
>>>> +	 * Because the cancel_delayed_work_sync() will only
>>>> +	 * guarantee that the work finishes executing. But the
>>>> +	 * delayed work will re-arm itself again after that.
>>>> +	 */
>>>> +	flush_delayed_work(&mdsc->delayed_work);
>>>> +
>>>>    	if (mdsc->mdsmap)
>>>>    		ceph_mdsmap_destroy(mdsc->mdsmap);
>>>>    	kfree(mdsc->sessions);
>>> This patch looks fine, but the subject says [PATCH 1/3]. Were there
>>> others in this series that didn't make it to the list for some reason?
>> Sorry for confusing.
>>
>> Just generated this patch with the metrics series and forget to fix it
>> before sending out.
>>
>>
> No worries. Just making sure before I merged it. Merged patch into
> testing branch.

Thanks Jeff.

BRs


>
> Thanks!
