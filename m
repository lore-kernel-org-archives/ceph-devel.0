From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2] ceph: re-org copy_file_range and fix some error paths
Date: Mon, 24 Feb 2020 14:15:12 -0800
Message-ID: <c406ee08db90c1452c4ba9740b046ca9204c7239.camel@kernel.org>
References: <20200224134432.25888-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200224134432.25888-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2020-02-24 at 13:44 +0000, Luis Henriques wrote:
> This patch re-organizes copy_file_range, trying to fix a few issues in the
> error handling.  Here's the summary:
> 
> - Abort copy if initial do_splice_direct() returns fewer bytes than
>   requested.
> 
> - Move the 'size' initialization (with i_size_read()) further down in the
>   code, after the initial call to do_splice_direct().  This avoids issues
>   with a possibly stale value if a manual copy is done.
> 
> - Move the object copy loop into a separate function.  This makes it
>   easier to handle errors (e.g, dirtying caps and updating the MDS
>   metadata if only some objects have been copied before an error has
>   occurred).
> 
> - Added calls to ceph_oloc_destroy() to avoid leaking memory with src_oloc
>   and dst_oloc
> 
> - After the object copy loop, the new file size to be reported to the MDS
>   (if there's file size change) is now the actual file size, and not the
>   size after an eventual extra manual copy.
> 
> - Added a few dout() to show the number of bytes copied in the two manual
>   copies and in the object copy loop.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> Hi,
> 
> Just a respin including Jeff's suggestions from initial post.
> 
> Changes since v1:
> 
> - Don't bother trying a second splice once we fail during the remote
>   object copies; let user-space retry instead.
> 
> Cheers,
> --
> Luis
> 
>  fs/ceph/file.c | 173 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 100 insertions(+), 73 deletions(-)
> 

This looks good to me, Luis -- merged into ceph-client/testing.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
