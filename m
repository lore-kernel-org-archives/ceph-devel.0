From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't NULL terminate virtual xattrs
Date: Tue, 25 Jun 2019 21:29:12 +0800
Message-ID: <CAAM7YAnAhuLK8byaaNGvrC0dO=9enp-E=OP+_dD6O+EucXoiXQ@mail.gmail.com>
References: <20190624162726.17413-1-jlayton@kernel.org> <20190624162726.17413-4-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624162726.17413-4-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Tue, Jun 25, 2019 at 4:18 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> The convention with xattrs is to not store the termination with string
> data, given that it returns the length. This is how setfattr/getfattr
> operate.
>
> Most of ceph's virtual xattr routines use snprintf to plop the string
> directly into the destination buffer, but snprintf always NULL
> terminates the string. This means that if we send the kernel a buffer
> that is the exact length needed to hold the string, it'll end up
> truncated.
>
> Add a ceph_fmt_xattr helper function to format the string into an
> on-stack buffer that is should always be large enough to hold the whole
> thing and then memcpy the result into the destination buffer. If it does
> turn out that the formatted string won't fit in the on-stack buffer,
> then return -E2BIG and do a WARN_ONCE().
>
> Change over most of the virtual xattr routines to use the new helper. A
> couple of the xattrs are sourced from strings however, and it's
> difficult to know how long they'll be. Just have those memcpy the result
> in place after verifying the length.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/xattr.c | 84 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 25 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 9b77dca0b786..37b458a9af3a 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -109,22 +109,49 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
>         return ret;
>  }
>
> +/*
> + * The convention with strings in xattrs is that they should not be NULL
> + * terminated, since we're returning the length with them. snprintf always
> + * NULL terminates however, so call it on a temporary buffer and then memcpy
> + * the result into place.
> + */
> +static int ceph_fmt_xattr(char *val, size_t size, const char *fmt, ...)
> +{
> +       int ret;
> +       va_list args;
> +       char buf[96]; /* NB: reevaluate size if new vxattrs are added */
> +
> +       va_start(args, fmt);
> +       ret = vsnprintf(buf, size ? sizeof(buf) : 0, fmt, args);
> +       va_end(args);
> +
> +       /* Sanity check */
> +       if (size && ret + 1 > sizeof(buf)) {
> +               WARN_ONCE(true, "Returned length too big (%d)", ret);
> +               return -E2BIG;
> +       }
> +
> +       if (ret <= size)
> +               memcpy(val, buf, ret);
> +       return ret;
> +}
> +
>  static ssize_t ceph_vxattrcb_layout_stripe_unit(struct ceph_inode_info *ci,
>                                                 char *val, size_t size)
>  {
> -       return snprintf(val, size, "%u", ci->i_layout.stripe_unit);
> +       return ceph_fmt_xattr(val, size, "%u", ci->i_layout.stripe_unit);
>  }
>
>  static ssize_t ceph_vxattrcb_layout_stripe_count(struct ceph_inode_info *ci,
>                                                  char *val, size_t size)
>  {
> -       return snprintf(val, size, "%u", ci->i_layout.stripe_count);
> +       return ceph_fmt_xattr(val, size, "%u", ci->i_layout.stripe_count);
>  }
>
>  static ssize_t ceph_vxattrcb_layout_object_size(struct ceph_inode_info *ci,
>                                                 char *val, size_t size)
>  {
> -       return snprintf(val, size, "%u", ci->i_layout.object_size);
> +       return ceph_fmt_xattr(val, size, "%u", ci->i_layout.object_size);
>  }
>
>  static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
> @@ -138,10 +165,13 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
>
>         down_read(&osdc->lock);
>         pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
> -       if (pool_name)
> -               ret = snprintf(val, size, "%s", pool_name);
> -       else
> -               ret = snprintf(val, size, "%lld", pool);
> +       if (pool_name) {
> +               ret = strlen(pool_name);
> +               if (ret <= size)
> +                       memcpy(val, pool_name, ret);
> +       } else {
> +               ret = ceph_fmt_xattr(val, size, "%lld", pool);
> +       }
>         up_read(&osdc->lock);
>         return ret;
>  }
> @@ -149,10 +179,13 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
>  static ssize_t ceph_vxattrcb_layout_pool_namespace(struct ceph_inode_info *ci,
>                                                    char *val, size_t size)
>  {
> -       int ret = 0;
> +       ssize_t ret = 0;
>         struct ceph_string *ns = ceph_try_get_string(ci->i_layout.pool_ns);
> +
>         if (ns) {
> -               ret = snprintf(val, size, "%.*s", ns->len, ns->str);
> +               ret = ns->len;
> +               if (ret <= size)
> +                       memcpy(val, ns->str, ret);
>                 ceph_put_string(ns);
>         }
>         return ret;
> @@ -163,50 +196,51 @@ static ssize_t ceph_vxattrcb_layout_pool_namespace(struct ceph_inode_info *ci,
>  static ssize_t ceph_vxattrcb_dir_entries(struct ceph_inode_info *ci, char *val,
>                                          size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_files + ci->i_subdirs);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_files + ci->i_subdirs);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_files(struct ceph_inode_info *ci, char *val,
>                                        size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_files);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_files);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_subdirs(struct ceph_inode_info *ci, char *val,
>                                          size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_subdirs);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_subdirs);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_rentries(struct ceph_inode_info *ci, char *val,
>                                           size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_rfiles + ci->i_rsubdirs);
> +       return ceph_fmt_xattr(val, size, "%lld",
> +                               ci->i_rfiles + ci->i_rsubdirs);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_rfiles(struct ceph_inode_info *ci, char *val,
>                                         size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_rfiles);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_rfiles);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_rsubdirs(struct ceph_inode_info *ci, char *val,
>                                           size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_rsubdirs);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_rsubdirs);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_rbytes(struct ceph_inode_info *ci, char *val,
>                                         size_t size)
>  {
> -       return snprintf(val, size, "%lld", ci->i_rbytes);
> +       return ceph_fmt_xattr(val, size, "%lld", ci->i_rbytes);
>  }
>
>  static ssize_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
>                                         size_t size)
>  {
> -       return snprintf(val, size, "%lld.%09ld", ci->i_rctime.tv_sec,
> -                       ci->i_rctime.tv_nsec);
> +       return ceph_fmt_xattr(val, size, "%lld.%09ld", ci->i_rctime.tv_sec,
> +                               ci->i_rctime.tv_nsec);
>  }
>
>  /* dir pin */
> @@ -218,7 +252,7 @@ static bool ceph_vxattrcb_dir_pin_exists(struct ceph_inode_info *ci)
>  static ssize_t ceph_vxattrcb_dir_pin(struct ceph_inode_info *ci, char *val,
>                                      size_t size)
>  {
> -       return snprintf(val, size, "%d", (int)ci->i_dir_pin);
> +       return ceph_fmt_xattr(val, size, "%d", (int)ci->i_dir_pin);
>  }
>
>  /* quotas */
> @@ -238,20 +272,20 @@ static bool ceph_vxattrcb_quota_exists(struct ceph_inode_info *ci)
>  static ssize_t ceph_vxattrcb_quota(struct ceph_inode_info *ci, char *val,
>                                    size_t size)
>  {
> -       return snprintf(val, size, "max_bytes=%llu max_files=%llu",
> -                       ci->i_max_bytes, ci->i_max_files);
> +       return ceph_fmt_xattr(val, size, "max_bytes=%llu max_files=%llu",
> +                               ci->i_max_bytes, ci->i_max_files);
>  }
>
>  static ssize_t ceph_vxattrcb_quota_max_bytes(struct ceph_inode_info *ci,
>                                              char *val, size_t size)
>  {
> -       return snprintf(val, size, "%llu", ci->i_max_bytes);
> +       return ceph_fmt_xattr(val, size, "%llu", ci->i_max_bytes);
>  }
>
>  static ssize_t ceph_vxattrcb_quota_max_files(struct ceph_inode_info *ci,
>                                              char *val, size_t size)
>  {
> -       return snprintf(val, size, "%llu", ci->i_max_files);
> +       return ceph_fmt_xattr(val, size, "%llu", ci->i_max_files);
>  }
>
>  /* snapshots */
> @@ -263,8 +297,8 @@ static bool ceph_vxattrcb_snap_btime_exists(struct ceph_inode_info *ci)
>  static ssize_t ceph_vxattrcb_snap_btime(struct ceph_inode_info *ci, char *val,
>                                         size_t size)
>  {
> -       return snprintf(val, size, "%lld.%09ld", ci->i_snap_btime.tv_sec,
> -                       ci->i_snap_btime.tv_nsec);
> +       return ceph_fmt_xattr(val, size, "%lld.%09ld", ci->i_snap_btime.tv_sec,
> +                               ci->i_snap_btime.tv_nsec);
>  }
>
>  #define CEPH_XATTR_NAME(_type, _name)  XATTR_CEPH_PREFIX #_type "." #_name
> --
> 2.21.0
>

series reviewed-by.
