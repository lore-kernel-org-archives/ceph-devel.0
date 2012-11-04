From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: [PATCH V2 2/2] ceph: Fix i_size update race
Date: Sun, 4 Nov 2012 21:39:36 +0800
Message-ID: <CAAM7YAnutVLrmxhPhRrywSUjooCu6sE8_MDv=BUbirFBQH3eKQ@mail.gmail.com>
References: <1351905581-14374-1-git-send-email-zheng.z.yan@intel.com>
	<alpine.DEB.2.00.1211040122420.26143@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:43809 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2KDNji convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 08:39:38 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3600299lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 05:39:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211040122420.26143@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Sun, Nov 4, 2012 at 7:29 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Yan,
>
> On Sat, 3 Nov 2012, Yan, Zheng wrote:
>
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> ceph_aio_write() has an optimization that marks cap EPH_CAP_FILE_WR
>> dirty before data is copied to page cache and inode size is updated.
>> If sceph_check_caps() flushes the dirty cap before the inode size is
>> updated, MDS can miss the new inode size. The fix is move
>> ceph_{get,put}_cap_refs() into ceph_write_{begin,end}() and call
>> __ceph_mark_dirty_caps() after inode size is updated.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>
> Hmm, I'm a little worried at the get/put caps sequence inside of
> write_begin/end since that happens on every page... do you think it's
> something to worry about?
>
> The Fw revocation kludge was something we hit in practice.  It looks =
like
> balance_dirty_pages*() happens outside of the write_begin/_end calls =
in
> generic_perform_write(), so that's a win.
>
> Comments below:
>
>> ---
>> Changes since v1
>>  - Fix a cap leak when ceph_write_begin fail to get page
>>
>>  fs/ceph/addr.c | 51 +++++++++++++++++++++++++++++++++++++++----
>>  fs/ceph/file.c | 69 +++++++++++++++++++++++------------------------=
-----------
>>  2 files changed, 74 insertions(+), 46 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 22b6e45..21a0718 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -1078,23 +1078,51 @@ static int ceph_write_begin(struct file *fil=
e, struct address_space *mapping,
>>                           struct page **pagep, void **fsdata)
>>  {
>>       struct inode *inode =3D file->f_dentry->d_inode;
>> +     struct ceph_inode_info *ci =3D ceph_inode(inode);
>> +     struct ceph_file_info *fi =3D file->private_data;
>>       struct page *page;
>>       pgoff_t index =3D pos >> PAGE_CACHE_SHIFT;
>> -     int r;
>> +     int r, want, got =3D 0;
>> +
>> +     if (fi->fmode & CEPH_FILE_MODE_LAZY)
>> +             want =3D CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>> +     else
>> +             want =3D CEPH_CAP_FILE_BUFFER;
>> +
>> +     dout("write_begin %p %llx.%llx %llu~%u getting caps. i_size %l=
lu\n",
>> +          inode, ceph_vinop(inode), pos, len, inode->i_size);
>> +     r =3D ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, pos+len)=
;
>> +     if (r < 0)
>> +             return r;
>> +     dout("write_begin %p %llx.%llx %llu~%u  got cap refs on %s\n",
>> +          inode, ceph_vinop(inode), pos, len, ceph_cap_string(got))=
;
>> +     if (!(got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO))) {
>> +             ceph_put_cap_refs(ci, got);
>> +             return -EAGAIN;
>> +     }
>>
>>       do {
>>               /* get a page */
>>               page =3D grab_cache_page_write_begin(mapping, index, 0=
);
>> -             if (!page)
>> -                     return -ENOMEM;
>> -             *pagep =3D page;
>> +             if (!page) {
>> +                     r =3D -ENOMEM;
>> +                     break;
>> +             }
>>
>>               dout("write_begin file %p inode %p page %p %d~%d\n", f=
ile,
>>                    inode, page, (int)pos, (int)len);
>>
>>               r =3D ceph_update_writeable_page(file, pos, len, page)=
;
>> +             if (r)
>> +                     page_cache_release(page);
>>       } while (r =3D=3D -EAGAIN);
>>
>> +     if (r) {
>> +             ceph_put_cap_refs(ci, got);
>> +     } else {
>> +             *pagep =3D page;
>> +             *(int *)fsdata =3D got;
>> +     }
>>       return r;
>>  }
>>
>> @@ -1108,10 +1136,12 @@ static int ceph_write_end(struct file *file,=
 struct address_space *mapping,
>>                         struct page *page, void *fsdata)
>>  {
>>       struct inode *inode =3D file->f_dentry->d_inode;
>> +     struct ceph_inode_info *ci =3D ceph_inode(inode);
>>       struct ceph_fs_client *fsc =3D ceph_inode_to_client(inode);
>>       struct ceph_mds_client *mdsc =3D fsc->mdsc;
>>       unsigned from =3D pos & (PAGE_CACHE_SIZE - 1);
>>       int check_cap =3D 0;
>> +     int got =3D (unsigned long)fsdata;
>>
>>       dout("write_end file %p inode %p page %p %d~%d (%d)\n", file,
>>            inode, page, (int)pos, (int)copied, (int)len);
>> @@ -1134,6 +1164,19 @@ static int ceph_write_end(struct file *file, =
struct address_space *mapping,
>>       up_read(&mdsc->snap_rwsem);
>>       page_cache_release(page);
>>
>> +     if (copied > 0) {
>> +             int dirty;
>> +             spin_lock(&ci->i_ceph_lock);
>> +             dirty =3D __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR)=
;
>> +             spin_unlock(&ci->i_ceph_lock);
>> +             if (dirty)
>> +                     __mark_inode_dirty(inode, dirty);
>> +     }
>> +
>> +     dout("write_end %p %llx.%llx %llu~%u  dropping cap refs on %s\=
n",
>> +          inode, ceph_vinop(inode), pos, len, ceph_cap_string(got))=
;
>> +     ceph_put_cap_refs(ci, got);
>> +
>>       if (check_cap)
>>               ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY=
, NULL);
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 5840d2a..266f6e0 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -712,63 +712,49 @@ static ssize_t ceph_aio_write(struct kiocb *io=
cb, const struct iovec *iov,
>>       struct ceph_osd_client *osdc =3D
>>               &ceph_sb_to_client(inode->i_sb)->client->osdc;
>>       loff_t endoff =3D pos + iov->iov_len;
>> -     int want, got =3D 0;
>> -     int ret, err;
>> +     int got =3D 0;
>> +     int ret, err, written;
>>
>>       if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>>               return -EROFS;
>>
>>  retry_snap:
>> +     written =3D 0;
>>       if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
>>               return -ENOSPC;
>>       __ceph_do_pending_vmtruncate(inode);
>> -     dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu=
\n",
>> -          inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>> -          inode->i_size);
>> -     if (fi->fmode & CEPH_FILE_MODE_LAZY)
>> -             want =3D CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>> -     else
>> -             want =3D CEPH_CAP_FILE_BUFFER;
>> -     ret =3D ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff=
);
>> -     if (ret < 0)
>> -             goto out_put;
>> -
>> -     dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
>> -          inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>> -          ceph_cap_string(got));
>> -
>> -     if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) =3D=3D=
 0 ||
