From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/1 linux-next] libceph: remove redundant declaration
Date: Thu, 2 Oct 2014 11:05:49 +0400
Message-ID: <CALFYKtBgb+Uf3kvyyAj-w8ywMU=kCByZm-Kr1DGi0w-WVmhXdw@mail.gmail.com>
References: <1412107670-4888-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61569 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaJBHFu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 03:05:50 -0400
Received: by mail-qa0-f48.google.com with SMTP id dc16so1401100qab.21
        for <ceph-devel@vger.kernel.org>; Thu, 02 Oct 2014 00:05:49 -0700 (PDT)
In-Reply-To: <1412107670-4888-1-git-send-email-fabf@skynet.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fabian Frederick <fabf@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 1, 2014 at 12:07 AM, Fabian Frederick <fabf@skynet.be> wrote:
> ceph_release_page_vector was defined twice in libceph.h
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  include/linux/ceph/libceph.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 279b0af..07bc359 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -211,7 +211,6 @@ extern struct page **ceph_get_direct_page_vector(const void __user *data,
>                                                  bool write_page);
>  extern void ceph_put_page_vector(struct page **pages, int num_pages,
>                                  bool dirty);
> -extern void ceph_release_page_vector(struct page **pages, int num_pages);
>  extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
>  extern int ceph_copy_user_to_page_vector(struct page **pages,
>                                          const void __user *data,

Applied.

Thanks,

                Ilya
