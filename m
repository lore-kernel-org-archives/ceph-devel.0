Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CC2FD665
	for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874191; cv=pass; b=OkcODMhm1RsbsC84AQXUqIZWElyhDfNO0mAaDgyiOoy+rlwJ5DKWUQgWiQyONdrkYg+xbLYrTcxQmmcqf5pM11ImMb+5DFLxu+I99spRb1EZKOPMD9xrOL36/5Icovv/SoLz8WTusbZakOYf/gpjjvAG9rPwJMXGFz8ttfmGU2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874191; c=relaxed/simple;
	bh=pi0H2oiaX49EZbEtl8aifKvUOoqTXRC+DJJNcN1mGVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4EksaT0ZjmDE9VmKWg1MS79s/YZfK1J+CoCIIyw241sYJrmcVTTtIetu0OW+AB7dl7Fujq41hsjLuVIIfyg8PYbgombiVFSb8oZYrLMcObAVRSDcyM4Iuv6eszGkZK9SX9Gj1tAyyLNp3nsMG/SONMBmTNkuGSknSuhGsCoDX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9WROICv; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9WROICv"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso1043624c88.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 09:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776874189; cv=none;
        d=google.com; s=arc-20240605;
        b=j1wIZhHnMXXtk9QBmJCjYzWeIxCp36HbFcA9nPI/JvCOE3S5gSsdpGzlK24c83stgV
         j8uYl5s+Z/qOoU+HtpPBeVIV8V2kydecAymxNs2d9H+Nz0ldPAd+FmhrK0QldiRM2a/V
         bb92FLpq1+t9ToZ/vEjdc2hJMXQrEwEQEugXC7QIj52nvS68dKilkvfrQoh9mA9sDw/F
         /us0Gl7+xY0pB/98LvQiOvx3VpJD+ZzVLrNBlwzWNXUKpKR++Ky2gvWxXgMVzRl1l7oT
         c/uIJq87msPUQiXnPXMZK03dXy5hSMj7C88e5VQyPw63BZDURQf+cLOXvAlQl8voKxxV
         ZpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xc9T4yhhefb+DpU8HJRkhE25NJrxvdS3Q2iOtpRFUs4=;
        fh=fp03u0zlM1gsj26g4et3UA0741ho5A8VL0VK11ehCS4=;
        b=BYSB81DhkVebSBFqiRRja6IhNVtM6R9/5lExYlOd4KVVLrk6jmPQl3SVab/jQBhmkt
         7ousy6eP4ARP2F9YY7/AZna19U3ozCLGK3HEIxlk9GY/3grjHcDvM5ZPDgAtb+V5mR7e
         G9lYL+g+1q5/z3NyDSiiIBJFfJIOIJVdFGo3yEqGcXQ5NVIQaEkwXmm79qBhDEmsQpLA
         RsKUp6e4RwZAZOLmHer5MdcjVjfJVOUuEYbtfT88BQtUjCDkSxYDm+aVddJ5B5XcfQyP
         71IWukPYjoeM2/8Fl9Pr2/0yNuDwIALgv4H2G2TWLY1oFAsoVJifiZZ5Y3V9rVrIVVas
         HEIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874189; x=1777478989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc9T4yhhefb+DpU8HJRkhE25NJrxvdS3Q2iOtpRFUs4=;
        b=q9WROICvWMAFRyx9TQuK26P1ILpku2lEGse9xm8bthgoaoVBjjs4KrAVs2loY/42ST
         J4a1c7+i9qTlN9HshjbD3tOvkxtMaCJ9LtoIgaoP7N0Dua4a8+JbIybRGO1emS0CrAad
         rRxAO/BY7c+4ZbEI9nariWNivTqop3Tlt5UeKvdAeATCoUpyP0z69wbTc/6qVPu3Plo3
         W8fMwy17Uh5mnURz1jXosvo25zt7knZtTAn86fpPa7VQWDfqRYfFFNDzgolJLsoZgbd4
         olt5xxko4a2laQCmRX/dS/28A+Fy/B5W8urAHap5ZAOFCCwMa9tIMqT58FvaDAgoPk4D
         aTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874189; x=1777478989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xc9T4yhhefb+DpU8HJRkhE25NJrxvdS3Q2iOtpRFUs4=;
        b=XIjNQOUgL6ERuCHEPNz+rvOYca+76FP6JjF4xqQ9OrKXUQmgaN2cqQcx+XQh9+D6r0
         PRkNptVW5jnzrioUk66g1JzVSjx+hHY8Cva0Kk1l8Dp0HWnLyOTzgHg7pfCWrZltIhlV
         fXEyWHN2jGnGV+mEArRpdhUxWok+af6xtk0jiq+UuPLYEZDChtiUA4NAIOUT0N/1FRwO
         t25GnsLS+cm0otN4Zndz7cldqoHGx/VgCGBhcpr9lSMYJY/0gElKBaafTwmNBPsv4SMd
         1ZNiUtwsBtDmx3OU2zeILCVZ4+eMf/6RqfmkX9fAdrpv5reNv783MBmVmKWOGHgs+ZFp
         0axQ==
