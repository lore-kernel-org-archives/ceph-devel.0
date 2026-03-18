Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DD270545
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859942; cv=pass; b=dzL9doMywomdxT4+5T4RdaIdu0tvOWXCHK3IG+kvO7YM68Uj3ugpMTQOsIbYFuVzj3sN8uSIvZKEyhhBp38RwV+VARrQnv90hbsX3ghtxYoOmjVxKosDy3wUK9RFH5w8cm52ehV67hFmqSry1TdWpQGAL7phQBvcslsX0NsKT8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859942; c=relaxed/simple;
	bh=nUc6Lh5xBXGGDVY6GaAR8LJ591C6ruOmgqzm7/PlnzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKUAsGVQinvk3sPly0JmomtVeJq4VY0spKtPg3egmS2CaTaL4KuKBIlEs65pN05cNbsv14K8aNLN8e/8pysUqYpRW11w7tmh9qk6Z6XhYhfb31VcSzmOBbm8ZQvOWXMikpaCVmoOqXwXHjGG1SyWoeyYeXAy6PyAOcWe4/qfBD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwVl4B5X; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwVl4B5X"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4e9694so519618c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 11:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773859940; cv=none;
        d=google.com; s=arc-20240605;
        b=LPbfKPZMZQn2YavbayvHNvqFdtqA/4/V87W2MyzU0Kg+J6SyDTzuqF3IVbn5wQltmB
         DTy04TFGUNzQXRVOOQUQKe/idBDNM3FtNRmfwKwtBqP9O40vgI8TkLK5kx/QkQeO6Rxx
         JdoMtSCROb93v5UfTpRz7OYclqkaDIpZLaFxNOKhfFgnPc+2VW3PZXJryO68bvUULaYh
         2xMf91J7mtxBpjxWFHNhEnxyJvpJcjr/AqyrPDinkuxj59O5JPt4fkoInRXIEqF5uQaw
         Estu2Y0I42GnuFGr8C9dF2VQwnhA62Ntq1jnm93P7tbphgjCAP84hrIW+o0ZHX9E8pIQ
         9rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJHUrpEHi6oTZ4B4cD9S7QTk7fPhMNSnq3TLpqGCgS8=;
        fh=9VqJG4rD8RixLYonbVQWJTa2MFxW40H+ntbTtDGowRA=;
        b=FX0c5MWOFPMYEmJmcTc7yQskdEr50h2D9O+T/CZHU8Sqv+9nNbm8coFMbsUzDMcNWI
         Lm6Ilt1MSxaaZQyLDvZTo3Wmq7k0q2tQvSpO/8/QUGqCseE1txGUie/C0jU3fKXUrSdj
         D2HmnC58bO5GkWjCMEYwhw1fnIEVUIJIYCFYL9FSg6DjGRxqTmdULpHnL6gzSJo5ZhNK
         n9BlCKWiQECtBTfYYpFPOaR9DyIShIydM5Lu3j86x4bhPIiTppi3QyjxQOB8cNHiH7S/
         59oIaBGsnAPDftEIJXfRFdUjSYGwKNftkh08SduKNWGQElhGatRL309Sx1htTu9dHiSY
         3RRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773859940; x=1774464740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJHUrpEHi6oTZ4B4cD9S7QTk7fPhMNSnq3TLpqGCgS8=;
        b=TwVl4B5XoNTByKazY6W1IyckxQof0puoR/Q7/oyOzH+8fEDMcHfSRLhDXktv4tqo68
         L/axnnF577i9NQOLLxmxhva8ShCCEgQrZSR6c2YMF8cMKQXsINSfHmHRJf7v+rEyeX6V
         3Yjtw09jWGBVgRL52YhFf4waG7SwG4m6x/LvuqQ7/nrNHzYqBjrYCKtpIbX14r9TUQlR
         wVtnXe/ik1KUpM+m5vVnBZZ9kR0NtZIT+BoXDvAFwT0OPuJH5R9LQQ+BcjzRdTPH8cks
         o9jaE7k5SCJSnVr/7PpVQr3UmhHYbFXbnh2y9UeaflnIoePMrx/GG4fgCQEjZoK/tFwf
         MhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859940; x=1774464740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJHUrpEHi6oTZ4B4cD9S7QTk7fPhMNSnq3TLpqGCgS8=;
        b=S3qhYuQwJYaEAXbNBDKMJaowJFxaJzKeH/4I7q63r2fIwoIDIVC6ITqs+KyZf5zxKI
         AvF0fHCO6PdxMeCgcElhcENMrix5sqCAs0JNczs912SYxIJn8b6eHPnhJUNZMwnUnits
         d/+2JJWl9w98lBNOoygrxUmExdA2l0ztxlfHzYBbWytQ/MRA+DNcEHOL2+zJ0sw3vEC7
         V8CGrlDDoNnKn8HE66fkBRyPpiWlFCmqyZkbamSb1pyQ6gTG5tQW13vV7+T47m4/eUIr
         h8OA7EKgIDH/R/8rnY4gxaM6K7UvANl2hy1/I/0tH4ES8krNBuNg1VATDIpy2Y3XQ9vk
         H55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd93xNZCskL5w/ax9jpoZXTYfrKLZVPsRXIhjSZDnuKZvoUI5SpzoSJensJGpnxwaCwy3UKrO0iulX@vger.kernel.org