>
> This check seems to have been dropped... I think we want
>
This was moved into write_begin

>> -         (iocb->ki_filp->f_flags & O_DIRECT) ||
>> -         (inode->i_sb->s_flags & MS_SYNCHRONOUS) ||
>> -         (fi->flags & CEPH_F_SYNC)) {
>> -             ret =3D ceph_sync_write(file, iov->iov_base, iov->iov_=
len,
>> -                     &iocb->ki_pos);
>> -     } else {
>> -             /*
>> -              * buffered write; drop Fw early to avoid slow
>> -              * revocation if we get stuck on balance_dirty_pages
>> -              */
>> -             int dirty;
>> -
>> -             spin_lock(&ci->i_ceph_lock);
>> -             dirty =3D __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR)=
;
>> -             spin_unlock(&ci->i_ceph_lock);
>> -             ceph_put_cap_refs(ci, got);
>>
>> +     if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
>> +         !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
>> +         !(fi->flags & CEPH_F_SYNC)) {
>>               ret =3D generic_file_aio_write(iocb, iov, nr_segs, pos=
);
>> +             if (ret >=3D 0)
>> +                     written =3D ret;
>> +
>>               if ((ret >=3D 0 || ret =3D=3D -EIOCBQUEUED) &&
>>                   ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mappi=
ng->host)
>>                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEA=
RFULL))) {
>> -                     err =3D vfs_fsync_range(file, pos, pos + ret -=
 1, 1);
>> +                     err =3D vfs_fsync_range(file, pos, pos + writt=
en - 1, 1);
>>                       if (err < 0)
>>                               ret =3D err;
>>               }
>> -
>> -             if (dirty)
>> -                     __mark_inode_dirty(inode, dirty);
>> -             goto out;
>> +             if ((ret < 0 && ret !=3D -EAGAIN) || pos + written >=3D=
 endoff)
