From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: require cephx message signature by default
Date: Tue, 11 Nov 2014 13:51:28 +0400
Message-ID: <CALFYKtB7fHNDdW1UFecoq6O7DY=UEcAmGBLvw1NCv=nDTee5kQ@mail.gmail.com>
References: <1415695109-4698-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:34434 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbaKKJv3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 04:51:29 -0500
Received: by mail-qa0-f47.google.com with SMTP id dc16so6607217qab.6
        for <ceph-devel@vger.kernel.org>; Tue, 11 Nov 2014 01:51:29 -0800 (PST)
In-Reply-To: <1415695109-4698-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 11, 2014 at 11:38 AM, Yan, Zheng <zyan@redhat.com> wrote:
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/libceph.h |  1 +
>  net/ceph/ceph_common.c       | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index d293f7e..8b11a79 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -29,6 +29,7 @@
>  #define CEPH_OPT_NOSHARE          (1<<1) /* don't share client with other sbs */
>  #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
>  #define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
> +#define CEPH_OPT_NOMSGAUTH       (1<<4) /* not require cephx message signature */
>
>  #define CEPH_OPT_DEFAULT   (0)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index d361a274..b22d82c 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -237,6 +237,8 @@ enum {
>         Opt_noshare,
>         Opt_crc,
>         Opt_nocrc,
> +       Opt_cephx_require_signature,
> +       Opt_cephx_require_no_signature,
>  };
>
>  static match_table_t opt_tokens = {
> @@ -255,6 +257,8 @@ static match_table_t opt_tokens = {
>         {Opt_noshare, "noshare"},
>         {Opt_crc, "crc"},
>         {Opt_nocrc, "nocrc"},
> +       {Opt_cephx_require_signature, "cephx_require_signature"},
> +       {Opt_cephx_require_no_signature, "cephx_require_no_signature"},

Maybe "cephx_require_signatures", "nocephx_require_signatures" ?  It
would (almost) match injectargs and be more in line with general mount
option conventions.

Thanks,

                Ilya
