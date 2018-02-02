From: yue longguang <yuelongguang@gmail.com>
Subject: Re: [PATCH] libradosstriper: correct the first parameter of rados_striper_trunc
Date: Fri, 2 Feb 2018 16:18:42 +0800
Message-ID: <CAPaK2r_iR1MY1d-9+F=APornMDboEcCvmWAiEAtXDsTVmL2FPw@mail.gmail.com>
References: <1517475365-7732-1-git-send-email-yuelongguang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34129 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeBBISn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Feb 2018 03:18:43 -0500
Received: by mail-ot0-f195.google.com with SMTP id x15so19536754ote.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Feb 2018 00:18:42 -0800 (PST)
In-Reply-To: <1517475365-7732-1-git-send-email-yuelongguang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@redhat.com
Cc: ceph-devel@vger.kernel.org

yehuda, please review my patch. thanks

On Thu, Feb 1, 2018 at 4:56 PM, yuelongguang <yuelongguang@gmail.com> wrote:
> change the type of first parameter from rados_ioctx_t to rados_striper_t
> ---
>  src/include/radosstriper/libradosstriper.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/include/radosstriper/libradosstriper.h b/src/include/radosstriper/libradosstriper.h
> index 5aa4a6b..4d552c6 100644
> --- a/src/include/radosstriper/libradosstriper.h
> +++ b/src/include/radosstriper/libradosstriper.h
> @@ -207,7 +207,8 @@ int rados_striper_remove(rados_striper_t striper,
>   * @param size the new size of the object in bytes
>   * @returns 0 on success, negative error code on failure
>   */
> -int rados_striper_trunc(rados_ioctx_t io, const char *soid, uint64_t size);
> +int rados_striper_trunc(rados_striper_t striper,
> +                        const char *soid, uint64_t size);
>
>  /** @} Synchronous I/O */
>
> --
> 1.8.3.1
>
