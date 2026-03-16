Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353B29C325
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657442; cv=pass; b=VXV9Oj0qMuLbA0McMMEZjESTi1Z3I1wN/BwJv7DC/IVRhOn+wC7ttz+CklHG5abDWz9Rh9RLPrkx63kJAUhoetNBQYNsNyj6yCBZO1SM5dCEyyyZ3ocgLsOue6vAElNqz9fEkllUwLiMo78qBqOTRlMD/DJmY/Lt0oGnXKtkIps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657442; c=relaxed/simple;
	bh=F0m16zYJESH8xZUsdND+b6fQSaoqWAlxcy9y+23OAvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuLdnfsvMSFuJnOJ60z1jaHv87EacAm1qjHVsqzDcS0KHYDzcxDwISryhLBovPn658+kVBG5KuXD39BDM8YFDKGMPYLi3EwUg4D7RZZCsz7xT/500l1s5xTgSY/YJkYv36eUmETxIYulCdqCTn0L8fEyptze1Nip3z+2WJJA77c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBRfO3UI; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBRfO3UI"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso5480098c88.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 03:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773657440; cv=none;
        d=google.com; s=arc-20240605;
        b=jKFFrYAgNpJskpheqNOQHWxqJFOzO2HqcFxHyWp0ZaHY6DhkcvyRSwMb5VsxxQiQk7
         biV06McqapKWEVIOW4R4s2+8cEc0DySP0ukkAPNHEqKZx+HWenSmfCFMZnMTALRYCKz5
         neqtxajzkLaxyXAP/GxcfnX3Zsh8e/tJ3HQl6sSh0piOEUSng8Dyt6aLPvNN8/ShS2Ya
         F0bWICN8714IBWqJ1Wxd9anTxdjVnwpsEbl+hTqFnNimw0zBjQqcwVQ1xkNAeCs22ZLe
         WfM0RGFUVpetKytJHY7hJX/zXXuEtMhjtsHTPvQ4eIPuIGQVKdcpAempXbiT2JejTF0X
         00kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9HNstpiH+5rRMR5THqOLmKwytaAGfzk115biE/R6PI=;
        fh=iRA1XjDSGSW2i9GzShUXH1UeIsDB1H2/H9ZtTHwAVNk=;
        b=F7AGHl0wjmvdwMzkAAeLi664DHvQQa7XXu0KNYd6YYZLc8P8qc9CSu08UnvLelXHUi
         uMJT3RL67kvR0mTbxqAnR9TJtOzsw9rUXamUQarIOfUyxbxbJrRh9QDSyPgXWOzAZuZF
         o+ckBgs4JKI1m1H3MinH+zNKZM9XRnGDU4TAJbDCFVJrfxus/oK5dJq7wXt9AJBxeB7z
         OnY/Zgt1cjq+J6oicj6kiSkdywmIIyshvKq35KqaC3FXaGhvFDXgwHWVw4hPDmqGkO3N
         /T4MEzk89VSGI2vyYdL3vIPIsbEzNFrfJbN+89SBeGMduX2tqfE4kAiRX+ZcRTPP7KR+
         4S7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773657440; x=1774262240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9HNstpiH+5rRMR5THqOLmKwytaAGfzk115biE/R6PI=;
        b=IBRfO3UIMsny4urPmZ3/SIq42abyEAqsB11l42c40dzhOsFuNPisGsUeXrs8xv0SO4
         TnrtXIYs1R6GhI0KYEU09+kRaCwpw5SlpQ3HWbt5dbmxizsoU0MG341MaCtKd8w6fqCV
         sJc1nuvLNiHasBxtBgTEaMMWGxX2NKT3c47m+gOqnNsrIhghA4cERv4+AyUEeV1hu1C0
         zdFV4ex3uY++liRUZib3vraC9erJm3+1OQQd9AtlVVcV5TgHgN5HP816CG51lNIBZsZU
         8T/wtLOXhaWLvRQ5kDSCRUSy5Dxyn9zIWFQiTvIjO37a2YwrrdbD2thM6hosSZC7fifx
         uKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657440; x=1774262240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9HNstpiH+5rRMR5THqOLmKwytaAGfzk115biE/R6PI=;
        b=aZtBeuwTFP+gWeZ2TD2CG7Uoi8vyILj+PzHJmMXS7BhClDf1EfZzEbzctNXtj+cooF
         pfeY6S3xe/MLCe2c9Lr+s9Z7ykZXNJsA4Glvc6xfXhiM3ACyjDai1JPXDTWwjxuWaLLp
         yDXC3Re2M4/6ns3jmWH5dHj4DeVl2242mx9KD3Ir61TeBZsYulHexvmSeyd5g65pB0ay
         fSfii6amICVOdkxtxP17/o2+8dQSGBE71nAKbSGsLaXXAeeOtwf8NvuB+YmHZLFOiBjf
         UBxg1mcFBRI4lXmBDOxtFzIO6L4I7FsPDAlg2ZzvPumCSb3tSHjPsewd6hhsmE1+sg0l
         0fhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0w/MULTjk9mfmeWCeaAxBCvRrxxrVkRGHunnMyBHMHZD1oPXaMCYtJQJcoBHueoSUJRJZ4fUOYC5x@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7/tcwHsWZMA448ln9VfcC88YnV8v6ewv4b/OMZDvFBsqJZpA
	AsAmCfRqt73jz5L+aG3+nPhz5KVmLxmhndHfT9nfJNr5GsMmgScGUatr5DyeJCnBpsd08h3jWJH
	jvIaMUty4QTH3jlSD3YTAMmZjKKjI0oI=
