From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/3] libceph: define mds_alloc_msg() method
Date: Mon, 04 Mar 2013 13:37:18 -0600
Message-ID: <5134F7EE.4090407@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com> <5134E401.6070604@inktank.com> <CAPYLRziQhNS1GcXUyhyrY=4YC0A4xW9YhPYYAbQFQJk9JkTAww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52746 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289Ab3CDThS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:37:18 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so6676435iea.10
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:37:17 -0800 (PST)
In-Reply-To: <CAPYLRziQhNS1GcXUyhyrY=4YC0A4xW9YhPYYAbQFQJk9JkTAww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/04/2013 01:05 PM, Gregory Farnum wrote:
> This looks like a faithful reshuffling to me.
> 
> But...
> On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 6ec6051..c7d4278 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -2804,55 +2804,34 @@ static int ceph_alloc_middle(struct
>> ceph_connection *con, struct ceph_msg *msg)
>>  static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
>>  {
>>         struct ceph_msg_header *hdr = &con->in_hdr;
>> -       int type = le16_to_cpu(hdr->type);
>> -       int front_len = le32_to_cpu(hdr->front_len);
>>         int middle_len = le32_to_cpu(hdr->middle_len);
>>         struct ceph_msg *msg;
>>         int ret = 0;
>>
>>         BUG_ON(con->in_msg != NULL);
>> +       BUG_ON(!con->ops->alloc_msg);
>>
>> -       if (con->ops->alloc_msg) {
>> -               mutex_unlock(&con->mutex);
>> -               msg = con->ops->alloc_msg(con, hdr, skip);
>> -               mutex_lock(&con->mutex);
>> -               if (con->state != CON_STATE_OPEN) {
>> -                       if (msg)
>> -                               ceph_msg_put(msg);
>> -                       return -EAGAIN;
>> -               }
>> -               con->in_msg = msg;
>> -               if (con->in_msg) {
>> -                       con->in_msg->con = con->ops->get(con);
>> -                       BUG_ON(con->in_msg->con == NULL);
>> -               }
>> -               if (*skip) {
>> -                       con->in_msg = NULL;
>> -                       return 0;
>> -               }
>> -               if (!con->in_msg) {
>> -                       con->error_msg =
>> -                               "error allocating memory for incoming message";
>> -                       return -ENOMEM;
>> -               }
>> -       }
>> -       if (!con->in_msg) {
>> -               mutex_unlock(&con->mutex);
>> -               msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
>> -               mutex_lock(&con->mutex);
>> -               if (!msg) {
>> -                       pr_err("unable to allocate msg type %d len %d\n",
>> -                              type, front_len);
>> -                       return -ENOMEM;
>> -               }
>> -               if (con->state != CON_STATE_OPEN) {
>> +       mutex_unlock(&con->mutex);
>> +       msg = con->ops->alloc_msg(con, hdr, skip);
>> +       mutex_lock(&con->mutex);
>> +       if (con->state != CON_STATE_OPEN) {
>> +               if (msg)
>>                         ceph_msg_put(msg);
>> -                       return -EAGAIN;
>> -               }
>> -               con->in_msg = msg;
>> +               return -EAGAIN;
>> +       }
>> +       con->in_msg = msg;
>> +       if (con->in_msg) {
>>                 con->in_msg->con = con->ops->get(con);
>>                 BUG_ON(con->in_msg->con == NULL);
>> -               con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
>> +       }
>> +       if (*skip) {
>> +               con->in_msg = NULL;
>> +               return 0;
> 
> This looks like a memory leak to me? I'm not familiar with the skip
> infrastructure; is there something that cleans up those messages in
> the background, or should this actually be a BUG_ON?

It looks that way to me too, but the con->ops->get(con) call before
it makes it a little tricky.  I will investigate and get back
to you, and if it is a leak I'll insert a fix for it ahead of this
in the series.

I really appreciate your reviewing these.

					-Alex

