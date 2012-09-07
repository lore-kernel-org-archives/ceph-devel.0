From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 05/11] rbd: move rbd_opts to struct rbd_device
Date: Fri, 7 Sep 2012 14:40:20 -0700
Message-ID: <CAC-hyiHNkqLR_sE+k=erEXemZc5W8b9ACo7tRm1civ1UWQvAvQ@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037ACF3.5000506@inktank.com>
	<CAC-hyiE42C1CahCDAxh0LawehFdY2c2VYiUxWcinqVAf4uJ27A@mail.gmail.com>
	<5048B16C.30709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33163 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab2IGVkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:40:22 -0400
Received: by eaac11 with SMTP id c11so17996eaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:40:20 -0700 (PDT)
In-Reply-To: <5048B16C.30709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 6, 2012 at 7:21 AM, Alex Elder <elder@inktank.com> wrote:
> On 08/30/2012 12:07 PM, Yehuda Sadeh wrote:
>> On Fri, Aug 24, 2012 at 9:33 AM, Alex Elder <elder@inktank.com> wrote:
>>> The rbd options don't really apply to the ceph client.  So don't
>>> store a pointer to it in the ceph_client structure, and put them
>>> (a struct, not a pointer) into the rbd_dev structure proper.
>>>
>>> Pass the rbd device structure to rbd_client_create() so it can
>>> assign rbd_dev->rbdc if successful, and have it return an error code
>>> instead of the rbd client pointer.
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>  drivers/block/rbd.c |   49
>>> ++++++++++++++++---------------------------------
>>>  1 file changed, 16 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 130dbc2..b40f553 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -98,7 +98,6 @@ struct rbd_options {
>>>   */
>>>  struct rbd_client {
>>>         struct ceph_client      *client;
>>> -       struct rbd_options      *rbd_opts;
>>>         struct kref             kref;
>>>         struct list_head        node;
>>>  };
>>> @@ -152,6 +151,7 @@ struct rbd_device {
>>>         struct gendisk          *disk;          /* blkdev's gendisk and rq */
>>>         struct request_queue    *q;
>>>
>>> +       struct rbd_options      rbd_opts;
>>>         struct rbd_client       *rbd_client;
>>>
>>>         char                    name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
>>> @@ -273,8 +273,7 @@ static const struct block_device_operations
>>> rbd_bd_ops = {
>>>   * Initialize an rbd client instance.
>>>   * We own *ceph_opts.
>>>   */
>>> -static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts,
>>> -                                           struct rbd_options *rbd_opts)
>>> +static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
>>>  {
>>>         struct rbd_client *rbdc;
>>>         int ret = -ENOMEM;
>>> @@ -298,8 +297,6 @@ static struct rbd_client *rbd_client_create(struct
>>> ceph_options *ceph_opts,
>>>         if (ret < 0)
>>>                 goto out_err;
>>>
>>> -       rbdc->rbd_opts = rbd_opts;
>>> -
>>>         spin_lock(&rbd_client_list_lock);
>>>         list_add_tail(&rbdc->node, &rbd_client_list);
>>>         spin_unlock(&rbd_client_list_lock);
>>> @@ -402,42 +399,33 @@ static int parse_rbd_opts_token(char *c, void
>>> *private)
>>>   * Get a ceph client with specific addr and configuration, if one does
>>>   * not exist create it.
>>>   */
>>> -static struct rbd_client *rbd_get_client(const char *mon_addr,
>>> -                                        size_t mon_addr_len,
>>> -                                        char *options)
>>> +static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
>>> +                               size_t mon_addr_len, char *options)
>>>  {
>>> -       struct rbd_client *rbdc;
>>> +       struct rbd_options *rbd_opts = &rbd_dev->rbd_opts;
>>>         struct ceph_options *ceph_opts;
>>> -       struct rbd_options *rbd_opts;
>>> -
>>> -       rbd_opts = kzalloc(sizeof(*rbd_opts), GFP_KERNEL);
>>> -       if (!rbd_opts)
>>> -               return ERR_PTR(-ENOMEM);
>>> +       struct rbd_client *rbdc;
>>>
>>>         rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
>>>
>>>         ceph_opts = ceph_parse_options(options, mon_addr,
>>>                                         mon_addr + mon_addr_len,
>>>                                         parse_rbd_opts_token, rbd_opts);
>>> -       if (IS_ERR(ceph_opts)) {
>>> -               kfree(rbd_opts);
>>> -               return ERR_CAST(ceph_opts);
>>> -       }
>>> +       if (IS_ERR(ceph_opts))
>>> +               return PTR_ERR(ceph_opts);
>>>
>>>         rbdc = rbd_client_find(ceph_opts);
>>>         if (rbdc) {
>>>                 /* using an existing client */
>>>                 ceph_destroy_options(ceph_opts);
>>
>> It'll probably be better to use a reference count to control ceph_opts lifecycle
>
> I looked at this.
>
> In this case, ceph_opts is directly tied to a ceph_client.
> If a ceph client exists whose options match the one that
> has been created here, that client will be used, and its
> options get destroyed when the ceph_client gets destroyed
> (and the ceph_client is refcounted).  The ceph_opts
> created here will never be referenced by anything else
> so it's safe to just destroy it.
>
> If no existing rbd_client has a ceph_client with matching
> ceph_options, then one is created below and it will use
> the ceph_opts created here and thus its life cycle will
> be managed by that ceph_client's reference count.
>
> I believe this means there is no reason to reference count
> ceph_opts.
>
> Yehuda, please let me know if you disagree with this.  If
> not, would you sign off on this?
>

Yeah, I see it now. Not sure whether the way it is now is the cleanest
way to approach it, but it'll work for now. Maybe we should keep the
existing ceph_opts in libceph, and have ceph_parse_options() test and
increase reference if exists. Though, it might be that it's what we
did before and it was problematic as rbd was sharing configs with
cephfs.

Anyway,

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>
