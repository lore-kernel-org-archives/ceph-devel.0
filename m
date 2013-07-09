From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 9 Jul 2013 09:04:17 -0400
Message-ID: <CANP1eJE=FWomq_2+MPOXDeTWqLMPrc-bf3gy7CBHc+FGHpNV8g@mail.gmail.com>
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
	<CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com>
	<6424.1373366024@warthog.procyon.org.uk>
	<CANP1eJGg5UY69UK21h8FGcSZKW-yo2ES=AFZ448=_Q-P+x2zxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61760 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab3GINER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 09:04:17 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so12571998iec.36
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 06:04:17 -0700 (PDT)
In-Reply-To: <CANP1eJGg5UY69UK21h8FGcSZKW-yo2ES=AFZ448=_Q-P+x2zxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond.Myklebust@netapp.com, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

David,

On a somewhat related node. The header definition of
fscache_maybe_release_page doesn't seam quite correct. The comment
states it should return true if the page can be freed ... yet when
there's not a cookie or PG_fscache is not set it returns false. This
doesn't seam right, in fact the NFS code wraps this bit in a second
PageFsCache check to make sure to return true.

661 /**
662  * fscache_maybe_release_page - Consider releasing a page,
cancelling a store
663  * @cookie: The cookie representing the cache object
664  * @page: The netfs page that is being cached.
665  * @gfp: The gfp flags passed to releasepage()
666  *
667  * Consider releasing a page for the vmscan algorithm, on behalf
of the netfs's
668  * releasepage() call.  A storage request on the page may cancelled if it is
669  * not currently being processed.
670  *
671  * The function returns true if the page no longer has a storage
request on it,
672  * and false if a storage request is left in place.  If true is
returned, the
673  * page will have been passed to fscache_uncache_page().  If false
is returned
674  * the page cannot be freed yet.
675  */
676 static inline
677 bool fscache_maybe_release_page(struct fscache_cookie *cookie,
678                                 struct page *page,
679                                 gfp_t gfp)
680 {
681         if (fscache_cookie_valid(cookie) && PageFsCache(page))
682                 return __fscache_maybe_release_page(cookie, page, gfp);
683         return false;
684 }

On Tue, Jul 9, 2013 at 8:46 AM, Milosz Tanski <milosz@adfin.com> wrote:
> On Tue, Jul 9, 2013 at 6:33 AM, David Howells <dhowells@redhat.com> wrote:
>> Milosz Tanski <milosz@adfin.com> wrote:
>>
>>> It looks like both the cifs and NFS code do not bother with any
>>> locking around cifs_fscache_set_inode_cookie. Is there no concern over
>>> multiple open() calls racing to create the cookie in those
>>> filesystems?
>>
>> Yeah...  That's probably wrong.  AFS obviates the need for special locking by
>> doing it in afs_iget().
>
> I'm going to create a mutex around the enable cache / disable cache in
> the Ceph code since the spinlock is also right now.
>
>>
>> Hmmm...  I think I've just spotted what might be the cause of pages getting
>> marked PG_fscache whilst belonging to the allocator.
>>
>>         void nfs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
>>         {
>>                 if (NFS_FSCACHE(inode)) {
>>                         nfs_fscache_inode_lock(inode);
>>                         if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>                                 nfs_fscache_disable_inode_cookie(inode);
>>                         else
>>                                 nfs_fscache_enable_inode_cookie(inode);
>>                         nfs_fscache_inode_unlock(inode);
>>                 }
>>         }
>>
>> can release the cookie whilst reads are in progress on it when an inode being
>> read suddenly changes to an inode being written.  We need some sort of
>> synchronisation on that there.
>
> So far my experience has been that synchronization has been the most
> tricky part of implementing fscache for Ceph. Things work great when
> there's a simple shell accessing data and break down when you're doing
> a HPC kind of workload.
>
>>
>> David
