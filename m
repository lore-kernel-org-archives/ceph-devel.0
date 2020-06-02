From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH 2/2] rbd: compression_hint option
Date: Tue, 2 Jun 2020 17:06:49 +0800
Message-ID: <f5d1cc3a-935d-542d-c6ac-29e698ef1b1f@easystack.cn>
References: <20200601195826.17159-1-idryomov@gmail.com>
 <20200601195826.17159-3-idryomov@gmail.com>
 <e3446fba-65e9-89b4-9687-6735f6935196@easystack.cn>
 <CAOi1vP9yu=xTJ-Oec=M-g0C0RKzb_oZ9DxjLDfmoqeNhyVpwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m9783.mail.qiye.163.com ([220.181.97.83]:61154 "EHLO
        m9783.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFBJGy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2020 05:06:54 -0400
In-Reply-To: <CAOi1vP9yu=xTJ-Oec=M-g0C0RKzb_oZ9DxjLDfmoqeNhyVpwHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>


在 6/2/2020 4:31 PM, Ilya Dryomov 写道:
> On Tue, Jun 2, 2020 at 4:34 AM Dongsheng Yang
> <dongsheng.yang@easystack.cn> wrote:
>> Hi Ilya,
>>
>> 在 6/2/2020 3:58 AM, Ilya Dryomov 写道:
>>> Allow hinting to bluestore if the data should/should not be compressed.
>>> The default is to not hint (compression_hint=none).
>>>
>>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>> ---
>>>    drivers/block/rbd.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index b1cd41e671d1..e02089d550a4 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -836,6 +836,7 @@ enum {
>>>        Opt_lock_timeout,
>>>        /* int args above */
>>>        Opt_pool_ns,
>>> +     Opt_compression_hint,
>>>        /* string args above */
>>>        Opt_read_only,
>>>        Opt_read_write,
>>> @@ -844,8 +845,23 @@ enum {
>>>        Opt_notrim,
>>>    };
>>>
>>> +enum {
>>> +     Opt_compression_hint_none,
>>> +     Opt_compression_hint_compressible,
>>> +     Opt_compression_hint_incompressible,
>>> +};
>>> +
>>> +static const struct constant_table rbd_param_compression_hint[] = {
>>> +     {"none",                Opt_compression_hint_none},
>>> +     {"compressible",        Opt_compression_hint_compressible},
>>> +     {"incompressible",      Opt_compression_hint_incompressible},
>>> +     {}
>>> +};
>>> +
>>>    static const struct fs_parameter_spec rbd_parameters[] = {
>>>        fsparam_u32     ("alloc_size",                  Opt_alloc_size),
>>> +     fsparam_enum    ("compression_hint",            Opt_compression_hint,
>>> +                      rbd_param_compression_hint),
>>>        fsparam_flag    ("exclusive",                   Opt_exclusive),
>>>        fsparam_flag    ("lock_on_read",                Opt_lock_on_read),
>>>        fsparam_u32     ("lock_timeout",                Opt_lock_timeout),
>>> @@ -867,6 +883,8 @@ struct rbd_options {
>>>        bool    lock_on_read;
>>>        bool    exclusive;
>>>        bool    trim;
>>> +
>>> +     u32 alloc_hint_flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
>>>    };
>>>
>>>    #define RBD_QUEUE_DEPTH_DEFAULT     BLKDEV_MAX_RQ
>>> @@ -2254,7 +2272,7 @@ static void __rbd_osd_setup_write_ops(struct ceph_osd_request *osd_req,
>>>                osd_req_op_alloc_hint_init(osd_req, which++,
>>>                                           rbd_dev->layout.object_size,
>>>                                           rbd_dev->layout.object_size,
>>> -                                        0);
>>> +                                        rbd_dev->opts->alloc_hint_flags);
>>>        }
>>>
>>>        if (rbd_obj_is_entire(obj_req))
>>> @@ -6332,6 +6350,29 @@ static int rbd_parse_param(struct fs_parameter *param,
>>>                pctx->spec->pool_ns = param->string;
>>>                param->string = NULL;
>>>                break;
>>> +     case Opt_compression_hint:
>>> +             switch (result.uint_32) {
>>> +             case Opt_compression_hint_none:
>>> +                     opt->alloc_hint_flags &=
>>> +                         ~(CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE |
>>> +                           CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE);
>>> +                     break;
>>> +             case Opt_compression_hint_compressible:
>>> +                     opt->alloc_hint_flags |=
>>> +                         CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
>>> +                     opt->alloc_hint_flags &=
>>> +                         ~CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
>>> +                     break;
>>> +             case Opt_compression_hint_incompressible:
>>> +                     opt->alloc_hint_flags |=
>>> +                         CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
>>> +                     opt->alloc_hint_flags &=
>>> +                         ~CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
>>> +                     break;
>>
>> Just one little question here,
>>
>> (1) none opt means clear compressible related bits in hint flags, then
>> lets the compressor in bluestore to decide compress or not.
>>
>> (2) compressible opt means set compressible bit and clear incompressible bit
>>
>> (3) incompressible opt means set incompressible bit and clear
>> compressible bit
>>
>>
>> Is there any scenario that alloc_hint_flags is not zero filled before
>> rbd_parse_param(), then we have to clear the unexpected bit?
> Hi Dongsheng,
>
> This is to handle the case when the map option string has multiple
> compression_hint options:
>
>    name=admin,...,compression_hint=compressible,...,compression_hint=none
>
> The last one wins and we always end up with either zero or just one
> of the flags set, not both.


Hi Ilya,

      Considering this case, should we make this kind of useage invalid? 
Maybe we

can do it in another patch to solve all rbd parameters conflicting problem.


Thanx

> Thanks,
>
>                  Ilya
