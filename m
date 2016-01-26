From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [patch] ceph: checking for IS_ERR instead of NULL
Date: Tue, 26 Jan 2016 19:54:32 +0800
Message-ID: <25A36812-97DA-46D7-BE1A-A8C15C2A29AC@redhat.com>
References: <20160126092444.GB15717@mwanda> <CAOi1vP-kT4tA-vvjg5QD-h5zkUJFC+X5Hw07tFsnjfP8tww4PA@mail.gmail.com> <727F0631-509B-4410-9344-7D03B4D32E0D@redhat.com> <CAOi1vP9Tw5a8GkHuZiBUNf+tpb4g97Z8C5pUcdUkjfAE+ZM_hA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9Tw5a8GkHuZiBUNf+tpb4g97Z8C5pUcdUkjfAE+ZM_hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On Jan 26, 2016, at 19:40, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Tue, Jan 26, 2016 at 12:16 PM, Yan, Zheng <zyan@redhat.com> wrote:
>> 
>>> On Jan 26, 2016, at 18:30, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> 
>>> On Tue, Jan 26, 2016 at 10:24 AM, Dan Carpenter
>>> <dan.carpenter@oracle.com> wrote:
>>>> ceph_osdc_alloc_request() returns NULL on error, it never returns error
>>>> pointers.
>>>> 
>>>> Fixes: 5be0389dac66 ('ceph: re-send AIO write request when getting -EOLDSNAP error')
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> 
>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>> index d37efdd..a52cf9b 100644
>>>> --- a/fs/ceph/file.c
>>>> +++ b/fs/ceph/file.c
>>>> @@ -698,8 +698,8 @@ static void ceph_aio_retry_work(struct work_struct *work)
>>>> 
>>>>       req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc, 2,
>>>>                       false, GFP_NOFS);
>>>> -       if (IS_ERR(req)) {
>>>> -               ret = PTR_ERR(req);
>>>> +       if (!req) {
>>>> +               ret = -ENOMEM;
>>>>               req = orig_req;
>>>>               goto out;
>>>>       }
>>> 
>>> Applied, thanks Dan.
>>> 
>>> Zheng, I have an related concern: where do you put snapc (refcount is
>>> bumped a few lines above) if ceph_osdc_alloc_request() fails?  It looks
>>> like it's leaked to me.
>>> 
>>> The BUG_ON(ret == -EOLDSNAPC) also seems a bit bogus, given that ret is
>>> either -ENOMEM or ceph_osdc_start_request() retval.
>> 
>> ceph_aio_complete_req treats -EOLDSNAP distinguishingly.  Purpose of this BUG_ON is detect potential infinite loop.
> 
> Did you miss the part about the snap context?
> 
> I get the purpose of -EOLDSNAPC assert in ceph_direct_read_write(),
> where you can actually get it from ceph_osdc_wait_request() - it's
> a server-side error code.  Asserting it in ceph_aio_retry_work(), in
> which only client helpers are called and the only two possible error
> codes are -ENOMEM and -EIO doesn't make much sense to me.
> 

Yeah, removing that BUG_ON is completely OK.

Regards,
Yan, Zheng

> Thanks,
> 
>                Ilya
