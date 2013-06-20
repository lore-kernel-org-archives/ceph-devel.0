From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 1/2] Fscache glue implementation for Ceph
Date: Wed, 19 Jun 2013 23:57:19 -0400
Message-ID: <CANP1eJGN-i_FbwXpjHD9vce8NA3cjhRg_q2OB1MZTuOPs1y2JQ@mail.gmail.com>
References: <CANP1eJGNmiEL4SrokaO4Xirrsa4Lu_OoDHBG_Nf5mC4Rb-xhqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:62096 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935546Ab3FTD5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 23:57:21 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so5038647wev.36
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 20:57:19 -0700 (PDT)
In-Reply-To: <CANP1eJGNmiEL4SrokaO4Xirrsa4Lu_OoDHBG_Nf5mC4Rb-xhqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-cachefs@redhat.com, "Yan, Zheng" <zheng.z.yan@intel.com>

We're getting ready to put our application using Ceph with FScache
from staging to production. We're pretty happy with the performance
we've been able to get using this for our distributed analytics
database. I realize that this work won't help every hardware /
workload. In our case we're using fast SSD drives (on RAID0) for back
back the fscache. And the work we've done here had greatly reduced the
time (latency) for query responses compared to Ceph without fscache.

At this point in time I'm not pushing for it to get included into Ceph
as this code triggers some bugs in the upstream FScache code. David
Howells who maintains that code has already addressed them and is
working on getting them into mainline. But I would like to get a
review and some feedback so I can make any adjustments needed while
waiting for the 3.11 merge window (where hopefully the FScache fixes
will be in).

If you'd like to pull the code, it resides over here:
https://bitbucket.org/adfin/linux-fs/commits/branch/fscache-mount

Thanks,
- Milosz

