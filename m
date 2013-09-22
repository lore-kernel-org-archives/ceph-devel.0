From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH V4 1/2] ceph: Implement readv/preadv for sync operation.
Date: Sun, 22 Sep 2013 12:17:01 +0800
Message-ID: <523E6F3D.2060708@intel.com>
References: <201309121325129235088@gmail.com>,  <CAAM7YAkCQ1Jkd9B=C4mZT0109=-LXPcBYSo34j2EA4QMsmky5Q@mail.gmail.com> <201309221100079637870@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33508 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab3IVERI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 Sep 2013 00:17:08 -0400
In-Reply-To: <201309221100079637870@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/22/2013 11:00 AM, majianpeng wrote:
>> On Thu, Sep 12, 2013 at 1:25 PM, majianpeng <majianpeng@gmail.com> wrote:
>>> For readv/preadv sync-operatoin, ceph only do the first iov.
>>> It don't think other iovs.Now implement this.
>>>
>>> V4:
>>>         modify one bug.
>>> V3:
>>>    modify some bug.
>>> V2:
>>>   -add generic_segment_checks
>>>   -using struct iov_iter replace cloning the iovs.
>>>   -return previous successfully copied if ceph_copy_page_vector_to_user
>>>    met error.
>>>
>>>
>>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>>> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
>>> ---
>>>   fs/ceph/file.c | 157 ++++++++++++++++++++++++++++++++++++++-------------------
>>>  1 file changed, 106 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 3de8982..bc7fa52 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -408,51 +408,94 @@ more:
>>>   *
>>>   * If the read spans object boundary, just do multiple reads.
>>>   */
>>> -static ssize_t ceph_sync_read(struct file *file, char __user *data,
>>> -                             unsigned len, loff_t *poff, int *checkeof)
>>> +static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
>>> +                               int *checkeof)
>>>  {
>>> +       struct file *file = iocb->ki_filp;
>>>         struct inode *inode = file_inode(file);
>>>         struct page **pages;
>>> -       u64 off = *poff;
>>> +       u64 off = iocb->ki_pos;
>>>         int num_pages, ret;
>>>
>>> -       dout("sync_read on file %p %llu~%u %s\n", file, off, len,
>>> +       dout("sync_read on file %p %llu~%u %s\n", file, off,
>>> +            (unsigned)iocb->ki_left,
>>>              (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>>> -
>>> -       if (file->f_flags & O_DIRECT) {
>>> -               num_pages = calc_pages_for((unsigned long)data, len);
>>> -               pages = ceph_get_direct_page_vector(data, num_pages, true);
>>> -       } else {
>>> -               num_pages = calc_pages_for(off, len);
>>> -               pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
>>> -       }
>>> -       if (IS_ERR(pages))
>>> -               return PTR_ERR(pages);
>>> -
>>>         /*
>>>          * flush any page cache pages in this range.  this
>>>          * will make concurrent normal and sync io slow,
>>>          * but it will at least behave sensibly when they are
>>>          * in sequence.
>>>          */
>>> -       ret = filemap_write_and_wait(inode->i_mapping);
>>> +       ret = filemap_write_and_wait_range(inode->i_mapping, off,
>>> +                                               off + iocb->ki_left);
>>>         if (ret < 0)
>>> -               goto done;
>>> -
>>> -       ret = striped_read(inode, off, len, pages, num_pages, checkeof,
>>> -                          file->f_flags & O_DIRECT,
>>> -                          (unsigned long)data & ~PAGE_MASK);
>>> +               return ret;
>>>
>>> -       if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
>>> -               ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
>>> -       if (ret >= 0)
>>> -               *poff = off + ret;
>>> +       if (file->f_flags & O_DIRECT) {
>>> +               while (iov_iter_count(i)) {
>>> +                       void __user *data = i->iov[0].iov_base + i->iov_offset;
>>> +                       size_t len = i->iov[0].iov_len - i->iov_offset;
>>> +
>>> +                       num_pages = calc_pages_for((unsigned long)data, len);
>>> +                       pages = ceph_get_direct_page_vector(data,
>>> +                                                           num_pages, true);
>>> +                       if (IS_ERR(pages))
>>> +                               return PTR_ERR(pages);
>>> +
>>> +                       ret = striped_read(inode, off, len,
>>> +                                          pages, num_pages, checkeof,
>>> +                                          1, (unsigned long)data & ~PAGE_MASK);
>>> +                       ceph_put_page_vector(pages, num_pages, true);
>>> +
>>> +                       if (ret <= 0)
>>> +                               break;
>>> +                       off += ret;
>>> +                       iov_iter_advance(i, ret);
>>> +                       if (ret < len)
>>> +                               break;
>>> +               }
>>> +       } else {
>>> +               size_t len = iocb->ki_left;
>>>
>>> -done:
>>> -       if (file->f_flags & O_DIRECT)
>>> -               ceph_put_page_vector(pages, num_pages, true);
>>> -       else
>>> +               num_pages = calc_pages_for(off, len);
>>> +               pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
>>> +               if (IS_ERR(pages))
>>> +                       return PTR_ERR(pages);
>>> +               ret = striped_read(inode, off, len, pages,
>>> +                                       num_pages, checkeof, 0, 0);
>>> +               if (ret > 0) {
>>> +                       int l, k = 0;
>>> +                       size_t left = len = ret;
>>> +
>>> +                       while (left) {
>>> +                               void __user *data = i->iov[0].iov_base
>>> +                                                       + i->iov_offset;
>>> +                               l = min(i->iov[0].iov_len - i->iov_offset,
>>> +                                       left);
>>> +
>>> +                               ret = ceph_copy_page_vector_to_user(&pages[k],
>>> +                                                                   data, off,
>>> +                                                                   l);
>>> +                               if (ret > 0) {
>>> +                                       iov_iter_advance(i, ret);
>>> +                                       left -= ret;
>>> +                                       off += ret;
>>> +                                       k = calc_pages_for(iocb->ki_pos,
>>> +                                                          len - left + 1) - 1;
>>> +                                       BUG_ON(k >= num_pages && left);
>>> +                               } else
>>> +                                       break;
>>> +                       }
>>> +               }
>>>                 ceph_release_page_vector(pages, num_pages);
>>> +       }
>>> +
>>> +       if (off > iocb->ki_pos) {
>>> +               ret = off - iocb->ki_pos;
>>> +               iocb->ki_pos = off;
>>> +               iocb->ki_left -= ret;
>>> +       }
>>> +
>>>         dout("sync_read result %d\n", ret);
>>>         return ret;
>>>  }
>>> @@ -647,55 +690,67 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>>>  {
>>>         struct file *filp = iocb->ki_filp;
>>>         struct ceph_file_info *fi = filp->private_data;
>>> -       loff_t *ppos = &iocb->ki_pos;
>>> -       size_t len = iov->iov_len;
>>> +       size_t len = 0;
>>>         struct inode *inode = file_inode(filp);
>>>         struct ceph_inode_info *ci = ceph_inode(inode);
>>> -       void __user *base = iov->iov_base;
>>>         ssize_t ret;
>>>         int want, got = 0;
>>>         int checkeof = 0, read = 0;
>>>
>>>         dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>>>              inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>>> -again:
>>> +
>>> +       ret = generic_segment_checks(iov, &nr_segs, &len, VERIFY_WRITE);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>>         if (fi->fmode & CEPH_FILE_MODE_LAZY)
>>>                 want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
>>>         else
>>>                 want = CEPH_CAP_FILE_CACHE;
>>>         ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
>>>         if (ret < 0)
>>> -               goto out;
>>> +               return ret;
>>> +
>>>         dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
>>>              inode, ceph_vinop(inode), pos, (unsigned)len,
>>>              ceph_cap_string(got));
>>>
>>>         if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
>>>             (iocb->ki_filp->f_flags & O_DIRECT) ||
>>> -           (fi->flags & CEPH_F_SYNC))
>>> +           (fi->flags & CEPH_F_SYNC)) {
>>> +               struct iov_iter i;
>>> +
>>> +               iocb->ki_left = len;
>>> +               iov_iter_init(&i, iov, nr_segs, len, 0);
>>> +again:
>>>                 /* hmm, this isn't really async... */
>>> -               ret = ceph_sync_read(filp, base, len, ppos, &checkeof);
>>> -       else
>>> +               ret = ceph_sync_read(iocb, &i, &checkeof);
>>> +
>>> +               if (checkeof && ret >= 0) {
>>> +                       int statret = ceph_do_getattr(inode,
>>> +                                                     CEPH_STAT_CAP_SIZE);
>>
>> It's wrong to move getattr to here. because getattr while holding Fr
>> cap can cause hang.
>>
>> Regards
>> Yan, Zheng
>>
> Hi,
> 	Can you explain in detail?


getattr need to "read lock" inode's filelock. But the lock can be in unstable state.
the getattr request waits for lock's state to become stable, the lock waits for client
to release Fr cap.

your patches are already in master branch of ceph-client, please send incremental patch
to fix the issue.

Regards
Yan, Zheng.


> 
> Thanks!
> Jianpeng Ma
> 

