Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448617;
	b=zJfDFMVTWlZEhAaSVY3jTjuFsBDIeehYN+nRt0/WqDdpFABv8/IuENFHBuNILinDkTgj
	 jWYTvwhnX7z256fMRPwG4r/zJwd8lCHdThCnRBBCQ0nblQAabC+rVGU2FARvrtOY4DyLC
	 vVnfF2G2BfZ5/JIzDT8HMSykT9IRc6u0de+nNncSrsaTAbhLcRQJdHo9PEdMQuIUaCIk5
	 JRApSq/oTpgj/EpRpHrK2raaUPsLUktd0YCQ0M5akzU3SjUI8k2CLe9y6ugKsc3EmdoU1
	 4gv4NfQDHRLn6or+D0RjJb81Sbfny1XtKJEobyyPxx8YvsjJT8EFdHpF3gOuwt7DFJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448617;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vlcD19G9xALmfVWh6qixAsChTTMjTVjAvWOnGyaCmRU=;
	b=CNDBMMPVBclcBuu3z+emMOerSww9A5A92P2w+wJSeRCKjQdHGgGFsyWuq0/X9VyMo3ye
	 RkLOujB8xwmweo774AiHLk+0h9Xj2TskKdqjgbOhcoLOzZNpNKfMHP4PqLaum6/5a34/l
	 uz5uTCsIbCbs/iKErkU+xu13VcrwJDBSPimzWz62WoUdKxmkXos6eN2YxVAdseA+4c9sR
	 HcGrysxMIR0rfCA7R7WziZZoPS1Xerw575QQwUr8ziP2HNT6/88a/tEKIXuQpHyFLNHE5
	 gip0rNtnUNdJJEL0+W6y1c+F56WAlhavocEC6LsnzOJbNr84ufiHPtxLiGh/twlU3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVg8hANL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75809606A31C
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVg8hANL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E7A1F00A09
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448617;
	bh=vlcD19G9xALmfVWh6qixAsChTTMjTVjAvWOnGyaCmRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KVg8hANLAXoO4hjUTXJD88oRydg5HS0AYNxQVPyuoKzVm0EzcXS4t3Cp1efu4QNd7
	 cCoMliDydlabNX8nRDYdEGCFwjwXqDgyyu0hdKT80vkFoduN/6sitOT8AyRkuIHV4K
	 uOxX5aY6+YRtM7uHFbuVgOBArvcFsqgDs73ZqlCntPtna1kMcrjnhOQ5NVRSOuGXfl
	 7A64kABhMJvbZ0kuwlsbQPOuWFhfhEXlqDA3rTFZTK2DgDJ+c1Dbt507GZLSwBGEFX
	 Js+zqSfokjA1+OWT8REZ91NlF8u6ZgoVDrXMPxQ43o3/iM1ua5rub1UZZNxqZzccZn
	 rqxfZU2t2B+qw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab46699a09so32030781fa.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHkAHROY2BqKc/bN2WoDjshpI2oak0bUFNifoZEEX+DSCQ95v7wbzuJn3BYbPC61ogv6rchHh0QLSxn@vger.kernel.org
X-Gm-Message-State: APuU4Z/oZ4N/ygPhdkv4qHXze+KICk+kthLjc/357wotMhCX3zTcv0XZ
	fj8SHvkZG0sRuTwVh6X21hkI7KOHkioRSqyNXJnuErNwc27aoBa63+uXqTCu09A2+7yucrL9c2e
	DNMVAdcrZtOV6sPVgLJVaHUshnFFJwC4=
X-Received: by 2002:a05:6512:b9e:b0:5c1:44ea:cfa8 with SMTP id
 2adb3069b0e04-5c15d649f37mr1460481e87.47.1794448615836; Wed, 11 Nov 2026
 17:56:55 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1794382813.6AF41BD9.002.4jPb5k0FlFz6R2s@fangwg01>
