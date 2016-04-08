From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/2] libceph: multiple filesystem support
Date: Fri, 8 Apr 2016 08:11:33 -0500
Message-ID: <5707AE05.2020407@ieee.org>
References: <1460098226-69141-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34343 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcDHNLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 09:11:54 -0400
Received: by mail-wm0-f45.google.com with SMTP id l6so64168196wml.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 06:11:54 -0700 (PDT)
In-Reply-To: <1460098226-69141-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 04/08/2016 01:50 AM, Yan, Zheng wrote:
> When accessing non-default filesystem, cephfs client subscribes to
> "mdsmap.<id>". To support this, we can't use number to stand for
> map name. Instead, we need to pass map name to ceph_monc_want_map().
> Map name caller provided is saved in monc->subs[] and later encoded
> in MON_SUBSCRIBE message.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  include/linux/ceph/mon_client.h | 23 +++++------
>  net/ceph/debugfs.c              |  2 +-
>  net/ceph/mon_client.c           | 87 +++++++++++++++++++++++++----------------
>  3 files changed, 67 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index e230e7e..4aa8b3c 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -55,6 +55,13 @@ struct ceph_mon_generic_request {
>  	struct ceph_msg *reply;    /* and reply */
>  };
>  
> +/* may subscribe to mdsmap.<int> */
> +#define CEPH_SUB_MAP_MAXLEN 32
> +
> +#define CEPH_SUB_MONMAP "mommap"

s/mom/mon/

That's all; this isn't a "real" review.	-Alex

