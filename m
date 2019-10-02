From: Sasha Levin <sashal@kernel.org>
Subject: Re: [v4.19-stable PATCH] ceph: use ceph_evict_inode to cleanup
 inode's resource
Date: Tue, 1 Oct 2019 20:17:27 -0400
Message-ID: <20191002001727.GI17454@sasha-vm>
References: <20191001212425.3085-1-jlayton@kernel.org>
 <20191001212425.3085-2-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001212425.3085-2-jlayton@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: idryomov@gmail.com, zyan@redhat.com, ceph-devel@vger.kernel.org, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 01, 2019 at 05:24:25PM -0400, Jeff Layton wrote:
>From: "Yan, Zheng" <zyan@redhat.com>
>
>[ Upstream commit 87bc5b895d94a0f40fe170d4cf5771c8e8f85d15 ]
>
>remove_session_caps() relies on __wait_on_freeing_inode(), to wait for
>freeing inode to remove its caps. But VFS wakes freeing inode waiters
>before calling destroy_inode().
>
>[ jlayton: mainline moved to ->free_inode before the original patch was
>	   merged. This backport reinstates ceph_destroy_inode and just
>	   has it do the call_rcu call. ]
>
>Cc: stable@vger.kernel.org
>Link: https://tracker.ceph.com/issues/40102
>Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>Reviewed-by: Jeff Layton <jlayton@redhat.com>
>Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> fs/ceph/inode.c | 10 ++++++++--
> fs/ceph/super.c |  1 +
> fs/ceph/super.h |  1 +
> 3 files changed, 10 insertions(+), 2 deletions(-)
>
>Hi Sasha,
>
>Sorry for the resend -- forgot to cc stable@vger on the first one.
>
>This patch should be applied after commit 81281039999 is reverted.
>Sorry for the mixup!

I've queued it up for the next release, thank you!
