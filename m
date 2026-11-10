Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279925;
	b=oouTVQ2qMZVfd4lZ6ldCsjzE3TZfdPQZJyV6icfitAqLSCxgndj7oZZzxe7NQBPDxSC5
	 BFxm7AWb8MT4eIwrLODRISbRHFZR71Bi1MShmBPiQGs5HEIPMiLCsBb39wFVpmN1D9JyF
	 fTj2W4K2rde2+wR1bDllnHRbx6e2YXODHqS+mVsbeI5D0t0lEdJVIlT1EXpN5Ggnb1ndw
	 TDcEtb68w0Xbm8/i/ttiYqMUsnNW1DlHFZ4il4ZVkW8xW9q5pe0LkCqdWR7gLZj5D68Vi
	 Ibg5A0oMpH0eMSueZbcgWY77eFzXPpGwIzVqMPJoAQooX+50UM7uQkjdT65fbDlz7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279925;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/6BHI52ERTPfI4/6NKaL9AW/hxZtgzX02Qh7eA7Qxj0=;
	b=2HNxtxV/1MPqg6WwdORkjdQBOGLsyWQsTbCfmXpbcBSY6ethgm6DrS8I6aUdn57/8WP/
	 3FdOo6LqgT7kwk9YHpVzQ7ZIYSXnYq3Li07Tq/nSAS1Bp+9gU7hpxqPhc1TN7W5GAg4K2
	 B8JqFgnzDVCISme3UQonRafQwGThMLZ+TWWNiIQ2X9Nqr3WH/CslqdlJl6A86oRIhroCA
	 4KI1h/z8NyeW8NS3VwdbpAcLPYe2LL1ByfflNLqWujyYAn8lcy2Kwp3gbFuJ1LTjWg7T0
	 rnq8ywWqxDnr0/AZNU2j1zQAbDV2iwv3s2RJm6tLNppF9kL1TujMvjgw8yIJxPAngQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nya8mIpR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C285606A321
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nya8mIpR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25E1F008A4
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279924;
	bh=/6BHI52ERTPfI4/6NKaL9AW/hxZtgzX02Qh7eA7Qxj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nya8mIpRrn+ztEKdEwyDZiWPELNzvOi83hG7jczhRjnJeid8jbiUvZpHjuSnMxQZM
	 CZ/gGkr3Yp6lxM81PxHK6XrOiTj2WcMFdPWRrlCA6L5BxbMzBYowZbSaiU/CrSzyW9
	 KaQvzLZ+0nV5AYDbjdnHtHdeDdUNpr8OLwL5FY8PJYe5cuBD4atSWuCXvifmlRPqBA
	 Xxuu62z8whV7T9dFlJnHZKaREa0ej7RC3G5HPhPArZ7wjuIJusEaQSjQUTQevhLuAa
	 Q0dIhJnx4DMb+zRfmV0zP7JG0m+R7JWOKG+CE/GVQ8CEiAo1lu3dQ0qIJ48y9A/8j2
	 r9DZRU+jhufqQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so1359963e87.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2026 19:05:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHlJdNFu2jCvKt4P2hOnaA0a4sK+vsv1ogSI6PADNyVKqGac0vba+GCaMnMetF2sfoCj8Nbsz0TtEJu@vger.kernel.org
X-Gm-Message-State: APuU4Z/bywajjA4Dc/Sx+J0lRoBLN7EsEWDtZHMcRrfGe7UIO8YYhxsy
	WUvxt9mw2UEruV90ZoK5RlTQfgN9C/oKddXfXDGOt21Ff3u6prwDRvGDpXhs0svmDeV3kjlfOgl
	gmJJQIS/zJnZXKna48638AI2t9Q3RZYQ=
X-Received: by 2002:a05:6512:2342:b0:5b0:c95:cdb9 with SMTP id
 2adb3069b0e04-5c156e7eccdmr331630e87.23.1794279923598; Mon, 09 Nov 2026
 19:05:23 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1794274310.6AF27406.001.4jNpzB4CVLzch9@fangwg01>
