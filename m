From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v2 1/3] ceph: fix up comment for ceph_count_locks() as
 to which lock to hold
Date: Wed, 15 May 2013 11:42:07 -0500
Message-ID: <5193BADF.2050302@inktank.com>
References: <1368635894-114707-1-git-send-email-jaschut@sandia.gov> <1368635894-114707-2-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368635894-114707-2-git-send-email-jaschut@sandia.gov>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/15/2013 11:38 AM, Jim Schutt wrote:
> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  fs/ceph/locks.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 202dd3d..ffc86cb 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -169,7 +169,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  }
>  
>  /**
> - * Must be called with BKL already held. Fills in the passed
> + * Must be called with lock_flocks() already held. Fills in the passed
>   * counter variables, so you can prepare pagelist metadata before calling
>   * ceph_encode_locks.
>   */
> 
