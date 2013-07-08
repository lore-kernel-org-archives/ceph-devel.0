From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Mon, 8 Jul 2013 10:46:31 -0400
Message-ID: <CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com>
References: <20130629035155.GA7975@gmail.com>
	<CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com>
	<CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
	<11954.1372792498@warthog.procyon.org.uk>
	<CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com>
	<12577.1372793962@warthog.procyon.org.uk>
	<CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com>
	<1074.1372798161@warthog.procyon.org.uk>
	<CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com>
	<3869.1372808417@warthog.procyon.org.uk>
	<CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36394 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3GHOqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 10:46:32 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so9642120ief.26
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jul 2013 07:46:32 -0700 (PDT)
In-Reply-To: <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

David,

It looks like both the cifs and NFS code do not bother with any
locking around cifs_fscache_set_inode_cookie. Is there no concern over
multiple open() calls racing to create the cookie in those
filesystems?

Thanks,
-- Milosz

On Wed, Jul 3, 2013 at 3:02 PM, Milosz Tanski <milosz@adfin.com> wrote:
> David,
>
> I took your suggestions and updated my wip branch (on bitbucket) with
> a handful of fixes except for the locking around registering the
> cookie. I'm not sure what's the correct thing to do there.
>
> On Tue, Jul 2, 2013 at 7:40 PM, David Howells <dhowells@redhat.com> wrote:
>>
>> Okay, my analysis of the patch:
>>
>> Looking at your index structure, ceph has per-fsid indices under the top
>> "ceph" index and then per-inode indices under those?  Are fsids universally
>> unique - or just for a given server/cell/whatever?
>
> It's my understanding that's a guuid assigned to the cluster.
>
>>
>>> +#ifdef CONFIG_CEPH_FSCACHE
>>> +     if (PageFsCache(page))
>>> +             ceph_invalidate_fscache_page(inode, page);
>>> +#endif
>>
>> The PageFsCache() test here should be folded into the header file.  You
>> actually have a redundant test:
>>
>>         +static inline void ceph_invalidate_fscache_page(struct inode *inode,
>>         +                                               struct page *page)
>>         +{
>>         +       if (ceph_inode(inode)->fscache == NULL)
>>         +               return;
>>         +
>>         +       if (PageFsCache(page))
>>         +               return __ceph_invalidate_fscache_page(inode, page);
>>         +}
>>
>>> +#ifdef CONFIG_CEPH_FSCACHE
>>> +     /* Can we release the page from the cache? */
>>> +     if (PageFsCache(page) && ceph_release_fscache_page(page, g) == 0)
>>> +             return 0;
>>> +#endif
>>
>> The PageFsCache() test here is also redundant as fscache_maybe_release_page()
>> also does it - though I acknowledge it does it after doing the "is this cookie
>> valid" test.  The reason I put that test first is that if CONFIG_FSCACHE=n
>> then the "is this cookie valid" test just evaluates immediately to false at
>> compile time.
>>
>>> +void ceph_fscache_inode_get_cookie(struct inode *inode);
>>
>> No such function?
>
> Fixed.
>
>>
>>> +static inline void ceph_fsxache_async_uncache_inode(struct inode* inode)
>>
>> Misspelling?
>
> Fixed.
>
>>
>>> +static inline int ceph_readpage_from_fscache(struct inode *inode,
>>> +                                          struct page *page)
>>> +{
>>> +     if (ceph_inode(inode)->fscache == NULL)
>>> +             return -ENOBUFS;
>>> +
>>> +     return __ceph_readpage_from_fscache(inode, page);
>>> +}
>>
>> Looking at functions like this, if you wrap:
>>
>>         ceph_inode(inode)->fscache
>>
>> as, say:
>>
>>         struct fscache_cookie *ceph_inode_cookie(struct inode *inode)
>>         {
>>         #ifdef CONFIG_CEPH_FSCACHE
>>                 return ceph_inode(inode)->fscache;
>>         #else
>>                 return NULL;
>>         #endif
>>         }
>>
>> then you can get rid of a lot of cpp conditionals and just rely on gcc's
>> optimiser (see what I did in include/linux/fscache.h).  Note that anything in
>> fs/ceph/cache.c wouldn't need to use this.
>
> Per your suggestion I implemented this. This helped me to get rid of
> some of the CONFIG_CEPH_FSCACHE checks (but not all).
>
>>
>>>  static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
>>> ...
>>> +#ifdef CONFIG_CEPH_FSCACHE
>>> +             spin_lock(&ci->i_ceph_lock);
>>> +             ceph_fscache_register_inode_cookie(fsc, ci);
>>> +             spin_unlock(&ci->i_ceph_lock);
>>> +#endif
>>
>> Ummm...  ceph_fscache_register_inode_cookie() calls fscache_acquire_cookie()
>> which allocates GFP_KERNEL and grabs fscache_addremove_sem.  You can't wrap
>> this call in a spinlock.  Do you use lockdep?
>
> I took a look at the nfs code it seams like there isn't any kind of
> locking in nfs_open around acquiring of the cookie. Then looking back
> at Ceph code it seams like extensively locks in the open code. I'm not
> sure if I have open worry about open races.
>
>>
>> David