In-Reply-To: <1794382813.6AF41BD9.002.4jPb5k0FlFz6R2s@fangwg01>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 02:56:43 +0100
X-Gmail-Original-Message-ID: <CAOuZWzxwa2hB-Sr7zm7aAhhsM6OBqMF_A5C==Y=HvM47EAc9Nw@mail.gmail.com>
X-Gm-Features: AclHuK_9QaL_JNXEb95zt0gFcFLZIxE5kmkdC5h7lK5XobXrnpOjdQOgNcl3ID8
Message-ID: <CAOuZWzxwa2hB-Sr7zm7aAhhsM6OBqMF_A5C==Y=HvM47EAc9Nw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix slab-use-after-free of capsnap in ceph_put_wrbuffer_cap_refs()
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On ... zhangdaolong wrote:
> In ceph_put_wrbuffer_cap_refs(), when capsnap->dirty_pages drops to 0
> and !capsnap->writing, ceph_try_drop_cap_snap() may drop the last
> reference on capsnap and free it via ceph_put_cap_snap(). ...

Hi Daolong,

Thanks for your patch.

Reproduced on testing with KASAN and the doutc in
ceph_put_wrbuffer_cap_refs() enabled: dirty a file under a snapshotted
dir, rmdir the snapshot (snapc seq bump without new snaps, so the
cap_snap is queued with need_flush =3D=3D false), then sync. Every
writeback completion that drops the cap_snap gave two
slab-use-after-free reports (4-byte read of dirty_pages and 8-byte
read of ->context) on the ceph_cap_snap cache, freed by
ceph_try_drop_cap_snap(). With this patch the same 30 drops give no
KASAN report.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

zhangdaolong <dlzhangak@isoftstone.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=89 08:40=E5=86=99=E9=81=93=EF=BC=9A
>
> In ceph_put_wrbuffer_cap_refs(), when capsnap->dirty_pages drops to 0
> and !capsnap->writing, ceph_try_drop_cap_snap() may drop the last
> reference on capsnap and free it via ceph_put_cap_snap(). However, the
> subsequent doutc() statement still dereferences capsnap->context->seq
> and capsnap->dirty_pages, triggering a KASAN slab-use-after-free when
> debug logging is enabled.
>
> Fix this by emitting the doutc() log message before calling
> ceph_try_drop_cap_snap().
>
> Fixes: 860560904962 ("ceph: avoid sending unnessesary FLUSHSNAP message")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://tracker.ceph.com/issues/77923
> Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
> ---
>  fs/ceph/caps.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 4b37d9ffdf7f..2f9f334276d1 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3393,23 +3393,24 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode=
_info *ci, int nr,
>                 }
>
>                 capsnap->dirty_pages -=3D nr;
> -               if (capsnap->dirty_pages =3D=3D 0) {
> +               if (capsnap->dirty_pages =3D=3D 0)
>                         complete_capsnap =3D true;
> -                       if (!capsnap->writing) {
> -                               if (ceph_try_drop_cap_snap(ci, capsnap)) =
{
> -                                       put++;
> -                               } else {
> -                                       set_bit(CEPH_I_FLUSH_SNAPS_BIT, &=
ci->i_ceph_flags);
> -                                       flush_snaps =3D true;
> -                               }
> -                       }
> -               }
> +
>                 doutc(cl, "%p %llx.%llx cap_snap %p snap %lld %d/%d -> %d=
/%d %s%s\n",
>                       inode, ceph_vinop(inode), capsnap, capsnap->context=
->seq,
>                       ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
>                       ci->i_wrbuffer_ref, capsnap->dirty_pages,
>                       last ? " (wrbuffer last)" : "",
>                       complete_capsnap ? " (complete capsnap)" : "");
> +
> +               if (complete_capsnap && !capsnap->writing) {
> +                       if (ceph_try_drop_cap_snap(ci, capsnap)) {
> +                               put++;
> +                       } else {
> +                               set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ce=
ph_flags);
> +                               flush_snaps =3D true;
> +                       }
> +               }
>         }
>
>  unlock:
> --
> 2.48.1
>
