From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ceph: attempt to do async create when possible
Date: Wed, 8 Apr 2020 14:20:55 +0300
Message-ID: <20200408112055.GM2066@kadam>
References: <20200408111734.GA252918@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:59980 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgDHLVG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2020 07:21:06 -0400
Content-Disposition: inline
In-Reply-To: <20200408111734.GA252918@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:17:34PM +0300, Dan Carpenter wrote:
> Hello Jeff Layton,
> 
> The patch 9a8d03ca2e2c: "ceph: attempt to do async create when
> possible" from Nov 27, 2019, leads to the following static checker
> warning:
> 
> 	fs/ceph/file.c:540 ceph_async_create_cb()
> 	error: uninitialized symbol 'base'.
> 
> fs/ceph/file.c
>    526          mapping_set_error(req->r_parent->i_mapping, result);
>    527  
>    528          if (result) {
>    529                  struct dentry *dentry = req->r_dentry;
>    530                  int pathlen;
>    531                  u64 base;
>                         ^^^^^^^^
>    532                  char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
>    533                                                    &base, 0);
>                                                           ^^^^^
>    534  
>    535                  ceph_dir_clear_complete(req->r_parent);
>    536                  if (!d_unhashed(dentry))
>    537                          d_drop(dentry);
>    538  
>    539                  /* FIXME: start returning I/O errors on all accesses? */
>    540                  pr_warn("ceph: async create failure path=(%llx)%s result=%d!\n",
>    541                          base, IS_ERR(path) ? "<<bad>>" : path, result);
>                                 ^^^^
> Potentialy uninitialized on error.
> 
>    542                  ceph_mdsc_free_path(path, pathlen);
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Also this is quite problematic.  "pathlen" can be uninitialized, but
even worse the ceph_mdsc_free_path() assumes "path" is NULL on error
instead of an error pointer.

>    543          }
>    544  
>    545          if (req->r_target_inode) {

regards,
dan carpenter
