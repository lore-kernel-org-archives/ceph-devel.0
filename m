From: Wu Bo <wubo40@huawei.com>
Subject: Re: [PATCH] fs/ceph:fix double unlock in handle_cap_export()
Date: Tue, 28 Apr 2020 21:54:38 +0800
Message-ID: <f40f07f4-27b8-5308-80f6-9d2904c8dd52@huawei.com>
References: <1588077962-353994-1-git-send-email-wubo40@huawei.com>
 <CAAM7YAnWM4oHgwBNXQWY5BOMDmZ9Pbqdd7N0DDedTO6HxQQeqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAnWM4oHgwBNXQWY5BOMDmZ9Pbqdd7N0DDedTO6HxQQeqg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, liuzhiqiang26@huawei.com, linfeilong@huawei.com
List-Id: ceph-devel.vger.kernel.org

On 2020/4/28 21:41, Yan, Zheng wrote:
> On Tue, Apr 28, 2020 at 8:50 PM Wu Bo <wubo40@huawei.com> wrote:
>>
>> If the ceph_mdsc_open_export_target_session() return fails,
>> should add a lock to avoid twice unlocking.
>> Because the lock will be released at the retry or out_unlock tag.
>>
> 
> at retry label, i_ceph_lock get locked. I don't see how i_ceph_lock
> can get double unlock
>sorry, maybe I didn't describe it clearly enough, not i_ceph_lock, but 
session->s_mutex.

Thanks.

Wu Bo
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   fs/ceph/caps.c | 26 ++++++++++++++------------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 185db76..b5a62a8 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -3731,22 +3731,24 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>>
>>          /* open target session */
>>          tsession = ceph_mdsc_open_export_target_session(mdsc, target);
>> -       if (!IS_ERR(tsession)) {
>> -               if (mds > target) {
>> -                       mutex_lock(&session->s_mutex);
>> -                       mutex_lock_nested(&tsession->s_mutex,
>> -                                         SINGLE_DEPTH_NESTING);
>> -               } else {
>> -                       mutex_lock(&tsession->s_mutex);
>> -                       mutex_lock_nested(&session->s_mutex,
>> -                                         SINGLE_DEPTH_NESTING);
>> -               }
>> -               new_cap = ceph_get_cap(mdsc, NULL);
>> -       } else {
>> +       if (IS_ERR(tsession)) {
>>                  WARN_ON(1);
>>                  tsession = NULL;
>>                  target = -1;
>> +               mutex_lock(&session->s_mutex);
>> +               goto out_unlock;
>> +       }
>> +
>> +       if (mds > target) {
>> +               mutex_lock(&session->s_mutex);
>> +               mutex_lock_nested(&tsession->s_mutex,
>> +                                       SINGLE_DEPTH_NESTING);
>> +       } else {
>> +               mutex_lock(&tsession->s_mutex);
>> +               mutex_lock_nested(&session->s_mutex,
>> +                                       SINGLE_DEPTH_NESTING);
>>          }
>> +       new_cap = ceph_get_cap(mdsc, NULL);
>>          goto retry;
>>
>>   out_unlock:
>> --
>> 1.8.3.1
>>
> 
> .
> 
