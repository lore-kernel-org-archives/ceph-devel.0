From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] config: Remove debug output in conf_get
Date: Thu, 28 Apr 2011 10:04:02 -0700
Message-ID: <BANLkTimb2YwK-hS-2zWN3j49WLHyGK7ZnQ@mail.gmail.com>
References: <1303995788-31867-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab1D1RED convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 13:04:03 -0400
Received: by fxm17 with SMTP id 17so1952664fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 10:04:02 -0700 (PDT)
In-Reply-To: <1303995788-31867-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Thanks, Wido.
C.

On Thu, Apr 28, 2011 at 6:03 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
> =A0src/common/config.cc | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/src/common/config.cc b/src/common/config.cc
> index 695e039..8b4ce85 100644
> --- a/src/common/config.cc
> +++ b/src/common/config.cc
> @@ -734,7 +734,6 @@ get_val(const char *key, char **buf, int len) con=
st
> =A0 // In key names, leading and trailing whitespace are not signific=
ant.
> =A0 string k(ConfFile::normalize_key_name(key));
>
> - =A0cout << "get_val(key=3D'" << key << "'): k =3D '" << k << "'" <<=
 std::endl;
> =A0 for (int i =3D 0; i < NUM_CONFIG_OPTIONS; ++i) {
> =A0 =A0 const config_option *opt =3D &config_optionsp[i];
> =A0 =A0 if (strcmp(opt->name, k.c_str()))
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