X-Gm-Message-State: AOJu0YztYmrU4vum/3yMv4fvQv2ohb6MqyeU7b4WAC1SOPIu/aniptpl
	SulSVlnXuMddoW4DTB3SIdVcLxSd3mgkNN9bvtiqIw3h60TSSfNcCciFqVx6wmEQORlF09vPALj
	a/xK9DPiF4VU2svQToA2Z1yjSmmzIuKA=
X-Gm-Gg: ATEYQzzNTz/xiinc9YAE+odI+hmPFsvAOj88rWgiR37CDv73qYMrgQIRo2bosJE331w
	Sfq5zOoI8MJOAsZ/kJPj4wwiJFHD54T955z3XhFKwqLxVS3+yxrWoM1NWymD48tRS8h1VELxG5n
	m42SHuDUD0VkK6sQw3RZbcZBe0EY7lDYKsJMPutFvdde7YdUbHb6eDlK1jiROo/GXVX3+ejevKX
	zA8WKekh+d3bgRJlNcAB0QqCVMI/KKaopN0HyIyL8MZ7ed6Eog9hsAhtTL4bbuQto2vWhRnzg10
	s5RfxXw=
X-Received: by 2002:a05:7022:41a9:b0:119:e56b:958a with SMTP id
 a92af1059eb24-129a70e0e04mr2484855c88.15.1773859940215; Wed, 18 Mar 2026
 11:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318170903.869491-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260318170903.869491-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 18 Mar 2026 19:52:08 +0100
X-Gm-Features: AaiRm50bjBALgZSHh5cbtCaHrg7vTMSsAd6hV051bsYbYLJzjW5USFtwCFyKfuY
Message-ID: <CAOi1vP-X=aYqBVvPKoH_G0KNLbs0F4BnS07u8E7YpQpMarF9Lg@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:09=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> If a message of type CEPH_MSG_AUTH_REPLY contains a zero value for both
> protocol and result, this is currently not treated as an error. In case
> of ac->negotiating =3D=3D true and ac->protocol > 0, this leads to settin=
g
> ac->protocol =3D 0 and ac->ops =3D NULL. Thereafter, the check for
> ac->protocol !=3D protocol returns false, and init_protocol() is not
> called. Subsequently, ac->ops->handle_reply() is called, which leads to
> a null pointer dereference, because ac->ops is still NULL.
>
> This patch changes the check for ac->protocol !=3D protocol to
> !ac->protocol, as this also includes the case when the protocol was set
> to zero in the message. This causes the message to be treated as
> containing a bad auth protocol.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index 901b93530b21..3314705e5914 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -245,7 +245,7 @@ int ceph_handle_auth_reply(struct ceph_auth_client *a=
c,
>                         ac->protocol =3D 0;
>                         ac->ops =3D NULL;
>                 }
> -               if (ac->protocol !=3D protocol) {
> +               if (!ac->protocol) {
>                         ret =3D init_protocol(ac, protocol);
>                         if (ret) {
>                                 pr_err("auth protocol '%s' init failed: %=
d\n",
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
