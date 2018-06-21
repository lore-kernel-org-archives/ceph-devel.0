From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] ceph: stop using current_kernel_time()
Date: Thu, 21 Jun 2018 16:53:20 +0200
Message-ID: <CAK8P3a1bXLXmjGf1Yx6JXbc4-Z8DjkZPZkfvesvjFXq3jw11NQ@mail.gmail.com>
References: <20180620155101.57685-1-arnd@arndb.de> <20180620155101.57685-2-arnd@arndb.de>
 <CAAM7YAk1WB_aVUbOdEMhNUYRNAVT-eq9vE3x2H5yr-hjja7qEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAk1WB_aVUbOdEMhNUYRNAVT-eq9vE3x2H5yr-hjja7qEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, y2038 Mailman List <y2038@lists.linaro.org>, ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Chengguang Xu <cgxu519@gmx.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jun 21, 2018 at 2:29 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 11:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> ceph_mdsc_create_request() is one of the last callers of the
>> deprecated current_kernel_time() as well as timespec_trunc().
>>
>> This changes it to use the timespec64 based interfaces instead,
>> though we still need to convert the result until we are ready to
>> change over req->r_stamp.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  fs/ceph/mds_client.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index dc8bc664a871..69c839316a7a 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -1779,6 +1779,7 @@ struct ceph_mds_request *
>>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>>  {
>>         struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
>> +       struct timespec64 ts;
>>
>>         if (!req)
>>                 return ERR_PTR(-ENOMEM);
>> @@ -1797,7 +1798,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>>         init_completion(&req->r_safe_completion);
>>         INIT_LIST_HEAD(&req->r_unsafe_item);
>>
>> -       req->r_stamp = timespec_trunc(current_kernel_time(), mdsc->fsc->sb->s_time_gran);
>> +       ktime_get_coarse_real_ts64(&ts);
>> +       req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
>> +                                               mdsc->fsc->sb->s_time_gran));
>>
>
> does current_time() internally uses ktime_get_coarse_real_ts64()?  If
> not,  granularity difference may cause problem. see commit
> 56199016e8672feb7b903eda003a863d5bf2b8c4 for more information

Yes, current_time() is based on current_kernel_time64(), which calls
ktime_get_coarse_real_ts64(). I'm in the process of removing both
current_kernel_time() and current_kernel_time64() in favor
of ktime_get_coarse_real_ts64() for consistency. The resolution
is unchanged here.

       Arnd
