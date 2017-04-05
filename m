From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/5] ceph: fix wrong check in ceph_renew_caps()
Date: Wed, 05 Apr 2017 10:16:27 -0400
Message-ID: <1491401787.18658.6.camel@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33961 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755334AbdDEOQb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Apr 2017 10:16:31 -0400
Received: by mail-qt0-f175.google.com with SMTP id n21so11549965qta.1
        for <ceph-devel@vger.kernel.org>; Wed, 05 Apr 2017 07:16:31 -0700 (PDT)
In-Reply-To: <20170405013019.5032-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Wed, 2017-04-05 at 09:30 +0800, Yan, Zheng wrote:
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 579a16c..0480492 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -123,7 +123,7 @@ int ceph_renew_caps(struct inode *inode)
>  	spin_lock(&ci->i_ceph_lock);
>  	wanted = __ceph_caps_file_wanted(ci);
>  	if (__ceph_is_any_real_caps(ci) &&
> -	    (!(wanted & CEPH_CAP_ANY_WR) == 0 || ci->i_auth_cap)) {
> +	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
>  		int issued = __ceph_caps_issued(ci, NULL);
>  		spin_unlock(&ci->i_ceph_lock);
>  		dout("renew caps %p want %s issued %s updating mds_wanted\n",

That certainly looks more like what was intended, but I'm still a
little unclear on why we have so much special casing in all of this
caps handling.

Why do we skip ceph_check_caps if we want CEPH_CAP_ANY_WR?
-- 
Jeff Layton <jlayton@redhat.com>
