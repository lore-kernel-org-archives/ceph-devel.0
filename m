From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 1/9] libceph: move feature bits to separate header
Date: Tue, 24 Jul 2012 15:14:45 -0700
Message-ID: <CAC-hyiF2WcN199++5keRPapezakg5fkXa9+W=83BGCiJMJzwQA@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-2-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40922 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab2GXWOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 18:14:47 -0400
Received: by bkwj10 with SMTP id j10so46764bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 15:14:46 -0700 (PDT)
In-Reply-To: <1342831308-18815-2-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> This is simply cleanup that will keep things more closely synced with the
> userland code.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  fs/ceph/mds_client.c               |    1 +
>  fs/ceph/super.c                    |    1 +
>  include/linux/ceph/ceph_features.h |   24 ++++++++++++++++++++++++
>  include/linux/ceph/ceph_fs.h       |   14 --------------
>  include/linux/ceph/libceph.h       |    6 ------
>  net/ceph/ceph_common.c             |    5 +++--
>  6 files changed, 29 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/ceph/ceph_features.h
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 418f6a8..39b76d6 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -10,6 +10,7 @@
>  #include "super.h"
>  #include "mds_client.h"
>
> +#include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/messenger.h>
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/pagelist.h>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 1e67dd7..2c47ecf 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -18,6 +18,7 @@
>  #include "super.h"
>  #include "mds_client.h"
>
> +#include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/mon_client.h>
>  #include <linux/ceph/auth.h>
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> new file mode 100644
> index 0000000..342f93d
> --- /dev/null
> +++ b/include/linux/ceph/ceph_features.h
> @@ -0,0 +1,24 @@
> +#ifndef __CEPH_FEATURES
> +#define __CEPH_FEATURES
> +
> +/*
> + * feature bits
> + */
> +#define CEPH_FEATURE_UID            (1<<0)
> +#define CEPH_FEATURE_NOSRCADDR      (1<<1)
> +#define CEPH_FEATURE_MONCLOCKCHECK  (1<<2)
> +#define CEPH_FEATURE_FLOCK          (1<<3)
> +#define CEPH_FEATURE_SUBSCRIBE2     (1<<4)
> +#define CEPH_FEATURE_MONNAMES       (1<<5)
> +#define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
> +#define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
> +
> +/*
> + * Features supported.
> + */
> +#define CEPH_FEATURES_SUPPORTED_DEFAULT  \
> +       (CEPH_FEATURE_NOSRCADDR)
> +
> +#define CEPH_FEATURES_REQUIRED_DEFAULT   \
> +       (CEPH_FEATURE_NOSRCADDR)
> +#endif
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index e81ab30..d021610 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -35,20 +35,6 @@
>  /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
>  #define CEPH_MAX_MON   31
>
> -
> -/*
> - * feature bits
> - */
> -#define CEPH_FEATURE_UID            (1<<0)
> -#define CEPH_FEATURE_NOSRCADDR      (1<<1)
> -#define CEPH_FEATURE_MONCLOCKCHECK  (1<<2)
> -#define CEPH_FEATURE_FLOCK          (1<<3)
> -#define CEPH_FEATURE_SUBSCRIBE2     (1<<4)
> -#define CEPH_FEATURE_MONNAMES       (1<<5)
> -#define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
> -#define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
> -
> -
>  /*
>   * ceph_file_layout - describe data layout for a file/inode
>   */
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 98ec36a..ea072e1 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -23,12 +23,6 @@
>  #include "ceph_fs.h"
>
>  /*
> - * Supported features
> - */
> -#define CEPH_FEATURE_SUPPORTED_DEFAULT CEPH_FEATURE_NOSRCADDR
> -#define CEPH_FEATURE_REQUIRED_DEFAULT  CEPH_FEATURE_NOSRCADDR
> -
> -/*
>   * mount options
>   */
>  #define CEPH_OPT_FSID             (1<<0)
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 3b45e01..69e38db 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>
>
> +#include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/libceph.h>
>  #include <linux/ceph/debugfs.h>
>  #include <linux/ceph/decode.h>
> @@ -460,9 +461,9 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
>         client->auth_err = 0;
>
>         client->extra_mon_dispatch = NULL;
> -       client->supported_features = CEPH_FEATURE_SUPPORTED_DEFAULT |
> +       client->supported_features = CEPH_FEATURES_SUPPORTED_DEFAULT |
>                 supported_features;
> -       client->required_features = CEPH_FEATURE_REQUIRED_DEFAULT |
> +       client->required_features = CEPH_FEATURES_REQUIRED_DEFAULT |
>                 required_features;
>
>         /* msgr */
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
