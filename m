From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: quota: fix null pointer dereference in quota check
Date: Tue, 6 Nov 2018 21:00:09 +0800
Message-ID: <3AD4F375-E9DE-485D-B2DA-A938AC4A3F0C@redhat.com>
References: <20181101065318.2cylxol6d444nzeu@kili.mountain>
 <20181105110052.31759-1-lhenriques@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105110052.31759-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



> On Nov 5, 2018, at 19:00, Luis Henriques <lhenriques@suse.com> wrote:
> 
> This patch fixes a possible null pointer dereference in
> check_quota_exceeded, detected by the static checker smatch, with the
> following warning:
> 
>    fs/ceph/quota.c:240 check_quota_exceeded()
>     error: we previously assumed 'realm' could be null (see line 188)
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lkml.kernel.org/n/20181101065318.2cylxol6d444nzeu@kili.mountain
> Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> fs/ceph/quota.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 32d4f13784ba..03f4d24db8fe 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -237,7 +237,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
> 		ceph_put_snap_realm(mdsc, realm);
> 		realm = next;
> 	}
> -	ceph_put_snap_realm(mdsc, realm);
> +	if (realm)
> +		ceph_put_snap_realm(mdsc, realm);
> 	up_read(&mdsc->snap_rwsem);
> 
> 	return exceeded;

Applied, thanks.

Yan, Zheng