>> +                     goto out;
>
> This check makes me nervous.  The *only* time we want to jump to the =
sync
> path is when we get -EAGAIN, right?  I'd rather see that branch expli=
citly
> taken immediately after generic_file_aio_write().  I'm not sure when =
we'd
> do a short write in generic_file_aio_write(), but I'm pretty sure we =
don't
> want to fall back to a sync write in that case...
>
Short write happens when we fail to get 'Fb' cap for all pages. Why sho=
uldn't
we fall back to sync write, I think some user programs assume short wri=
te
never happen unless ENOSPC. If generic_file_aio_write return and its re=
turn
value shows there was a short write, I think the dirty pages have alrea=
dy been
flushed to OSD because ceph_get_caps waits revoking 'Fb' cap to complet=
ed.
So I think fall back to sync write is safe.

>>       }
>>
>> +     dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu=
\n",
>> +          inode, ceph_vinop(inode), pos + written,
>> +          (unsigned)iov->iov_len - written, inode->i_size);
>> +     ret =3D ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
>> +     if (ret < 0)
>> +             goto out_put;
>
> We don't want to put if the get failed.
>
> An incremental patch is below.
>
>> +
>> +     dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
>> +          inode, ceph_vinop(inode), pos + written,
>> +          (unsigned)iov->iov_len - written, ceph_cap_string(got));
>> +
>> +     ret =3D ceph_sync_write(file, iov->iov_base + written,
>> +                           iov->iov_len - written, &iocb->ki_pos);
>>       if (ret >=3D 0) {
>>               int dirty;
>>               spin_lock(&ci->i_ceph_lock);
>> @@ -780,10 +766,9 @@ retry_snap:
>>
>>  out_put:
>>       dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\=
n",
>> -          inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>> -          ceph_cap_string(got));
>> +          inode, ceph_vinop(inode), pos + written,
>> +          (unsigned)iov->iov_len - written, ceph_cap_string(got));
>>       ceph_put_cap_refs(ci, got);
>> -
>>  out:
>>       if (ret =3D=3D -EOLDSNAPC) {
>>               dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, re=
trying\n",
>> --
>> 1.7.11.7
>
> How does the below look to you?
>
looks OK. but If you still think we don't want to fall back to sync
write, the variable
=91written' is unnecessary.

> There are a few test programs in ceph.git/qa/workunits/direct_io that=
 try
> to verify the O_DIRECT and sync io paths work.  Have you tested those=
?
> I'll queue this up on our qa cluster shortly.

No,  I only tested "can't get Fb cap" case.

Regards
Yan, Zheng

>
> Thanks!
> sage
>
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 266f6e0..2a94102 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -724,10 +724,16 @@ retry_snap:
>                 return -ENOSPC;
>         __ceph_do_pending_vmtruncate(inode);
>
> +       /*
> +        * try to do a buffered write.  if we don't have sufficient
> +        * caps, we'll get -EAGAIN from generic_file_aio_write.
> +        */
>         if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
>             !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
>             !(fi->flags & CEPH_F_SYNC)) {
>                 ret =3D generic_file_aio_write(iocb, iov, nr_segs, po=
s);
> +               if (ret =3D=3D -EAGAIN)
> +                       goto sync_write;
>                 if (ret >=3D 0)
>                         written =3D ret;
>
> @@ -738,16 +744,16 @@ retry_snap:
>                         if (err < 0)
>                                 ret =3D err;
>                 }
> -               if ((ret < 0 && ret !=3D -EAGAIN) || pos + written >=3D=
 endoff)
> -                       goto out;
> +               goto out;
>         }
>
> +sync_write:
>         dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %ll=
u\n",
>              inode, ceph_vinop(inode), pos + written,
>              (unsigned)iov->iov_len - written, inode->i_size);
>         ret =3D ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
>         if (ret < 0)
> -               goto out_put;
> +               goto out;
>
>         dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
>              inode, ceph_vinop(inode), pos + written,
> @@ -763,8 +769,6 @@ retry_snap:
>                 if (dirty)
>                         __mark_inode_dirty(inode, dirty);
>         }
> -
> -out_put:
>         dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s=
\n",
>              inode, ceph_vinop(inode), pos + written,
>              (unsigned)iov->iov_len - written, ceph_cap_string(got));
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
