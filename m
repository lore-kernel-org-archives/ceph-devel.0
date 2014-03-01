From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: fix ceph_dir_llseek()
Date: Sat, 1 Mar 2014 08:14:55 +0800
Message-ID: <CAAM7YAk+6jo6x0M3Hm1vxpkGaXVDpCORyWK0Xwa6+23m6j3GsQ@mail.gmail.com>
References: <1393492047-18261-1-git-send-email-zheng.z.yan@intel.com>
	<5310978F.2000705@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42292 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbaCAAO4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 19:14:56 -0500
Received: by mail-lb0-f174.google.com with SMTP id u14so2909974lbd.19
        for <ceph-devel@vger.kernel.org>; Fri, 28 Feb 2014 16:14:55 -0800 (PST)
In-Reply-To: <5310978F.2000705@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 28, 2014 at 10:05 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/27/2014 03:07 AM, Yan, Zheng wrote:
>> Comparing offset with inode->i_sb->s_maxbytes doesn't make sense for
>> directory. For a fragmented directory, offset (frag_t, off) can be
>> larger than inode->i_sb->s_maxbytes.
>>
>> At the very beginning of ceph_dir_llseek(), local variable old_offset
>> is initialized to parameter offset. This doesn't make sense neither.
>> Old_offset should be ceph_make_fpos(fi->frag, fi->next_offset).
>
> This looks OK to me, but I'm not as well-versed in the file system
> code as I am in libceph and rbd.  It looks like previously this
> would produce problems if you ever did an llseek on a directory
> that ended up in any fragment but the first.
>
> I have one question/suggestion below, but otherwise:
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/dir.c   | 12 ++++++------
>>  fs/ceph/super.h |  2 +-
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 45eda6d..a7eaf96 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -190,7 +190,7 @@ more:
>>               if (last) {
>>                       /* remember our position */
>>                       fi->dentry = last;
>> -                     fi->next_offset = di->offset;
>> +                     fi->next_offset = fpos_off(di->offset);
>>               }
>>               dput(dentry);
>>               return 0;
>> @@ -369,9 +369,9 @@ more:
>>                               fi->next_offset = 0;
>>                       off = fi->next_offset;
>>               }
>> +             fi->frag = frag;
>>               fi->offset = fi->next_offset;
>>               fi->last_readdir = req;
>> -             fi->frag = frag;
>>
>>               if (req->r_reply_info.dir_end) {
>>                       kfree(fi->last_name);
>> @@ -474,7 +474,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>>  {
>>       struct ceph_file_info *fi = file->private_data;
>>       struct inode *inode = file->f_mapping->host;
>> -     loff_t old_offset = offset;
>> +     loff_t old_offset = ceph_make_fpos(fi->frag, fi->next_offset);
>
> Should this be named "next_offset" (or maybe "current_offset")?
> It doesn't seem "old" to me, though I do realize it doesn't
> necessarily represent where the "next" file position will be.
>

No. next_offset is the position where next readdir request will be.

Regards
Yan, Zheng

>>       loff_t retval;
>>
>>       mutex_lock(&inode->i_mutex);
>> @@ -491,7 +491,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>>               goto out;
>>       }
>>
>> -     if (offset >= 0 && offset <= inode->i_sb->s_maxbytes) {
>> +     if (offset >= 0) {
>>               if (offset != file->f_pos) {
>>                       file->f_pos = offset;
>>                       file->f_version = 0;
>> @@ -504,14 +504,14 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>>                * seek to new frag, or seek prior to current chunk.
>>                */
>>               if (offset == 0 ||
>> -                 fpos_frag(offset) != fpos_frag(old_offset) ||
>> +                 fpos_frag(offset) != fi->frag ||
>>                   fpos_off(offset) < fi->offset) {
>>                       dout("dir_llseek dropping %p content\n", file);
>>                       reset_readdir(fi);
>>               }
>>
>>               /* bump dir_release_count if we did a forward seek */
>> -             if (offset > old_offset)
>> +             if (fpos_cmp(offset, old_offset) > 0)
>>                       fi->dir_release_count--;
>>       }
>>  out:
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index d8801a9..70bb183 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -577,7 +577,7 @@ struct ceph_file_info {
>>
>>       /* readdir: position within a frag */
>>       unsigned offset;       /* offset of last chunk, adjusted for . and .. */
>> -     u64 next_offset;       /* offset of next chunk (last_name's + 1) */
>> +     unsigned next_offset;  /* offset of next chunk (last_name's + 1) */
>>       char *last_name;       /* last entry in previous chunk */
>>       struct dentry *dentry; /* next dentry (for dcache readdir) */
>>       int dir_release_count;
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
