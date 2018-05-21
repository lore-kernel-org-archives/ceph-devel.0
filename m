From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix st_nlink stat for directories
Date: Mon, 21 May 2018 21:04:23 +0800
Message-ID: <F5370214-6FE9-475F-A4EF-60A477A733B4@redhat.com>
References: <20180521092729.17470-1-lhenriques@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521092729.17470-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



> On May 21, 2018, at 17:27, Luis Henriques <lhenriques@suse.com> wrote:
> 
> Currently, calling stat on a cephfs directory returns 1 for st_nlink.
> This behaviour has recently changed in the fuse client, as some
> applications seem to expect this value to be either 0 (if it's
> unlinked) or 2 + number of subdirectories.  This behaviour was changed
> in the fuse client with commit 67c7e4619188 ("client: use common
> interp of st_nlink for dirs").
> 
> This patch modifies the kernel client to have a similar behaviour.
> 
> Link: https://tracker.ceph.com/issues/23873
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> fs/ceph/inode.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index aa7c5a4ff137..6ad66ef8fd66 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2288,6 +2288,14 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
> 				stat->size = ci->i_files + ci->i_subdirs;
> 			stat->blocks = 0;
> 			stat->blksize = 65536;
> +			/*
> +			 * Some applications rely on the number of st_nlink
> +			 * value on directories to be either 0 (if unlinked)
> +			 * or 2 + number of subdirectories.
> +			 */
> +			if (stat->nlink == 1)
> +				/* '.' + '..' + subdirs */
> +				stat->nlink = 1 + 1 + ci->i_subdirs;
> 		}
> 	}
> 	return err;

Applied, thanks.

Yan, Zheng
