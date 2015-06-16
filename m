From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [PATCH] Allow CRLF in config files
Date: Tue, 16 Jun 2015 02:54:13 -0700
Message-ID: <CAC6JEv8oSYP_vZoDw62cQ3U-WNQAfa-5BjqF2K8-q6EUMuS-3g@mail.gmail.com>
References: <1434412418-32247-1-git-send-email-fxmulder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34907 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbbFPJyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 05:54:15 -0400
Received: by igbzc4 with SMTP id zc4so74742795igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 02:54:14 -0700 (PDT)
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com. [209.85.223.172])
        by mx.google.com with ESMTPSA id b15sm9562857igm.12.2015.06.16.02.54.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2015 02:54:14 -0700 (PDT)
Received: by iecrd14 with SMTP id rd14so9291055iec.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 02:54:14 -0700 (PDT)
In-Reply-To: <1434412418-32247-1-git-send-email-fxmulder@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Devine <fxmulder@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you submit this as a Github pull request?
We can take patches to userspace code over the mailing list but
they're more likely to get lost if you go that route.
-Greg

On Mon, Jun 15, 2015 at 4:53 PM, James Devine <fxmulder@gmail.com> wrote:
> Change config fopen to binary mode, allowing LF and CRLF EOL characters so
> ceph-dokan can work with native windows configuration files going forward.
> The carriage return is ignored and trimmed as whitespace during parsing via
> isspace().
>
> Signed-off-by: James Devine <fxmulder@gmail.com>
> ---
>  src/common/ConfUtils.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/common/ConfUtils.cc b/src/common/ConfUtils.cc
> index 1ae5df5..a717077 100644
> --- a/src/common/ConfUtils.cc
> +++ b/src/common/ConfUtils.cc
> @@ -99,7 +99,7 @@ parse_file(const std::string &fname, std::deque<std::string> *errors,
>    int ret = 0;
>    size_t sz;
>    char *buf = NULL;
> -  FILE *fp = fopen(fname.c_str(), "r");
> +  FILE *fp = fopen(fname.c_str(), "rb");
>    if (!fp) {
>      ret = -errno;
>      return ret;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
