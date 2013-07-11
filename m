From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph:Update the file time after mmap-write.
Date: Thu, 11 Jul 2013 09:42:38 +0800
Message-ID: <CAAM7YA=3stCqYppd6YAwk9tC_rHMzraqge_L6gGZkzaG8LH6Ag@mail.gmail.com>
References: <201307110917146231510@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:41634 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab3GKBmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 21:42:40 -0400
Received: by mail-la0-f50.google.com with SMTP id ep20so1923938lab.9
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 18:42:38 -0700 (PDT)
In-Reply-To: <201307110917146231510@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 11, 2013 at 9:17 AM, majianpeng <majianpeng@gmail.com> wrote:
> Although, mmap-write of ceph update the time of file using
> file_update_time.Because it don't mark the relative cap so the time
> can't save.

I think cephfs' mmap IO support is still broken. mmap IO does not respect
ceph capabilities at all. It's possible that the kclient has no Fw cap when
ceph_page_mkwrite is called.

Yan, Zheng


>
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/addr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 38b5c1b..52f7c7c 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1231,10 +1231,18 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
>
>         ret = ceph_update_writeable_page(vma->vm_file, off, len, page);
>         if (ret == 0) {
> +               int dirty;
> +               struct ceph_inode_info *ci = ceph_inode(inode);
>                 /* success.  we'll keep the page locked. */
>                 set_page_dirty(page);
>                 up_read(&mdsc->snap_rwsem);
>                 ret = VM_FAULT_LOCKED;
> +
> +               spin_lock(&ci->i_ceph_lock);
> +               dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> +               spin_unlock(&ci->i_ceph_lock);
> +               if (dirty)
> +                       __mark_inode_dirty(inode, dirty);
>         } else {
>                 if (ret == -ENOMEM)
>                         ret = VM_FAULT_OOM;
> --
> 1.8.1.2
