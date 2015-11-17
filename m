From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 2/2] fs/ceph: ceph_frag_contains_value can be boolean
Date: Tue, 17 Nov 2015 22:04:24 +0800
Message-ID: <35E9BBF7-3E75-4889-B8E3-67758754221F@redhat.com>
References: <1447743139-8190-1-git-send-email-baiyaowei@cmss.chinamobile.com> <1447743139-8190-2-git-send-email-baiyaowei@cmss.chinamobile.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447743139-8190-2-git-send-email-baiyaowei@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Sage Weil <sage@redhat.com>, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On Nov 17, 2015, at 14:52, Yaowei Bai <baiyaowei@cmss.chinamobile.com> wrote:
> 
> This patch makes ceph_frag_contains_value return bool to improve
> readability due to this particular function only using either one or
> zero as its return value.
> 
> No functional change.
> 
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> ---
> include/linux/ceph/ceph_frag.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/ceph_frag.h b/include/linux/ceph/ceph_frag.h
> index 970ba5c..b827e06 100644
> --- a/include/linux/ceph/ceph_frag.h
> +++ b/include/linux/ceph/ceph_frag.h
> @@ -40,7 +40,7 @@ static inline __u32 ceph_frag_mask_shift(__u32 f)
> 	return 24 - ceph_frag_bits(f);
> }
> 
> -static inline int ceph_frag_contains_value(__u32 f, __u32 v)
> +static inline bool ceph_frag_contains_value(__u32 f, __u32 v)
> {
> 	return (v & ceph_frag_mask(f)) == ceph_frag_value(f);
> }
> -- 
> 1.9.1

both applied

Thanks
Yan, Zheng

> 
> 
> 
