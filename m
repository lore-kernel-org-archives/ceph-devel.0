From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: keep consistent semantic in fscache related option
 combination
Date: Wed, 7 Feb 2018 11:42:36 +0800
Message-ID: <2A919E51-A157-4044-B22A-233323A6AAB0@redhat.com>
References: <1517970426-39663-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752720AbeBGDmn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:42:43 -0500
In-Reply-To: <1517970426-39663-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com



> On 7 Feb 2018, at 10:27, Chengguang Xu <cgxu519@icloud.com> wrote:
> 
> When specifying multiple fscache related options, the result isn't always
> the same as option order, this fix will keep strict consistent meaning
> by order.
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> fs/ceph/super.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 7f1e212..e654005 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -314,9 +314,13 @@ static int parse_fsopt_token(char *c, void *private)
> 		break;
> 	case Opt_fscache:
> 		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
> +		kfree(fsopt->fscache_uniq);
> +		fsopt->fscache_uniq = NULL;
> 		break;
> 	case Opt_nofscache:
> 		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
> +		kfree(fsopt->fscache_uniq);
> +		fsopt->fscache_uniq = NULL;
> 		break;
> 	case Opt_poolperm:
> 		fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
> — 

Applied, thanks

> 1.8.3.1
> 