On Wed, Jun 19, 2013 at 11:43 PM, Milosz Tanski <milosz@adfin.com> wrote:
> The facilities needed for fscache support support. This part of the work is
> self contained in it's files and just getting Ceph ready.
>
> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> ---
>  fs/ceph/cache.c |  334 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/cache.h |  115 +++++++++++++++++++
>  2 files changed, 449 insertions(+)
>  create mode 100644 fs/ceph/cache.c
>  create mode 100644 fs/ceph/cache.h
>
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> new file mode 100644
> index 0000000..f320d0e
> --- /dev/null
> +++ b/fs/ceph/cache.c
> @@ -0,0 +1,334 @@
> +/*
> + * Ceph cache definitions.
> + *
> + *  Copyright (C) 2013 by Adfin Solutions, Inc. All Rights Reserved.
> + *  Written by Milosz Tanski (milosz@adfin.com)
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to:
> + *  Free Software Foundation
> + *  51 Franklin Street, Fifth Floor
> + *  Boston, MA  02111-1301  USA
> + *
> + */
> +
> +#include "super.h"
> +#include "cache.h"
> +
> +struct ceph_aux_inode {
> + struct timespec mtime;
> + loff_t          size;
> +};
> +
> +struct fscache_netfs ceph_cache_netfs = {
> + .name = "ceph",
> + .version = 0,
> +};
> +
> +static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
> +     void *buffer, uint16_t maxbuf)
> +{
> + const struct ceph_fs_client* fsc = cookie_netfs_data;
> + uint16_t klen;
> +
> + klen = sizeof(fsc->client->fsid);
> + if (klen > maxbuf)
> + return 0;
> +
> + memcpy(buffer, &fsc->client->fsid, klen);
> + return klen;
> +}
> +
> +static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
> + .name = "CEPH.fsid",
> + .type = FSCACHE_COOKIE_TYPE_INDEX,
> + .get_key = ceph_fscache_session_get_key,
> +};
> +
> +void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc)
> +{
> + fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
> +      &ceph_fscache_fsid_object_def,
> +      fsc);
> +}
> +
> +void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc)
> +{
> + fscache_relinquish_cookie(fsc->fscache, 0);
> + fsc->fscache = NULL;
> +}
> +
> +static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
> +     void *buffer, uint16_t maxbuf)
> +{
> + const struct ceph_inode_info* ci = cookie_netfs_data;
> + uint16_t klen;
> +
> + /* use ceph virtual inode (id + snaphot) */
> + klen = sizeof(ci->i_vino);
> + if (klen > maxbuf)
> + return 0;
> +
> + memcpy(buffer, &ci->i_vino, klen);
> + return klen;
> +}
> +
> +static uint16_t ceph_fscache_inode_get_aux(const void *cookie_netfs_data,
> +   void *buffer, uint16_t bufmax)
> +{
> + struct ceph_aux_inode aux;
> + const struct ceph_inode_info* ci = cookie_netfs_data;
> + const struct inode* inode = &ci->vfs_inode;
> +
> + memset(&aux, 0, sizeof(aux));
> + aux.mtime = inode->i_mtime;
> + aux.size = inode->i_size;
> +
> + memcpy(buffer, &aux, sizeof(aux));
> +
> + return sizeof(aux);
> +}
> +
> +static void ceph_fscache_inode_get_attr(const void *cookie_netfs_data,
> + uint64_t *size)
> +{
> + const struct ceph_inode_info* ci = cookie_netfs_data;
> + const struct inode* inode = &ci->vfs_inode;
> +
> + *size = inode->i_size;
> +}
> +
> +static enum fscache_checkaux ceph_fscache_inode_check_aux(
> + void *cookie_netfs_data, const void *data, uint16_t dlen)
> +{
> + struct ceph_aux_inode aux;
> + struct ceph_inode_info* ci = cookie_netfs_data;
> + struct inode* inode = &ci->vfs_inode;
> +
> + if (dlen != sizeof(aux))
> + return FSCACHE_CHECKAUX_OBSOLETE;
> +
> + memset(&aux, 0, sizeof(aux));
> + aux.mtime = inode->i_mtime;
> + aux.size = inode->i_size;
> +
> + if (memcmp(data, &aux, sizeof(aux)) != 0)
> + return FSCACHE_CHECKAUX_OBSOLETE;
> +
> + dout("ceph inode 0x%p cached okay", ci);
> + return FSCACHE_CHECKAUX_OKAY;
> +}
> +
> +static void cifs_fscache_inode_now_uncached(void* cookie_netfs_data)
> +{
> + struct ceph_inode_info* ci = cookie_netfs_data;
> + struct pagevec pvec;
> + pgoff_t first;
> + int loop, nr_pages;
> +
> + pagevec_init(&pvec, 0);
> + first = 0;
> +
> + dout("ceph inode 0x%p now uncached", ci);
> +
> + while (1) {
> + nr_pages = pagevec_lookup(&pvec, ci->vfs_inode.i_mapping, first,
> +  PAGEVEC_SIZE - pagevec_count(&pvec));
> +
> + if (!nr_pages)
> + break;
> +
> + for (loop = 0; loop < nr_pages; loop++)
> + ClearPageFsCache(pvec.pages[loop]);
> +
> + first = pvec.pages[nr_pages - 1]->index + 1;
> +
> + pvec.nr = nr_pages;
> + pagevec_release(&pvec);
> + cond_resched();
> + }
> +}
> +
> +static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
> + .name = "CEPH.inode",
> + .type = FSCACHE_COOKIE_TYPE_DATAFILE,
> + .get_key = ceph_fscache_inode_get_key,
> + .get_attr = ceph_fscache_inode_get_attr,
> + .get_aux = ceph_fscache_inode_get_aux,
> + .check_aux = ceph_fscache_inode_check_aux,
> + .now_uncached = cifs_fscache_inode_now_uncached,
> +};
> +
> +
> +static int get_caps_issued(struct ceph_inode_info* ci)
> +{
> + int issued;
> + int implemented = 0;
> +
> + issued = __ceph_caps_issued(ci, &implemented);
> + issued |= implemented | __ceph_caps_dirty(ci);
> + return issued;
> +}
> +
> +
> +void ceph_fscache_register_inode_cookie(struct ceph_fs_client* fsc,
> + struct ceph_inode_info* ci)
> +{
> + const int want = (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO);
> +
> + /* No caching for filesystem */
> + if (fsc->fscache == NULL)
> + return;
> + /* Only do it for data files */
> + if ((ci->vfs_inode.i_mode & S_IFREG) == 0)
> + return;
> +
> + if (ci->fscache)
> + return;
> + if ((get_caps_issued(ci) & want) == 0) {
> + dout("No caps for caching inode: %p", &ci->vfs_inode);
> + return;
> + }
> +
> + ci->fscache = fscache_acquire_cookie(fsc->fscache,
> +     &ceph_fscache_inode_object_def,
> +     ci);
> +}
> +
> +void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
> +{
> + if (ci->fscache == NULL)
> + return;
> +
> + fscache_relinquish_cookie(ci->fscache, 0);
> + ci->fscache = NULL;
> +}
> +
> +void ceph_fscache_revoke_inode_cookie(struct ceph_inode_info* ci)
> +{
> + if (ci->fscache == NULL)
> + return;
> +
> + fscache_invalidate(ci->fscache);
> + /* Make sure the cache is cleared after we close the handle */
> + fscache_relinquish_cookie(ci->fscache, 1);
> + ci->fscache = NULL;
> +}
> +
> +void __ceph_fsache_async_uncache_inode(struct ceph_inode_info* ci)
> +{
> + fscache_uncache_all_inode_pages(ci->fscache, &ci->vfs_inode);
> +}
> +
> +static void ceph_vfs_readpage_complete(struct page *page, void *data,
> int error)
> +{
> + if (!error)
> + SetPageUptodate(page);
> +}
> +
> +static void ceph_vfs_readpage_complete_unlock(struct page *page, void
> *data, int error)
> +{
> + if (!error) {
> + SetPageUptodate(page);
> + unlock_page(page);
> + }
> +}
> +
> +/* Atempt to read from the fscache,
> + *
> + * This function is called from the readpage_nounlock context. DO NOT
> attempt to
> + * unlock the page here (or in the callback).
> + */
> +int __ceph_readpage_from_fscache(struct inode *inode, struct page *page)
> +{
> + const struct ceph_inode_info *ci = ceph_inode(inode);
> + int ret;
> +
> + ret = fscache_read_or_alloc_page(ci->fscache, page,
> + ceph_vfs_readpage_complete, NULL,
> + GFP_KERNEL);
> +
> + switch (ret) {
> + case 0: /* Page found */
> + dout("page read submitted\n");
> + return 0;
> + case -ENOBUFS: /* Pages were not found, and can't be */
> + case -ENODATA: /* Pages were not found */
> + dout("page/inode not in cache\n");
> + return 1;
> + default:
> + dout("%s: unknown error ret = %i\n", __func__, ret);
> + return ret;
> + }
> +}
> +
> +int __ceph_readpages_from_fscache(struct inode *inode,
> +  struct address_space *mapping,
> +  struct list_head *pages,
> +  unsigned *nr_pages)
> +{
> + struct ceph_inode_info *ci = ceph_inode(inode);
> + int issued = get_caps_issued(ci);
> + const int want = (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO);
> + int ret;
> +
> + /* Check if we have cached read caps */
> + if ((issued & want) == 0) {
> + return -ENOBUFS;
> + }
> +
> + ret = fscache_read_or_alloc_pages(ci->fscache, mapping, pages, nr_pages,
> +  ceph_vfs_readpage_complete_unlock,
> +  NULL, mapping_gfp_mask(mapping));
> +
> + switch (ret) {
> + case 0: /* All pages found */
> + dout("all-page read submitted\n");
> + return 0;
> + case -ENOBUFS: /* Some pages were not found, and can't be */
> + case -ENODATA: /* some pages were not found */
> + dout("page/inode not in cache\n");
> + return 1;
> + default:
> + dout("%s: unknown error ret = %i\n", __func__, ret);
> + return ret;
> + }
> +}
> +
> +void __ceph_readpage_to_fscache(struct inode *inode, struct page *page)
> +{
> + const struct ceph_inode_info *ci = ceph_inode(inode);
> + int ret;
> +
> + ret = fscache_write_page(ci->fscache, page, GFP_KERNEL);
> + if (ret)
> + fscache_uncache_page(ci->fscache, page);
> +}
> +
> +void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
> +{
> + const struct ceph_inode_info *ci = ceph_inode(inode);
> + struct fscache_cookie *cookie = ci->fscache;
> +
> + fscache_wait_on_page_write(cookie, page);
> + fscache_uncache_page(cookie, page);
> +}
> +
> +int __ceph_release_fscache_page(struct page *page, gfp_t gfp)
> +{
> + struct inode* inode = page->mapping->host;
> + struct ceph_inode_info *ci = ceph_inode(inode);
> + struct fscache_cookie *cookie = ci->fscache;
> +
> + return fscache_maybe_release_page(cookie, page, gfp);
> +}
> +
> diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
> new file mode 100644
> index 0000000..e7806cf
> --- /dev/null
> +++ b/fs/ceph/cache.h
> @@ -0,0 +1,115 @@
> +/*
> + * Ceph cache definitions.
> + *
> + *  Copyright (C) 2013 by Adfin Solutions, Inc. All Rights Reserved.
> + *  Written by Milosz Tanski (milosz@adfin.com)
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to:
> + *  Free Software Foundation
> + *  51 Franklin Street, Fifth Floor
> + *  Boston, MA  02111-1301  USA
> + *
> + */
> +
> +#ifndef _CEPH_CACHE_H
> +#define _CEPH_CACHE_H
> +#ifdef CONFIG_CEPH_FSCACHE
> +
> +#include <linux/fscache.h>
> +
> +
> +extern struct fscache_netfs ceph_cache_netfs;
> +
> +
> +void ceph_fscache_inode_get_cookie(struct inode *inode);
> +
> +void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc);
> +void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc);
> +void ceph_fscache_register_inode_cookie(struct ceph_fs_client* parent_fsc,
> + struct ceph_inode_info* ci);
> +void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
> +void ceph_fscache_revoke_inode_cookie(struct ceph_inode_info* ci);
> +void __ceph_fsache_async_uncache_inode(struct ceph_inode_info* ci);
> +
> +int __ceph_readpage_from_fscache(struct inode *inode, struct page *page);
> +int __ceph_readpages_from_fscache(struct inode *inode,
> +  struct address_space *mapping,
> +  struct list_head *pages,
> +  unsigned *nr_pages);
> +void __ceph_readpage_to_fscache(struct inode *inode, struct page *page);
> +void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
> +int __ceph_release_fscache_page(struct page *page, gfp_t gfp);
> +
> +static inline void ceph_fsache_async_uncache_inode(struct inode* inode)
> +{
> + struct ceph_inode_info *ci = ceph_inode(inode);
> +
> + if (ci->fscache == NULL)
> + return;
> +
> + __ceph_fsache_async_uncache_inode(ci);
> +}
> +
> +static inline int ceph_readpage_from_fscache(struct inode *inode,
> +     struct page *page)
> +{
> + if (ceph_inode(inode)->fscache == NULL)
> + return -ENOBUFS;
> +
> + return __ceph_readpage_from_fscache(inode, page);
> +}
> +
> +static inline int ceph_readpages_from_fscache(struct inode *inode,
> +      struct address_space *mapping,
> +      struct list_head *pages,
> +      unsigned *nr_pages)
> +{
> + if (ceph_inode(inode)->fscache == NULL)
> + return -ENOBUFS;
> +
> + return __ceph_readpages_from_fscache(inode, mapping, pages, nr_pages);
> +}
> +
> +static inline void ceph_readpage_to_fscache(struct inode *inode,
> +    struct page *page)
> +{
> + if (ceph_inode(inode)->fscache == NULL)
> + return;
> +
> + if (PageFsCache(page))
> + return __ceph_readpage_to_fscache(inode, page);
> +}
> +
> +static inline void ceph_invalidate_fscache_page(struct inode *inode,
> + struct page *page)
> +{
> + if (ceph_inode(inode)->fscache == NULL)
> + return;
> +
> + if (PageFsCache(page))
> + return __ceph_invalidate_fscache_page(inode, page);
> +}
> +
> +static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
> +{
> + struct inode* inode = page->mapping->host;
> + struct ceph_inode_info *ci = ceph_inode(inode);
> +
> + if (ci->fscache == NULL)
> + return 1;
> +
> + return __ceph_release_fscache_page(page, gfp);
> +}
> +
> +#endif
> +#endif
> --
> 1.7.9.5