X-Gm-Gg: ATEYQzyPtm/Nr+g7raMpFDR1SlajLLIEHfz8DxvAZjz1yrxKPFZ6O1GbuUWa3Tg54iV
	ZmeBtJSQXAgyIIVv+DwI/IWV5QBCaWgVghO3uOK2L7sSz4MvrMVfkkiP+pggqb7ZeaEsOj2LkUz
	+WVx0zd+sjL59YqYrBpKPuylhSzqARy4J64XrB/ffzsOjyTFFfm6ZkQEFVf7ngoK5G62MoTw3ag
	owTHriLzdJAiIdi2Z1SvSPKJYwp9APBTz69CkhEyVx4UYaQEUS5YHGsSd7xCAIqOEhzEmkVUr18
	Eb9NjDQ=
X-Received: by 2002:a05:701b:4283:10b0:129:fe5:117e with SMTP id
 a92af1059eb24-1290fe51283mr689669c88.26.1773657440305; Mon, 16 Mar 2026
 03:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314212519.84244-1-ebiggers@kernel.org>
In-Reply-To: <20260314212519.84244-1-ebiggers@kernel.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Mar 2026 11:37:08 +0100
X-Gm-Features: AaiRm52TYgJ9Tjv76xttS7eo-G5BMSubyxJftpl-NDztxbgD2bWgLlO0mQku8yQ
Message-ID: <CAOi1vP_swcVHrmA0A6qDyzxq1KJozAet6yT7Qd9w7FXpzqVD0g@mail.gmail.com>
Subject: Re: [PATCH] libceph: Remove obsolete session key alignment logic
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 10:26=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> Since the call to crypto_shash_setkey() was replaced with
> hmac_sha256_preparekey() which doesn't allocate memory regardless of the
> alignment of the input key, remove the session key alignment logic from
> process_auth_done().  Also remove the inclusion of crypto/hash.h, which
> is no longer needed since crypto_shash is no longer used.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  net/ceph/messenger_v2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 50f65820f623f..865a9221315b0 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -6,11 +6,10 @@
>   */
>
>  #include <linux/ceph/ceph_debug.h>
>
>  #include <crypto/aead.h>
> -#include <crypto/hash.h>
>  #include <crypto/sha2.h>
>  #include <crypto/utils.h>
>  #include <linux/bvec.h>
>  #include <linux/crc32c.h>
>  #include <linux/net.h>
> @@ -2350,20 +2349,18 @@ static int process_auth_reply_more(struct ceph_co=
nnection *con,
>         pr_err("failed to decode auth_reply_more\n");
>         return -EINVAL;
>  }
>
>  /*
> - * Align session_key and con_secret to avoid GFP_ATOMIC allocation
> - * inside crypto_shash_setkey() and crypto_aead_setkey() called from
> - * setup_crypto().  __aligned(16) isn't guaranteed to work for stack
> + * Align con_secret to avoid GFP_ATOMIC allocation inside crypto_aead_se=
tkey()
> + * called from setup_crypto().  __aligned(16) isn't guaranteed to work f=
or stack
>   * objects, so do it by hand.
>   */
>  static int process_auth_done(struct ceph_connection *con, void *p, void =
*end)
>  {
> -       u8 session_key_buf[CEPH_MAX_KEY_LEN + 16];
> +       u8 session_key[CEPH_MAX_KEY_LEN];
>         u8 con_secret_buf[CEPH_MAX_CON_SECRET_LEN + 16];
> -       u8 *session_key =3D PTR_ALIGN(&session_key_buf[0], 16);
>         u8 *con_secret =3D PTR_ALIGN(&con_secret_buf[0], 16);
>         int session_key_len, con_secret_len;
>         int payload_len;
>         u64 global_id;
>         int ret;
> @@ -2413,11 +2410,11 @@ static int process_auth_done(struct ceph_connecti=
on *con, void *p, void *end)
>         }
>
>         con->state =3D CEPH_CON_S_V2_AUTH_SIGNATURE;
>
>  out:
> -       memzero_explicit(session_key_buf, sizeof(session_key_buf));
> +       memzero_explicit(session_key, sizeof(session_key));
>         memzero_explicit(con_secret_buf, sizeof(con_secret_buf));
>         return ret;
>
>  bad:
>         pr_err("failed to decode auth_done\n");
>
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> --
> 2.53.0
>

Applied.

Thanks,

                Ilya
