Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD63603DB
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980065; cv=pass; b=iWuJ3g9LTEdDRebFMEJmBzG+/c2Uc/Lad6MahcjxjrX6iyJfU9Oz0wfnuKst88AYHnhrAR5RBG3n5rw13loJV9HkODCobWv6enOXq7e+yO5elLbBpxyCUXWYbf+3rlJoTEp8UZz/QdCIuWVvrJnXG14VW4SxVN2hg4bftQFxcXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980065; c=relaxed/simple;
	bh=ttnorqN9WSWmxNwXsZXmXgVZoMduSwjRmLf+TPQP02o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9LkhIlViQcEOAhAVPCHOU9AvS9gSlArt3wuefXjHpOd16jIk4MObbbFYCt33Stmkc13Wnxlzr0xI3X16XFf5+YtsneN4GsGXCZMo3byUHiqh3ya6tPQeWAi0BlJEshEiDvZZpGq+R2uo67WxlyIvSuaeIaUIoTXKWTM2PvPWlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=tmBcpcz1; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="tmBcpcz1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so34047295ad.2
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jun 2026 21:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780980063; cv=none;
        d=google.com; s=arc-20240605;
        b=LIMUJ84UxA7ks0JgZ/HdNCLGHofuWx2vKew6kYMSEBHVTYmRru1vfHhiRjH4XPuMRu
         rUuKdaZExDwJNgnzGpIf4NCVKiothIXK+nSZVZHoJ0YIL1o+S8+9ypwALpKUwaRjyYhs
         YvFbRUx4KP3vpX3CK4/c290XbcxQcj+vt82J7iN4shncaNk4JnzVCPx1q+HayHQth7wI
         DPRMbhrNi2c+MhObbWMFo7rijDAZxRBZOV70siI9r2a3HK7AfJ44qb18L916Ko+2CtXb
         7fZ87Sw+WYrBYle7pV75n3i5xUJhOm1AL5ERlDc21G/JHGEfuQVPIjL8moV9hBkzKMZD
         fHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WSw/JWf2ge+x9AIZ6gfiFjtnYCoN7G42xrkHKi6H/tQ=;
        fh=SW7Tk6kbHgkalzCxZMf+xqkudZfdp+MoVMsCFY67JYI=;
        b=Me5kuOgRwyOFQj7kTq2C+Hd/qnfTDLRNFCwORZgujyEQKkIAgeQQo6g5RrJL2mndIy
         +U4vlKMqS0XGqh+Xly9B0eu7J/pB1oTeNtFQUn7xtpyQMaVINvyYHQhJMSQScjrT1Ndm
         96QO5WQI8MIwHfuRjU3ZZxAGc1XMFa9iyNXGjrxYhERMSAeD9WBCDZ0B+ZRDAo4ZTzDX
         JF/lTLL3S/qFY6ENCYxKq1zyujJryn04qIk3+Q9v4wBs9UD71y7BZ3vtnmUwq3aamD8R
         OQ2La0ugPxPYACgFvLNCF2J8UwGbppg2aooW9wAXe3ShNQjholVagblHQ3nHfTOQZvLE
         3Y/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780980063; x=1781584863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSw/JWf2ge+x9AIZ6gfiFjtnYCoN7G42xrkHKi6H/tQ=;
        b=tmBcpcz1At18Qh2oy9koWazMXJk7Bve3FO8VUS8ValbSp3iiKXWNSXUCWLUOOYGtfp
         WHjcaVAE04ppCesOtBDyJ5hDHBjsB2DINV9U5MrmoN6NZemEciroEgVtaHSuM83K2oHB
         tkAhF9v/WtVRJ4pH8+nhkkixEAsS/bH0+G6DagCkZ8XYZi0zXxAL0AaCg5KUltAAcwfv
         eXzKE+tn8cY0xTEa/Lw8ozZygjpfVuk8cbGl7Ly+uoawHhjWY+kgD70k9sdLnu/nPptb
         tesl9Hms9Ky7yitj/6GHJkwAUs4IkoNtDAeAfi2q2Yf1MY6DO5UDI3NSVPP6wIAkySjo
         a4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980063; x=1781584863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSw/JWf2ge+x9AIZ6gfiFjtnYCoN7G42xrkHKi6H/tQ=;
        b=oGC3yhF4WAVbrm7kYi1SCtwAcmg0Ofzm5O2V0ZMnDFOZ9jd8CjrVfwNwpp9etUljng
         3Y3ceB4F9sZ7JBdQWwXRCONO6vmWZM3+eNHO0VraEv5ce12M6EAqfEicbDs7PgizkGGL
         91W9cCa8TJH2ciG7ENWrOPppDNQgqoUjgtCT5398V4oMwoa4s+fHONhwBEuX7sJnhLhN
         CR9qg/1XSSe9VCk92hhE8EEt1h+Zksu29lQQseFxpcD1vcx+NVQ9CN3n+v0+p4KCAbsc
         U/c9fU3IgkdjtrrxO/0ukZXNfrzcCxAe0EVcQsrBPsUMYJlodFNXzwqkpkWS6VHg3nGL
         9tiw==