In-Reply-To: <1794274310.6AF27406.001.4jNpzB4CVLzch9@fangwg01>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 10 Nov 2026 04:05:11 +0100
X-Gmail-Original-Message-ID: <CAOuZWzy9ro0r4RhYqKEBVPLnjNueQGCAV9bTGpN_PtArbY6soA@mail.gmail.com>
X-Gm-Features: AclHuK98pgQWvgrz-2fuLZ-hDjU0FUEf9dCbLSOqbk8mNjaT65KUEvCFdnB2c6o
Message-ID: <CAOuZWzy9ro0r4RhYqKEBVPLnjNueQGCAV9bTGpN_PtArbY6soA@mail.gmail.com>
Subject: Re: [PATCH] ceph: drop stale dentry when ceph_unlink() gets -ENOENT
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 zhangdaolong <dlzhangak@isoftstone.com> wrote:
> When a synchronous unlink, rmdir, or rmsnap request in ceph_unlink()
> fails with -ENOENT ...

Hi Daolong,

Thanks for your patch.

The change looks fine to me, and it matches what ceph_async_unlink_cb()
already does on failure. But I think the commit message should be
narrowed down.

I tested it with two kernel clients against a vstart cluster, with A and
B removing the same 2000 files (and 2000 dirs) at the same time. The MDS
returned -ENOENT to about 2000 of the requests, but even without this
patch A was left with no stale dentry: stat returns ENOENT, readdir is
empty and every name can be created again. B's unlink revokes A's
dentry lease and the parent's Fs caps before it completes, so A looks
the name up again anyway.

The case that really leaves a stale dentry is .snap: there is no lease
there, so after a failed RMSNAP "stat .snap/s2" still finds the
snapshot and "mkdir .snap/s2" fails with -EEXIST. Your patch fixes that.
With the d_revalidate change from the other patch the RMSNAP is not
even sent any more, so what is left is the window between d_revalidate
and the RMSNAP. Please describe this case in the commit message, and
call the regular-file part hardening rather than a bug fix.

Feel free to add:

Tested-by: Xiubo Li <xiubo.li@clyso.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks,
- Xiubo

zhangdaolong <dlzhangak@isoftstone.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=8C 02:31=E5=86=99=E9=81=93=EF=BC=9A
>
> When a synchronous unlink, rmdir, or rmsnap request in ceph_unlink()
> fails with -ENOENT (for example, because the target was already removed
> on the MDS by another client or a snapshot was already purged before
> the request reached the MDS), the MDS replies without a dentry trace.
>
> Currently, ceph_fill_trace() only invalidates the parent directory when
> result =3D=3D 0, and neither ceph_unlink() nor the VFS layer unhashes the
> dentry on error. As a result, the stale positive dentry remains hashed
> in the dcache and the parent directory may retain CEPH_I_COMPLETE.
>
> Fix this by clearing the parent directory's completeness and calling
> d_drop(dentry) when ceph_mdsc_do_request() returns -ENOENT in
> ceph_unlink().
>
> Suggested-by: Xiubo Li <xiubli@kernel.org>
> Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
> ---
>  fs/ceph/dir.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 6eb5b1cb039b..f4c0521f3bcc 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1473,8 +1473,12 @@ static int ceph_unlink(struct inode *dir, struct d=
entry *dentry)
>         } else {
>                 set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
>                 err =3D ceph_mdsc_do_request(mdsc, dir, req);
> -               if (!err && !req->r_reply_info.head->is_dentry)
> +               if (!err && !req->r_reply_info.head->is_dentry) {
>                         d_delete(dentry);
> +               } else if (err =3D=3D -ENOENT) {
> +                       ceph_dir_clear_complete(dir);
> +                       d_drop(dentry);
> +               }
>         }
>
>         ceph_mdsc_put_request(req);
> --
> 2.48.1
>
