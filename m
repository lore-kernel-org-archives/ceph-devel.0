From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: [PATCH V2 2/2] ceph: Fix i_size update race
Date: Mon, 5 Nov 2012 07:29:57 +0800
Message-ID: <CAAM7YA=EjA3NjpVS=XzBZpVg+nMkJ_uh3cBOBKqOMeu154QxwQ@mail.gmail.com>
References: <1351905581-14374-1-git-send-email-zheng.z.yan@intel.com>
	<alpine.DEB.2.00.1211040122420.26143@cobra.newdream.net>
	<CAAM7YAnutVLrmxhPhRrywSUjooCu6sE8_MDv=BUbirFBQH3eKQ@mail.gmail.com>
	<alpine.DEB.2.00.1211040554140.30792@cobra.newdream.net>
	<CAAM7YAmzOOfCO9FzdRQ9bxkhD44xyT1iOHdWbD-9cYGtP-W=4g@mail.gmail.com>
	<alpine.DEB.2.00.1211040844350.8980@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43021 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2KDX37 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 18:29:59 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so3832322lbo.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 15:29:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211040844350.8980@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Mon, Nov 5, 2012 at 12:45 AM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 4 Nov 2012, Yan, Zheng wrote:
>> >> Short write happens when we fail to get 'Fb' cap for all pages. Why shouldn't
>> >> we fall back to sync write, I think some user programs assume short write
>> >> never happen unless ENOSPC. If generic_file_aio_write return and its return
>> >> value shows there was a short write, I think the dirty pages have already been
>> >> flushed to OSD because ceph_get_caps waits revoking 'Fb' cap to completed.
>> >> So I think fall back to sync write is safe.
>> >
>> > Oh right, I see.
>> >
>> > Thinking about it more, this whole thing makes me nervous.  If we go down
>> > this road, at the very least we need to make sure we loop back to the
>> > buffered path if the ceph_get_caps() in ceph_aio_write() races and gets
>> > BUFFER|LAZYIO after all.
>>
>> But multiple pages write is not atomic even for local filesystem, At least
>> for write through syscall and read through memory map.
>
> Right.
>
> In that case:
>
> ?
>
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 266f6e0..311e463 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -713,7 +713,7 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
>                 &ceph_sb_to_client(inode->i_sb)->client->osdc;
>         loff_t endoff = pos + iov->iov_len;
>         int got = 0;
> -       int ret, err, written;
> +       int ret, err, written, want_buffered;
>
>         if (ceph_snap(inode) != CEPH_NOSNAP)
>                 return -EROFS;
> @@ -724,9 +724,17 @@ retry_snap:
>                 return -ENOSPC;
>         __ceph_do_pending_vmtruncate(inode);
>
> +       /*
> +        * try to do a buffered write.  if we don't have sufficient
> +        * caps, we'll get -EAGAIN from generic_file_aio_write, or a
> +        * short write if we only get caps for some pages.
> +        */
> +buffered_write:
>         if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
>             !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
>             !(fi->flags & CEPH_F_SYNC)) {
> +               want_buffered = 1;
> +
>                 ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
>                 if (ret >= 0)
>                         written = ret;
> @@ -740,6 +748,8 @@ retry_snap:
>                 }
>                 if ((ret < 0 && ret != -EAGAIN) || pos + written >= endoff)
>                         goto out;
> +       } else {
> +               want_buffered = 0;
>         }
>
>         dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
> @@ -747,12 +757,20 @@ retry_snap:
>              (unsigned)iov->iov_len - written, inode->i_size);
>         ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
>         if (ret < 0)
> -               goto out_put;
> +               goto out;
> +       if (want_buffered &&
> +           (got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO))) {
> +               dout("aio_write %p %llx.%llx %llu~%u  got caps refs on %s, "
> +                    "dropping and retrying buffered write\n",
> +                    inode, ceph_vinop(inode), pos + written,
> +                    (unsigned)iov->iov_len - written, ceph_cap_string(got));
> +               ceph_put_cap_refs(ci, got);
> +               goto buffered_write;

iov and pos are not adjusted. rewrite all data again?

I don't why we should retry buffered write here. I think it's ok to do
sync write
when having 'Fb' cap.



> +       }
>
>         dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
>              inode, ceph_vinop(inode), pos + written,
>              (unsigned)iov->iov_len - written, ceph_cap_string(got));
> -
>         ret = ceph_sync_write(file, iov->iov_base + written,
>                               iov->iov_len - written, &iocb->ki_pos);
>         if (ret >= 0) {
> @@ -763,8 +781,6 @@ retry_snap:
>                 if (dirty)
>                         __mark_inode_dirty(inode, dirty);
>         }
> -
> -out_put:
>         dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
>              inode, ceph_vinop(inode), pos + written,
>              (unsigned)iov->iov_len - written, ceph_cap_string(got));
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
