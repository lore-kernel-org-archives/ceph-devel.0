From: Wu Bo <wubo40@huawei.com>
Subject: Re: [PATCH V2] fs/ceph:fix double unlock in handle_cap_export()
Date: Thu, 30 Apr 2020 12:31:00 +0800
Message-ID: <3fb139b0-062a-9f17-1855-66dacf5d6825@huawei.com>
References: <1588079622-423774-1-git-send-email-wubo40@huawei.com>
 <e89bd817c69422c85f1945041dd83fbe8d534805.camel@kernel.org>
 <6c99072a-f92b-b7e8-9aef-509d1a9ee985@huawei.com>
 <CAAM7YA=OU2jJ9F_p1fAknaxZCDWMY7w9yiRE0z0uqxDNYPG5Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:39172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgD3EbN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:31:13 -0400
In-Reply-To: <CAAM7YA=OU2jJ9F_p1fAknaxZCDWMY7w9yiRE0z0uqxDNYPG5Mg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, liuzhiqiang26@huawei.com, linfeilong@huawei.com

On 2020/4/30 10:50, Yan, Zheng wrote:
> On Wed, Apr 29, 2020 at 8:49 AM Wu Bo <wubo40@huawei.com> wrote:
>>
>> On 2020/4/28 22:48, Jeff Layton wrote:
>>> On Tue, 2020-04-28 at 21:13 +0800, Wu Bo wrote:
>>>> if the ceph_mdsc_open_export_target_session() return fails,
>>>> should add a lock to avoid twice unlocking.
>>>> Because the lock will be released at the retry or out_unlock tag.
>>>>
>>>
>>> The problem looks real, but...
>>>
>>>> --
>>>> v1 -> v2:
>>>> add spin_lock(&ci->i_ceph_lock) before goto out_unlock tag.
>>>>
>>>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>>>> ---
>>>>    fs/ceph/caps.c | 27 +++++++++++++++------------
>>>>    1 file changed, 15 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>>> index 185db76..414c0e2 100644
>>>> --- a/fs/ceph/caps.c
>>>> +++ b/fs/ceph/caps.c
>>>> @@ -3731,22 +3731,25 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>>>>
>>>>       /* open target session */
>>>>       tsession = ceph_mdsc_open_export_target_session(mdsc, target);
>>>> -    if (!IS_ERR(tsession)) {
>>>> -            if (mds > target) {
>>>> -                    mutex_lock(&session->s_mutex);
>>>> -                    mutex_lock_nested(&tsession->s_mutex,
>>>> -                                      SINGLE_DEPTH_NESTING);
>>>> -            } else {
>>>> -                    mutex_lock(&tsession->s_mutex);
>>>> -                    mutex_lock_nested(&session->s_mutex,
>>>> -                                      SINGLE_DEPTH_NESTING);
>>>> -            }
>>>> -            new_cap = ceph_get_cap(mdsc, NULL);
>>>> -    } else {
>>>> +    if (IS_ERR(tsession)) {
>>>>               WARN_ON(1);
>>>>               tsession = NULL;
>>>>               target = -1;
>>>> +            mutex_lock(&session->s_mutex);
>>>> +            spin_lock(&ci->i_ceph_lock);
>>>> +            goto out_unlock;
>>>
>>> Why did you make this case goto out_unlock instead of retrying as it did
>>> before?
>>>
>>
>> If the problem occurs, target = -1, and goto retry lable, you need to
>> call __get_cap_for_mds() or even call __ceph_remove_cap(), and then jump
>> to out_unlock lable. All I think is unnecessary, goto out_unlock instead
>> of retrying directly.
>>
> 
> __ceph_remove_cap() must be called even if opening target session
> failed. I think adding a mutex_lock(&session->s_mutex) to the
> IS_ERR(tsession) block should be enough.
> 

Yes，I will send the V3 patch later.

> 
>> Thanks.
>> Wu Bo
>>
>>>> +    }
>>>> +
>>>> +    if (mds > target) {
>>>> +            mutex_lock(&session->s_mutex);
>>>> +            mutex_lock_nested(&tsession->s_mutex,
>>>> +                                    SINGLE_DEPTH_NESTING);
>>>> +    } else {
>>>> +            mutex_lock(&tsession->s_mutex);
>>>> +            mutex_lock_nested(&session->s_mutex,
>>>> +                                    SINGLE_DEPTH_NESTING);
>>>>       }
>>>> +    new_cap = ceph_get_cap(mdsc, NULL);
>>>>       goto retry;
>>>>
>>>>    out_unlock:
>>>
>>
>>
> 
> .
> 
