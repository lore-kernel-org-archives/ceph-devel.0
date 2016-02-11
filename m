From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix a wrong comparison
Date: Thu, 11 Feb 2016 10:52:14 +0800
Message-ID: <1ED8DAC2-EEA9-4D59-A396-A0B08FC92416@redhat.com>
References: <1455125883-27735-1-git-send-email-a.s.protopopov@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455125883-27735-1-git-send-email-a.s.protopopov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On Feb 11, 2016, at 01:38, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> 
> A negative value rc compared to the positive value ENOENT in the
> finish_read() function.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
> fs/ceph/addr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c222137..1b809c9 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -276,7 +276,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
> 	for (i = 0; i < num_pages; i++) {
> 		struct page *page = osd_data->pages[i];
> 
> -		if (rc < 0 && rc != ENOENT)
> +		if (rc < 0 && rc != -ENOENT)
> 			goto unlock;
> 		if (bytes < (int)PAGE_CACHE_SIZE) {
> 			/* zero (remainder of) page */

Good catch, thanks

Yan, Zheng

> -- 
> 2.6.5
> 
