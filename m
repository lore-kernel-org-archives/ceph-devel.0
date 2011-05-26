From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 2/4] rbd: allow configuration of rados from the rbd
 filename
Date: Thu, 26 May 2011 10:13:51 +0200
Message-ID: <4DDE0BBF.9010502@redhat.com>
References: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com> <1306355687-4647-3-git-send-email-josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab1EZILF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 04:11:05 -0400
In-Reply-To: <1306355687-4647-3-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

Am 25.05.2011 22:34, schrieb Josh Durgin:
> The new format is rbd:pool/image[@snapshot][:option1=value1[:option2=value2...]]
> Each option is used to configure rados, and may be any Ceph option, or "conf".
> The "conf" option specifies a Ceph configuration file to read.
> 
> This allows rbd volumes from more than one Ceph cluster to be used by
> specifying different monitor addresses, as well as having different
> logging levels or locations for different volumes.
> 
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  block/rbd.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 102 insertions(+), 17 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 2cee70d..d346a21 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -23,13 +23,17 @@
>  /*
>   * When specifying the image filename use:
>   *
> - * rbd:poolname/devicename
> + * rbd:poolname/devicename[@snapshotname][:option1=value1[:option2=value2...]]
>   *
>   * poolname must be the name of an existing rados pool
>   *
>   * devicename is the basename for all objects used to
>   * emulate the raw device.
>   *
> + * Each option given is used to configure rados, and may be
> + * any Ceph option, or "conf". The "conf" option specifies
> + * a Ceph configuration file to read.
> + *
>   * Metadata information (image size, ...) is stored in an
>   * object with the name "devicename.rbd".
>   *
> @@ -123,7 +127,8 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
>  static int qemu_rbd_parsename(const char *filename,
>                                char *pool, int pool_len,
>                                char *snap, int snap_len,
> -                              char *name, int name_len)
> +                              char *name, int name_len,
> +                              char *conf, int conf_len)
>  {
>      const char *start;
>      char *p, *buf;
> @@ -135,28 +140,84 @@ static int qemu_rbd_parsename(const char *filename,
>  
>      buf = qemu_strdup(start);
>      p = buf;
> +    *snap = '\0';
> +    *conf = '\0';
>  
>      ret = qemu_rbd_next_tok(pool, pool_len, p, '/', "pool name", &p);
>      if (ret < 0 || !p) {
>          ret = -EINVAL;
>          goto done;
>      }
> -    ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
> -    if (ret < 0) {
> -        goto done;
> +
> +    if (strchr(p, '@')) {
> +        ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
> +        if (ret < 0) {
> +            goto done;
> +        }
> +        ret = qemu_rbd_next_tok(snap, snap_len, p, ':', "snap name", &p);
> +    } else {
> +        ret = qemu_rbd_next_tok(name, name_len, p, ':', "object name", &p);
>      }
> -    if (!p) {
> -        *snap = '\0';
> +    if (ret < 0 || !p) {
>          goto done;
>      }
>  
> -    ret = qemu_rbd_next_tok(snap, snap_len, p, '\0', "snap name", &p);
> +    ret = qemu_rbd_next_tok(conf, conf_len, p, '\0', "configuration", &p);
>  
>  done:
>      qemu_free(buf);
>      return ret;
>  }
>  
> +static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
> +{
> +    char *p, *buf;
> +    char name[RBD_MAX_CONF_NAME_SIZE];
> +    char value[RBD_MAX_CONF_VAL_SIZE];
> +    int ret = 0;
> +
> +    buf = qemu_strdup(conf);
> +    p = buf;
> +
> +    while (p) {
> +        ret = qemu_rbd_next_tok(name, sizeof(name), p,
> +                                '=', "conf option name", &p);
> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        if (!p) {
> +            error_report("conf option %s has no value", name);
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        ret = qemu_rbd_next_tok(value, sizeof(value), p,
> +                                ':', "conf option value", &p);
> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        if (strncmp(name, "conf", strlen("conf"))) {

Do you really only want to check if name _starts_ with "conf"?

Kevin