X-Gm-Message-State: AOJu0YyrsmRbJJ12wGyWq9bwPY6zZuFUODNvv2OL8xjI/8BeE0/SuQCj
	mBOaH9kDtZWagZCdbRvqY6SfOERdSK1OW1enclMFTW86gdAgVl17EDsgJdqmBQNI8WiTMGN9HPZ
	CqAaDZIKJR5aJzR+Zw54eXctzMf6rZSg3sg1+c96Dyl3lDEqQOSeougGMBzk=
X-Gm-Gg: Acq92OG4knPOgtqedAFnbXFnusF5I8y7eS3QsjED+VbrKXHzFdrkfcD+V72al6DjaP6
	Y6PexvB1+quCJDFEQUdJ82YUbXOJD0LwMiT3QHyRHSv1C2OOUEXein+7q48dUr5QVryjjc2dH+L
	tZIzvIUHPFfFAv+QWcS9TfiZAaV94PVEa3RCLpDEKKqRIRYEws9x3ngzoCTkrNABbgwwmZkZLXg
	S5Z/fcFkEEYKIAKsvXyF9it6MQ0rM/NsG03wiJq02gSin21fSLDmTq1xUdmqSPcONhJ1M+eqTZt
	DrpYDixMF6427GhmUA==
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id
 d9443c01a7336-2c1e77754d7mr218644325ad.0.1780980062937; Mon, 08 Jun 2026
 21:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609044009.2564543-1-xmei5@asu.edu>
In-Reply-To: <20260609044009.2564543-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Jun 2026 21:40:52 -0700
X-Gm-Features: AVVi8Cc5lG6jDIO0QGclfdNvU3XaBXv_eU4X8xkZpz3sGoWSEeY6oRTXKBZx1gM
Message-ID: <CAPpSM+RMkjsg2OXQdumPdxrF01L1wxNLSx=HyVw9BiBdpB_7KQ@mail.gmail.com>
Subject: Re: [PATCH net] libceph: bound pg_temp/pg_upmap osd list length to CEPH_PG_MAX_SIZE
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your attention to this bug. We have a PoC that can trigger
the KASAN crash. Please DM if you need it to reproduce the issue.

Xiang

On Mon, Jun 8, 2026 at 9:40=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> __decode_pg_temp() decodes an user-controlled length but only rejects
> values large enough to overflow the allocation; it does not bound it to
> CEPH_PG_MAX_SIZE. The helper backs both pg_temp and pg_upmap decoding, an=
d
> apply_upmap()/get_temp_osds() later copy the decoded list into the fixed-=
size
> on-stack array struct ceph_osds.osds[CEPH_PG_MAX_SIZE]. A monitor that se=
nds
> an OSDMap with a pg_temp/pg_upmap entry longer than 32 thus causes a stac=
k
> out-of-bounds write.
>
> An OSD set for a single PG can never exceed CEPH_PG_MAX_SIZE, so reject l=
onger
> entries at decode time. The bound is well below the old overflow threshol=
d, so
> it also covers the allocation-size overflow the previous check guarded ag=
ainst.
>
>   BUG: KASAN: stack-out-of-bounds in ceph_pg_to_up_acting_osds
>   Write of size 4 ... by task exploit
>    kasan_report (mm/kasan/report.c:595)
>    ceph_pg_to_up_acting_osds (net/ceph/osdmap.c:2617 net/ceph/osdmap.c:28=
33)
>    calc_target (net/ceph/osd_client.c:1638)
>    __submit_request (net/ceph/osd_client.c:2394)
>    ceph_osdc_start_request (net/ceph/osd_client.c:2490)
>    ceph_osdc_call (net/ceph/osd_client.c:5164)
>    rbd_dev_image_probe (drivers/block/rbd.c:6899)
>    do_rbd_add (drivers/block/rbd.c:7138)
>    ...
>   kernel BUG at net/ceph/osdmap.c:2670!
>
> Fixes: a303bb0e5834 ("libceph: introduce and switch to decode_pg_mapping(=
)")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/ceph/osdmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..e35d8abe1773 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1436,7 +1436,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(voi=
d **p, void *end,
>         ceph_decode_32_safe(p, end, len, e_inval);
>         if (len =3D=3D 0 && incremental)
>                 return NULL;    /* new_pg_temp: [] to remove */
> -       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> +       if (len > CEPH_PG_MAX_SIZE)
>                 return ERR_PTR(-EINVAL);
>
>         ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> --
> 2.43.0
>