X-Forwarded-Encrypted: i=1; AFNElJ92+zX4NPE9lsBLQ3EG20vQ3eeSGD4EA8Vkfi65I37kAIiBrV9ZjCWx9AlOrYIBWpgkNKNdmPh5cZ1e@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkkI8gz6jiYNsQE8qiRO0E46LOj8PQuB6e00rsy6/jWGLx2Ub
	2MVXvGVoJNJl/nEnj8edBbqj83XaHqumXIPSnL6ARnyPWFAScFKLb7Z2GuqwWKyIdHCMzE5WvRn
	a9i2TuRTKDHgXzb9vt9l/t7oG2IBEqIA=
X-Gm-Gg: AeBDievDesPVPXAsFWaqtsKBQChcEq6g2KRrswGw3iKgaxNqLzRkySOhXeoaOoV/LwB
	MqGK8aGUjsTzmPefFeRSh1MWC3hvalWzq6EUHHm4s6a91Zc9BGar9JO+JBMlpaJ3oYpu1O4dLKN
	CbrfY9Eko1pUCCPCoDVNv1A1+6PJN9o/Gp18LRT0bM7zp54xbjB693AAEj5ulze9I9B8laCemoD
	4Cqtb549B7LHwuLBUGYa3rpW5HUBcMkniHUiNrZRJFMovXXl18b2MlqiH00AkJWJXsTFVubIbiX
	/0vfHQe2gVkri9FxBA==
X-Received: by 2002:a05:7022:68d:b0:12a:6902:ddb8 with SMTP id
 a92af1059eb24-12c73f683c5mr11338256c88.4.1776874189221; Wed, 22 Apr 2026
 09:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422084713.472133-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260422084713.472133-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Apr 2026 18:09:37 +0200
X-Gm-Features: AQROBzBXrZCL3rAZSK6hhH1ni5Z8b4Zesbd84QIBFPI8un5FZHlu1-Y1ieKAfE4
Message-ID: <CAOi1vP804ZuKdB+X8eyU2_2ufXVkV2huRmqgfQ7F0BSXvPEtpg@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: Fix potential out-of-bounds access in crush_decode()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:48=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
> one bucket has two fields holding the bucket algorithm. If the values
> in these two fields differ, an out-of-bounds access can occur. This is
> the case because the first algorithm field (alg) is used to allocate
> the correct amount of memory for a bucket of this type, while the second
> algorithm field inside the bucket (b->alg) is used in the subsequent
> processing.
>
> This patch fixes the issue by adding a check that compares alg and
> b->alg and aborts the processing in case they differ. Furthermore,
> b->alg is set to 0 in this case, because the destruction of the crush
> map also uses this field to determine the bucket type, which can again
> result in an out-of-bounds access when trying to free the memory pointed
> to by the fields of the bucket. To correctly free the memory allocated
> for the bucket in such a case, the corresponding call to kfree is moved
> from the algorithm-specific crush_destroy_bucket functions to the
> generic crush_destroy_bucket().
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/crush/crush.c | 6 +-----
>  net/ceph/osdmap.c      | 4 ++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
> index 254ded0b05f6..521aec1d5fc0 100644
> --- a/net/ceph/crush/crush.c
> +++ b/net/ceph/crush/crush.c
> @@ -47,7 +47,6 @@ int crush_get_bucket_item_weight(const struct crush_buc=
ket *b, int p)
>  void crush_destroy_bucket_uniform(struct crush_bucket_uniform *b)
>  {
>         kfree(b->h.items);
> -       kfree(b);
>  }
>
>  void crush_destroy_bucket_list(struct crush_bucket_list *b)
> @@ -55,14 +54,12 @@ void crush_destroy_bucket_list(struct crush_bucket_li=
st *b)
>         kfree(b->item_weights);
>         kfree(b->sum_weights);
>         kfree(b->h.items);
> -       kfree(b);
>  }
>
>  void crush_destroy_bucket_tree(struct crush_bucket_tree *b)
>  {
>         kfree(b->h.items);
>         kfree(b->node_weights);
> -       kfree(b);
>  }
>
>  void crush_destroy_bucket_straw(struct crush_bucket_straw *b)
> @@ -70,14 +67,12 @@ void crush_destroy_bucket_straw(struct crush_bucket_s=
traw *b)
>         kfree(b->straws);
>         kfree(b->item_weights);
>         kfree(b->h.items);
> -       kfree(b);
>  }
>
>  void crush_destroy_bucket_straw2(struct crush_bucket_straw2 *b)
>  {
>         kfree(b->item_weights);
>         kfree(b->h.items);
> -       kfree(b);
>  }
>
>  void crush_destroy_bucket(struct crush_bucket *b)
> @@ -99,6 +94,7 @@ void crush_destroy_bucket(struct crush_bucket *b)
>                 crush_destroy_bucket_straw2((struct crush_bucket_straw2 *=
)b);
>                 break;
>         }
> +       kfree(b);
>  }
>
>  /**
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index c89e66d4fcb7..a87268058e61 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, =
void *end)
>                 b->id =3D ceph_decode_32(p);
>                 b->type =3D ceph_decode_16(p);
>                 b->alg =3D ceph_decode_8(p);
> +               if (b->alg !=3D alg) {
> +                       b->alg =3D 0;
> +                       goto bad;
> +               }
>                 b->hash =3D ceph_decode_8(p);
>                 b->weight =3D ceph_decode_32(p);
>                 b->size =3D ceph_decode_32(p);
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
