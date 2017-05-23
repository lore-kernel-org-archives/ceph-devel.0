From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/5] libceph: use kbasename() and kill ceph_file_part()
Date: Tue, 23 May 2017 12:39:25 -0500
Message-ID: <12383c71-04bd-cbbb-c7c7-ba3b6b907047@ieee.org>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33983 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935638AbdEWRjd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 13:39:33 -0400
Received: by mail-io0-f182.google.com with SMTP id k91so102364815ioi.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 10:39:28 -0700 (PDT)
In-Reply-To: <1495557238-1077-2-git-send-email-idryomov@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  include/linux/ceph/ceph_debug.h |  6 +++---
>  net/ceph/ceph_common.c          | 13 -------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
> index aa2e19182d99..51c5bd64bd00 100644
> --- a/include/linux/ceph/ceph_debug.h
> +++ b/include/linux/ceph/ceph_debug.h
> @@ -3,6 +3,8 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/string.h>
> +
>  #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
>  
>  /*
> @@ -12,12 +14,10 @@
>   */
>  
>  # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> -extern const char *ceph_file_part(const char *s, int len);
>  #  define dout(fmt, ...)						\
>  	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
>  		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
> -		 ceph_file_part(__FILE__, sizeof(__FILE__)),		\
> -		 __LINE__, ##__VA_ARGS__)
> +		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
>  # else
>  /* faux printk call just to see any compiler warnings. */
>  #  define dout(fmt, ...)	do {				\
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4fd02831beed..47e94b560ba0 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -56,19 +56,6 @@ static const struct kernel_param_ops param_ops_supported_features = {
>  module_param_cb(supported_features, &param_ops_supported_features, NULL,
>  		S_IRUGO);
>  
> -/*
> - * find filename portion of a path (/foo/bar/baz -> baz)
> - */
> -const char *ceph_file_part(const char *s, int len)
> -{
> -	const char *e = s + len;
> -
> -	while (e != s && *(e-1) != '/')
> -		e--;
> -	return e;
> -}
> -EXPORT_SYMBOL(ceph_file_part);
> -
>  const char *ceph_msg_type_name(int type)
>  {
>  	switch (type) {
> 

