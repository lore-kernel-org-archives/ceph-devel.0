From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: drop negtive child dentries before try pruning
 inode's alias
Date: Fri, 8 Dec 2017 15:32:45 +0800
Message-ID: <CAAM7YAnthj0Atg2eU_0rtBzX7ak+wsEqUu6Tz=jQypq2jb3iWw@mail.gmail.com>
References: <20171130141259.8577-1-zyan@redhat.com> <1512401111.4042.14.camel@redhat.com>
 <CAOi1vP-OuzDLUBWpDz6O0yvGTg7LSweTUZpkjVbJg5aMCgmB3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37547 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdLHHcq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 02:32:46 -0500
Received: by mail-oi0-f66.google.com with SMTP id y75so6672809oie.4
        for <ceph-devel@vger.kernel.org>; Thu, 07 Dec 2017 23:32:46 -0800 (PST)
In-Reply-To: <CAOi1vP-OuzDLUBWpDz6O0yvGTg7LSweTUZpkjVbJg5aMCgmB3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 7, 2017 at 9:21 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Mon, Dec 4, 2017 at 4:25 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> On Thu, 2017-11-30 at 22:12 +0800, Yan, Zheng wrote:
>>> negtive child dentry holds reference on inode's alias, it makes
>>> d_prune_aliases() do nothing.
>>>
>>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>>> ---
>>>  fs/ceph/mds_client.c | 43 ++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 36 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index da181acd4a61..9e7bb5fa9295 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -1440,6 +1440,30 @@ static int __close_session(struct ceph_mds_client *mdsc,
>>>       return request_close_session(mdsc, session);
>>>  }
>>>
>>> +static bool drop_negative_children(struct dentry *dentry)
>>> +{
>>> +     struct dentry *child;
>>> +     bool all_negtive = true;
>>> +
>>> +     if (!d_is_dir(dentry))
>>> +             goto out;
>>> +
>>> +     spin_lock(&dentry->d_lock);
>>> +     list_for_each_entry(child, &dentry->d_subdirs, d_child) {
>>> +             if (d_really_is_positive(child)) {
>>> +                     all_negtive = false;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     spin_unlock(&dentry->d_lock);
>>> +
>>> +     if (all_negtive)
>>> +             shrink_dcache_parent(dentry);
>>> +out:
>>> +     dput(dentry);
>>
>> It's sort of nasty to drop the reference here. It makes it harder to
>> track how that gets done when you acquire and drop references across a
>> function boundary like this. There's also no reason for it since you
>> always do it last here anyway.
>>
>> It'd be nicer to just move that into the caller.
>>
>>> +     return all_negtive;
>>> +}
>>> +
>>>  /*
>>>   * Trim old(er) caps.
>>>   *
>>> @@ -1495,15 +1519,20 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
>>>               __ceph_remove_cap(cap, true);
>>>               session->s_trim_caps--;
>>>       } else {
>>> -             int refs;
>>> +             struct dentry *dentry;
>>>               /* try dropping referring dentries */
>>>               spin_unlock(&ci->i_ceph_lock);
>>> -             d_prune_aliases(inode);
>>> -             refs = atomic_read(&inode->i_count);
>>> -             if (refs == 1)
>>> -                     session->s_trim_caps--;
>>> -             dout("trim_caps_cb %p cap %p  pruned, count now %d\n",
>>> -                  inode, cap, refs);
>>> +             dentry = d_find_any_alias(inode);
>>> +             /* drop_negative_children() calls dput() */
>>> +             if (dentry && drop_negative_children(dentry)) {
>>> +                     int refs;
>>> +                     d_prune_aliases(inode);
>>> +                     refs = atomic_read(&inode->i_count);
>>> +                     if (refs == 1)
>>> +                             session->s_trim_caps--;
>>> +                     dout("trim_caps_cb %p cap %p pruned, count now %d\n",
>>> +                          inode, cap, refs);
>>> +             }
>>>               return 0;
>>>       }
>>>
>>
>> I think the rest looks fine though.
>
> Hi Jeff, Zheng,
>
> What is the status of this patch?  It is marked for stable in the
> testing branch and Zheng force-pushed it two days ago, addressing
> comments.  Jeff, can you take a look?
>
> Zheng, negtive and all_negtive typos need fixing.
>
> Also, would it make sense to merge these two patches ("ceph: decease
> session->s_trim_caps only after caps get trimmed" and "ceph: drop
> negtive child dentries before try pruning inode's alias") into one?
> They seem to fix the same bug and the second almost entirely redoes the
> first.
>

I merged them and re-push the new one to testing branch.

Thank all of you.


> Thanks,
>
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
