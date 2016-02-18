From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] add CephFS support in VirtFS
Date: Thu, 18 Feb 2016 09:36:56 +0800
Message-ID: <56C52038.5020107@gmail.com>
References: <56C00B60.6000502@gmail.com> <20160215091727.GB3105@redhat.com>
 <56C421F6.1000102@gmail.com> <20160217090141.634fb0bc@bahia.huguette.org>
 <56C4341D.70409@gmail.com> <20160217100450.1938bd79@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33801 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424276AbcBRBhA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 20:37:00 -0500
Received: by mail-pf0-f195.google.com with SMTP id 71so1423373pfv.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 17:36:59 -0800 (PST)
In-Reply-To: <20160217100450.1938bd79@bahia.huguette.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, qemu-devel@nongnu.org, haomaiwang@gmail.com, mst@redhat.com, aneesh.kumar@linux.vnet.ibm.com, Sage Weil <sage@newdream.net>, gfarnum@redhat.com


On 17/2/16 17:04, Greg Kurz wrote:
> On Wed, 17 Feb 2016 16:49:33 +0800
> Jevon Qiao <scaleqiao@gmail.com> wrote:
>
>> On 17/2/16 16:01, Greg Kurz wrote:
>>> On Wed, 17 Feb 2016 15:32:06 +0800
>>> Jevon Qiao <scaleqiao@gmail.com> wrote:
>>>   
>>>> Hi Daniel,
>>>>
>>>> Thank you for reviewing my code, please see my reply in-line.
>>>> On 15/2/16 17:17, Daniel P. Berrange wrote:
>>>>> On Sun, Feb 14, 2016 at 01:06:40PM +0800, Jevon Qiao wrote:
>>>>>> diff --git a/configure b/configure
>>>>>> index 83b40fc..cecece7 100755
>>>>>> --- a/configure
>>>>>> +++ b/configure
>>>>>> @@ -1372,6 +1377,7 @@ disabled with --disable-FEATURE, default is enabled if
>>>>>> available:
>>>>>>       vhost-net       vhost-net acceleration support
>>>>>>       spice           spice
>>>>>>       rbd             rados block device (rbd)
>>>>>> +  cephfs      Ceph File System
>>>>> Inconsistent vertical alignment with surrounding text
>>>> This is just a display issue, I'll send the patch with 'git send-email'
>>>> later after I address all the technical comments.
>>> Expect reviewers to always comment on broken formatting. If you want the
>>> review to be focused on technical aspects, the best choice is to fix the
>>> way you send patches first.
>> OK, I'll re-send the patches first.
>>
> I don't ask you to resend this patch without the fixes. I just
> wanted to put emphasis on the fact that correct formatting is
> the first thing to have in mind before sending patches, not
> just a "display issue".
Yes, I understand. I'll resend the patch with the fix which at least 
addresses Daniel's comments.
> BTW, I had also answered your questions about g_new0() and a
> tool to check coding style... not sure you saw that.
Sorry, I missed that part due to the long email:-( . I read it now, 
thank you for the answers.

Thanks,
Jevon
> Cheers.
>
> --
> Greg
>
>> Thanks,
>> Jevon
>>>>>>       libiscsi        iscsi support
>>>>>>       libnfs          nfs support
>>>>>>       smartcard       smartcard support (libcacard)
>>>>>> +/*
>>>>>> + * Helper function for cephfs_preadv and cephfs_pwritev
>>>>>> + */
>>>>>> +inline static ssize_t preadv_pwritev(struct ceph_mount_info *cmount, int
>>>>>> fd,
>>>>> Your email client is mangling long lines, here and in many other
>>>>> places in the file. Please either fix your email client to not
>>>>> insert arbitrary line breaks, or use git send-email to submit
>>>>> the patch.
>>>> Ditto.
>>>>>> +                              const struct iovec *iov, int iov_cnt,
>>>>>> +                              off_t offset, bool do_write)
>>>>>> +{
>>>>>> +    ssize_t ret = 0;
>>>>>> +    int i = 0;
>>>>> Use size_t for iterators
>>>> I'll revise the code.
>>>>>> +    size_t len = 0;
>>>>>> +    void *buf, *buftmp;
>>>>>> +    size_t bufoffset = 0;
>>>>>> +
>>>>>> +    for (; i < iov_cnt; i++) {
>>>>>> +        len += iov[i].iov_len;
>>>>>> +    }
>>>>> iov_size() does this calculation
>>>> Thanks for the suggestion.
>>>>>> +
>>>>>> +    buf = malloc(len);
>>>>> Use g_new0(uint8_t, len)
>>>> OK.
>>>>>> +    if (buf == NULL) {
>>>>>> +        errno = ENOMEM;
>>>>>> +        return -1;
>>>>>> +    }
>>>>> and don't check ENOMEM;
>>>> Any reason for this?
>>> https://developer.gnome.org/glib/unstable/glib-Memory-Allocation.html
>>>   
>>>>>> +
>>>>>> +    i = 0;
>>>>>> +    buftmp = buf;
>>>>>> +    if (do_write) {
>>>>>> +        for (i = 0; i < iov_cnt; i++) {
>>>>>> +            memcpy((buftmp + bufoffset), iov[i].iov_base, iov[i].iov_len);
>>>>>> +            bufoffset += iov[i].iov_len;
>>>>>> +        }
>>>>>> +        ret = ceph_write(cmount, fd, buf, len, offset);
>>>>>> +        if (ret <= 0) {
>>>>>> +           errno = -ret;
>>>>>> +           ret = -1;
>>>>>> +        }
>>>>>> +    } else {
>>>>>> +        ret = ceph_read(cmount, fd, buf, len, offset);
>>>>>> +        if (ret <= 0) {
>>>>>> +            errno = -ret;
>>>>>> +            ret = -1;
>>>>>> +        } else {
>>>>>> +            for (i = 0; i < iov_cnt; i++) {
>>>>>> +                memcpy(iov[i].iov_base, (buftmp + bufoffset),
>>>>>> iov[i].iov_len);
>>>>> Mangled long line again.
>>>> That's the email client issue.
>>>>>> +                bufoffset += iov[i].iov_len;
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    free(buf);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_update_file_cred(struct ceph_mount_info *cmount,
>>>>>> +                   const char *name, FsCred *credp)
>>>>> Align the parameters on following line to the '('
>>>> I will revise the code.
>>>>>> +{
>>>>>> +    int fd, ret;
>>>>>> +    fd = ceph_open(cmount, name, O_NONBLOCK | O_NOFOLLOW, credp->fc_mode);
>>>>>> +    if (fd < 0) {
>>>>>> +        return fd;
>>>>>> +    }
>>>>>> +    ret = ceph_fchown(cmount, fd, credp->fc_uid, credp->fc_gid);
>>>>>> +    if (ret < 0) {
>>>>>> +        goto err_out;
>>>>>> +    }
>>>>>> +    ret = ceph_fchmod(cmount, fd, credp->fc_mode & 07777);
>>>>>> +err_out:
>>>>>> +    close(fd);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_lstat(FsContext *fs_ctx, V9fsPath *fs_path,
>>>>>> +                        struct stat *stbuf)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_lstat");
>>>>> All of these D_CEPHFS() lines you have are really inserting trace
>>>>> points, so you should really use the QEMU trace facility instead
>>>>> of a fprintf() based macro. ie add to trace-events and then
>>>>> call the generated trace fnuction for your event. Then get rid
>>>>> of your D_CEPHFS macro.
>>>> I will revise the code.
>>>>>> +    int ret;
>>>>>> +    char *path = fs_path->data;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>> fs_ctx->private is 'void *' so you don't need the (struct cephfs_data *)
>>>>> cast there - 'void *' casts to anything automatically. The same issue
>>>>> in all the other functions below too.
>>>> OK, I see.
>>>>>> +    ret = ceph_lstat(cfsdata->cmount, path, stbuf);
>>>>>> +    if (ret){
>>>>>> +        errno = -ret;
>>>>>> +        ret = -1;
>>>>>> +    }
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t cephfs_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
>>>>>> +                               char *buf, size_t bufsz)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_readlink");
>>>>>> +    int ret;
>>>>>> +    char *path = fs_path->data;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_readlink(cfsdata->cmount, path, buf, bufsz);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_close(FsContext *ctx, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_close");
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
>>>>>> +
>>>>>> +    return ceph_close(cfsdata->cmount, fs->fd);
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_closedir(FsContext *ctx, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_closedir");
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
>>>>>> +
>>>>>> +    return ceph_closedir(cfsdata->cmount, (struct ceph_dir_result
>>>>>> *)fs->dir);
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_open(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                       int flags, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_open");
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    fs->fd = ceph_open(cfsdata->cmount, fs_path->data, flags, 0777);
>>>>>> +    return fs->fd;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_opendir(FsContext *ctx,
>>>>>> +                          V9fsPath *fs_path, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_opendir");
>>>>>> +    int ret;
>>>>>> +    //char buffer[PATH_MAX];
>>>>> Remove this if its really not needed
>>>> Sure.
>>>>>> +    struct ceph_dir_result *result;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
>>>>>> +    char *path = fs_path->data;
>>>>>> +
>>>>>> +    ret = ceph_opendir(cfsdata->cmount, path, &result);
>>>>>> +    if (ret) {
>>>>>> +        fprintf(stderr, "ceph_opendir=%d\n", ret);
>>>>> Don't put in bare printfs in the code.
>>>> OK, I'll revise the code.
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +    fs->dir = (DIR *)result;
>>>>>> +    if (!fs->dir) {
>>>>>> +        fprintf(stderr, "ceph_opendir return NULL for ceph_dir_result\n");
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void cephfs_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_rewinddir");
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    return ceph_rewinddir(cfsdata->cmount, (struct ceph_dir_result
>>>>>> *)fs->dir);
>>>>>> +}
>>>>>> +
>>>>>> +static off_t cephfs_telldir(FsContext *ctx, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_telldir");
>>>>>> +    int ret;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_telldir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
>>>>>> +                            struct dirent *entry,
>>>>>> +                            struct dirent **result)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_readdir_r");
>>>>>> +    int ret;
>>>>>> +    struct dirent *tmpent;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    tmpent = entry;
>>>>>> +    ret = ceph_readdir_r(cfsdata->cmount, (struct ceph_dir_result
>>>>>> *)fs->dir,
>>>>>> +                entry);
>>>>>> +    if (ret > 0 && entry != NULL)
>>>>>> +    {
>>>>>> +        *result = entry;
>>>>>> +    } else if (!ret)
>>>>>> +    {
>>>>>> +        *result = NULL;
>>>>>> +        entry = tmpent;
>>>>>> +    }
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static void cephfs_seekdir(FsContext *ctx, V9fsFidOpenState *fs, off_t off)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_seekdir");
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    return ceph_seekdir(cfsdata->cmount, (struct ceph_dir_result*)fs->dir,
>>>>>> off);
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t cephfs_preadv(FsContext *ctx, V9fsFidOpenState *fs,
>>>>>> +                             const struct iovec *iov,
>>>>>> +                             int iovcnt, off_t offset)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_preadv");
>>>>>> +    ssize_t ret = 0;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >=
>>>>>> LIBCEPHFS_VERSION(9,
>>>>>> +    0, 3)
>>>>>> +    ret = ceph_preadv(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
>>>>>> +#else
>>>>>> +    if (iovcnt > 1) {
>>>>>> +    ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 0);
>>>>>> +    } else if (iovcnt > 0) {
>>>>>> +    ret = ceph_read(cfsdata->cmount, fs->fd, iov[0].iov_base,
>>>>>> +            iov[0].iov_len, offset);
>>>>>> +    }
>>>>> Indent lines inside the if() statement
>>>> That's a display issue, I will fix the format by sending patches with
>>>> 'git send-email'
>>>>>> +#endif
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t cephfs_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
>>>>>> +                              const struct iovec *iov,
>>>>>> +                              int iovcnt, off_t offset)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_pwritev");
>>>>>> +    ssize_t ret = 0;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >=
>>>>>> LIBCEPHFS_VERSION(9,
>>>>>> +    0, 3)
>>>>>> +    ret = ceph_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
>>>>>> +#else
>>>>>> +    if (iovcnt > 1) {
>>>>>> +    ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 1);
>>>>>> +    } else if (iovcnt > 0) {
>>>>>> +    ret = ceph_write(cfsdata->cmount, fs->fd, iov[0].iov_base,
>>>>>> +            iov[0].iov_len, offset);
>>>>>> +    }
>>>>> Indent lines inside the if() statement
>>>> Ditto.
>>>>>> +#endif
>>>>>> +
>>>>>> +#ifdef CONFIG_SYNC_FILE_RANGE
>>>>>> +    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
>>>>>> +        /*
>>>>>> +         * Initiate a writeback. This is not a data integrity sync.
>>>>>> +         * We want to ensure that we don't leave dirty pages in the cache
>>>>>> +         * after write when writeout=immediate is sepcified.
>>>>>> +         */
>>>>>> +        sync_file_range(fs->fd, offset, ret,
>>>>>> +                        SYNC_FILE_RANGE_WAIT_BEFORE |
>>>>>> SYNC_FILE_RANGE_WRITE);
>>>>>> +    }
>>>>>> +#endif
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred
>>>>>> *credp)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_chmod");
>>>>>> +    int  ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_chmod(cfsdata->cmount, fs_path->data, credp->fc_mode);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
>>>>>> +                       const char *name, FsCred *credp)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_mknod");
>>>>>> +    int ret;
>>>>>> +    V9fsString fullname;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&fullname);
>>>>>> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
>>>>>> +    ret = ceph_mknod(cfsdata->cmount, fullname.data, credp->fc_mode,
>>>>>> +            credp->fc_rdev);
>>>>>> +
>>>>>> +    v9fs_string_free(&fullname);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
>>>>>> +                       const char *name, FsCred *credp)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_mkdir");
>>>>>> +    int ret;
>>>>>> +    V9fsString fullname;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&fullname);
>>>>>> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
>>>>>> +    ret = ceph_mkdir(cfsdata->cmount, fullname.data, credp->fc_mode);
>>>>>> +
>>>>>> +    v9fs_string_free(&fullname);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_fstat(FsContext *fs_ctx, int fid_type,
>>>>>> +                        V9fsFidOpenState *fs, struct stat *stbuf)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_fstat");
>>>>>> +    int fd = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    if (fid_type == P9_FID_DIR) {
>>>>>> +        fd = dirfd(fs->dir);
>>>>>> +    } else {
>>>>>> +        fd = fs->fd;
>>>>>> +    }
>>>>>> +    return ceph_fstat(cfsdata->cmount, fd, stbuf);
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char
>>>>>> *name,
>>>>>> +                        int flags, FsCred *credp, V9fsFidOpenState *fs)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_open2");
>>>>>> +    int fd = -1, ret = -1;
>>>>>> +    V9fsString fullname;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&fullname);
>>>>>> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
>>>>>> +    fd = ceph_open(cfsdata->cmount, fullname.data, flags, credp->fc_mode);
>>>>>> +    if (fd >= 0) {
>>>>>> +        /* After creating the file, need to set the cred */
>>>>>> +        ret = cephfs_update_file_cred(cfsdata->cmount, name, credp);
>>>>>> +        if (ret < 0) {
>>>>>> +            ceph_close(cfsdata->cmount, fd);
>>>>>> +            errno = -ret;
>>>>>> +            fd = ret;
>>>>>> +        } else {
>>>>>> +            fs->fd = fd;
>>>>>> +        }
>>>>>> +    } else {
>>>>>> +       errno = -fd;
>>>>>> +    }
>>>>>> +
>>>>>> +    v9fs_string_free(&fullname);
>>>>>> +    return fd;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_symlink(FsContext *fs_ctx, const char *oldpath,
>>>>>> +                          V9fsPath *dir_path, const char *name, FsCred
>>>>>> *credp)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_symlink");
>>>>>> +    int ret = -1;
>>>>>> +    V9fsString fullname;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&fullname);
>>>>>> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
>>>>>> +    ret = ceph_symlink(cfsdata->cmount, oldpath, fullname.data);
>>>>>> +
>>>>>> +    v9fs_string_free(&fullname);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_link(FsContext *ctx, V9fsPath *oldpath,
>>>>>> +                       V9fsPath *dirpath, const char *name)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_link");
>>>>>> +    int ret = -1;
>>>>>> +    V9fsString newpath;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&newpath);
>>>>>> +    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
>>>>>> +    ret = ceph_link(cfsdata->cmount, oldpath->data, newpath.data);
>>>>>> +
>>>>>> +    v9fs_string_free(&newpath);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_truncate");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_truncate(cfsdata->cmount, fs_path->data, size);
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_rename(FsContext *ctx, const char *oldpath,
>>>>>> +                         const char *newpath)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_rename");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_rename(cfsdata->cmount, oldpath, newpath);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred
>>>>>> *credp)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_chown");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_chown(cfsdata->cmount, fs_path->data, credp->fc_uid,
>>>>>> +            credp->fc_gid);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_utimensat(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                            const struct timespec *buf)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_utimensat");
>>>>>> +    int ret = -1;
>>>>>> +
>>>>>> +#ifdef CONFIG_UTIMENSAT
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_utime(cfsdata->cmount, fs_path->data, (struct utimbuf
>>>>>> *)buf);
>>>>>> +#else
>>>>>> +    ret = -1;
>>>>>> +    errno = ENOSYS;
>>>>>> +#endif
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_remove(FsContext *ctx, const char *path)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_remove");
>>>>>> +    errno = EOPNOTSUPP;
>>>>>> +    return -1;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_fsync(FsContext *ctx, int fid_type,
>>>>>> +                        V9fsFidOpenState *fs, int datasync)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_fsync");
>>>>>> +    int ret = -1, fd = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    if (fid_type == P9_FID_DIR) {
>>>>>> +        fd = dirfd(fs->dir);
>>>>>> +    } else {
>>>>>> +        fd = fs->fd;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = ceph_fsync(cfsdata->cmount, fd, datasync);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_statfs(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                         struct statfs *stbuf)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_statfs");
>>>>>> +    int ret;
>>>>>> +    char *path = fs_path->data;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_statfs(cfsdata->cmount, path, (struct statvfs*)stbuf);
>>>>>> +    if (ret) {
>>>>>> +        fprintf(stderr, "ceph_statfs=%d\n", ret);
>>>>>> +    }
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Get the extended attribute of normal file, if the path refer to a
>>>>>> symbolic
>>>>>> + * link, just return the extended attributes of the syslink rather than the
>>>>>> + * attributes of the link itself.
>>>>>> + */
>>>>>> +static ssize_t cephfs_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                                const char *name, void *value, size_t size)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_lgetxattr");
>>>>>> +    int ret;
>>>>>> +    char *path = fs_path->data;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_lgetxattr(cfsdata->cmount, path, name, value, size);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t cephfs_llistxattr(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                                 void *value, size_t size)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_llistxattr");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_llistxattr(cfsdata->cmount, fs_path->data, value, size);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const char
>>>>>> *name,
>>>>>> +                            void *value, size_t size, int flags)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_lsetxattr");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_lsetxattr(cfsdata->cmount, fs_path->data, name, value, size,
>>>>>> +    flags);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
>>>>>> +                               const char *name)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_lremovexattr");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_lremovexattr(cfsdata->cmount, fs_path->data, name);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_name_to_path(FsContext *ctx, V9fsPath *dir_path,
>>>>>> +                              const char *name, V9fsPath *target)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_name_to_path");
>>>>>> +    if (dir_path) {
>>>>>> +        v9fs_string_sprintf((V9fsString *)target, "%s/%s",
>>>>>> +                            dir_path->data, name);
>>>>>> +    } else {
>>>>>> +        /* if the path does not start from '/' */
>>>>>> +        v9fs_string_sprintf((V9fsString *)target, "%s", name);
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Bump the size for including terminating NULL */
>>>>>> +    target->size++;
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_renameat(FsContext *ctx, V9fsPath *olddir,
>>>>>> +                           const char *old_name, V9fsPath *newdir,
>>>>>> +                           const char *new_name)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_renameat");
>>>>>> +    int ret = -1;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    ret = ceph_rename(cfsdata->cmount, old_name, new_name);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_unlinkat(FsContext *ctx, V9fsPath *dir,
>>>>>> +                           const char *name, int flags)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_unlinkat");
>>>>>> +    int ret = 0;
>>>>>> +    char *path = dir->data;
>>>>>> +    struct stat fstat;
>>>>>> +    V9fsString fullname;
>>>>>> +    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
>>>>>> +
>>>>>> +    v9fs_string_init(&fullname);
>>>>>> +    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
>>>>>> +    path = fullname.data;
>>>>>> +    /* determine which kind of file is being destroyed */
>>>>>> +    ret = ceph_lstat(cfsdata->cmount, path, &fstat);
>>>>>> +    if (!ret) {
>>>>>> +        switch (fstat.st_mode & S_IFMT) {
>>>>>> +        case S_IFDIR:
>>>>>> +            ret = ceph_rmdir(cfsdata->cmount, path);
>>>>>> +            break;
>>>>>> +
>>>>>> +        case S_IFBLK:
>>>>>> +        case S_IFCHR:
>>>>>> +        case S_IFIFO:
>>>>>> +        case S_IFLNK:
>>>>>> +        case S_IFREG:
>>>>>> +        case S_IFSOCK:
>>>>>> +            ret = ceph_unlink(cfsdata->cmount, path);
>>>>>> +            break;
>>>>>> +
>>>>>> +        default:
>>>>>> +            fprintf(stderr, "ceph_lstat unknown stmode\n");
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    } else {
>>>>>> +        errno = -ret;
>>>>>> +        ret = -1;
>>>>>> +    }
>>>>>> +
>>>>>> +    v9fs_string_free(&fullname);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Do two things in the init function:
>>>>>> + * 1) Create a mount handle used by all cephfs interfaces.
>>>>>> + * 2) Invoke ceph_mount() to initialize a link between the client and
>>>>>> + *    ceph monitor
>>>>>> + */
>>>>>> +static int cephfs_init(FsContext *ctx)
>>>>>> +{
>>>>>> +    D_CEPHFS("cephfs_init");
>>>>>> +    int ret;
>>>>>> +    const char *ver = NULL;
>>>>>> +    struct cephfs_data *data = g_malloc(sizeof(struct cephfs_data));
>>>>>> +
>>>>>> +    if (data == NULL) {
>>>>>> +    errno = ENOMEM;
>>>>>> +    return -1;
>>>>>> +    }
>>>>>> +    memset(data, 0, sizeof(struct cephfs_data));
>>>>>> +    ret = ceph_create(&data->cmount, NULL);
>>>>>> +    if (ret) {
>>>>>> +        fprintf(stderr, "ceph_create=%d\n", ret);
>>>>>> +        goto err_out;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = ceph_conf_read_file(data->cmount, NULL);
>>>>>> +    if (ret) {
>>>>>> +        fprintf(stderr, "ceph_conf_read_file=%d\n", ret);
>>>>>> +        goto err_out;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = ceph_mount(data->cmount, ctx->fs_root);
>>>>>> +    if (ret) {
>>>>>> +        fprintf(stderr, "ceph_mount=%d\n", ret);
>>>>>> +        goto err_out;
>>>>>> +    } else {
>>>>>> +        ctx->private = data;
>>>>>> +    /* CephFS does not support FS_IOC_GETVERSIO */
>>>>>> +    ctx->exops.get_st_gen = NULL;
>>>>> Bad indent.
>>>>>      
>>>>>> +        goto out;
>>>>>> +    }
>>>>>> +
>>>>>> +    ver = ceph_version(&data->major, &data->minor, &data->patch);
>>>>>> +    memcpy(data->ceph_version, ver, strlen(ver) + 1);
>>>>>> +
>>>>>> +err_out:
>>>>>> +    g_free(data);
>>>>>> +out:
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cephfs_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
>>>>>> +{
>>>>>> +    const char *sec_model = qemu_opt_get(opts, "security_model");
>>>>>> +    const char *path = qemu_opt_get(opts, "path");
>>>>>> +
>>>>>> +    if (!sec_model) {
>>>>>> +        fprintf(stderr, "Invalid argument security_model specified with "
>>>>>> +        "cephfs fsdriver\n");
>>>>> Bad indent.
>>>> BTW, is there any tool I can use to check the coding style in Qemu?
>>>>   
>>> ./scripts/checkpatch.pl is your friend.
>>>
>>>   
>>>> Thanks,
>>>> Jevon
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!path) {
>>>>>> +        fprintf(stderr, "fsdev: No path specified.\n");
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +
>>>>>> +    fse->path = g_strdup(path);
>>>>>> +    return 0;
>>>>>> +}
>>>>> Regards,
>>>>> Daniel

