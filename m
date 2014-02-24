From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/6] libceph: bump CEPH_OSD_MAX_OP to 3
Date: Mon, 24 Feb 2014 08:59:06 -0600
Message-ID: <530B5E3A.9040503@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:45031 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO7F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:59:05 -0500
Received: by mail-ig0-f169.google.com with SMTP id h18so5032670igc.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:59:04 -0800 (PST)
In-Reply-To: <1393008946-7931-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> Our longest osd request now contains 3 ops: copyup+hint+write.

This is pretty trivial and could be squashed into the
patch that actually starts using more than two ops.
It could certainly be squashed together with the next
patch (that fixes the assertion).

That being said, I appreciate your breaking up the
functionality into logically separate changes, it's
important.

So I guess, do what you like...

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osd_client.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 6bfcb0eca8ab..bc874b2398d7 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -43,7 +43,7 @@ struct ceph_osd {
>  };
>  
>  
> -#define CEPH_OSD_MAX_OP	2
> +#define CEPH_OSD_MAX_OP	3
>  
>  enum ceph_osd_data_type {
>  	CEPH_OSD_DATA_TYPE_NONE = 0,
> 

