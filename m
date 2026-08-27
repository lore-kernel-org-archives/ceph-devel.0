Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DE417D9C
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822624; cv=pass; b=cOZs6dsia5juWPgG0cyDeMopUJT2A4Rb2xrZXT/kgYvAYg8pZ/E4KuXzF7Y65zLxSTupghmnpZU6OJg/0Ya7gJyWW7Uknp4Hs/gENy/O7ZCwMj/R+PpdtVgDJibUccGLntit145ysEf9/V3xTAAyJ0J9n6n8Qw1JU65s8vaB3Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822624; c=relaxed/simple;
	bh=DBHBD4i87XSNXLCWnW2smU6A62RZ/Q1PR1qnDwQ3R8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5yB5s3lwVuJiqqsQ+9kkpUE/ONIZ4aTIv/yNklotW6Jq+1VlJ6SPob/CwOn7EgC4zW5/Emm/xYXfwEtUj08Q1lxTBa+2/IPvM2cJNa067tEqEA814xE1H/HOyD8v6kfQD7IChFldRzRcE9V/Cq+UfgjOCH8De56o7r8vqAtvhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=N/9CXmyH; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="N/9CXmyH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c160420289bso68439066b.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 02:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787822618; cv=none;
        d=google.com; s=arc-20260327;
        b=hCNAsv5lbbCbaIMkZfDvsmn2GKmwLzJIR1dKbem9WqN8GaRkrx0Q0s21X2mXgtJhRj
         Nyg213nvGNIkmuY8zmEFyJh/Gjb29BRtIJlZF52v8oupaNF3c4t4R28AniZM4Yzi6izV
         mMzgDKZMkNI8jMX9YjLZOWd+JkQH2fx+KbJb+1dXZcMoXYSXXQZB1gXTnvQyqZNIW5jp
         fvPUyqMtruuBLkGnuQNmEEsCMfYTRLVlEPCsxWVkoXSEvef81xOgoZx2vZH2ZrGLyfRG
         /44Qa48Jqr3cekmK1y8TVUgQymbpwMAgE45nFLb9evmXNYEgv1SoSjlKruyvRD3NJMLy
         0xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        fh=W5I/kpABibqBkpPK6UMJg0JhlSqHZYkA7YkjIpvGzNY=;
        b=In8SrAnK/4wO/nA42FEecDzkfh5EMg3JbzZoK33WhXhDoXX7I3M3OWs7sAxLtPeMUL
         JpEofAvVaEEvnX8eC06edN8riJrjzPluky0lC2BD/7Vbwnk7X6hrav264VAPoHekR66l
         7zN0VnA5YmQM89onDGZhHk6tuV6RCd8eJWHHVfJ2cL/JdDB2sGrfSjjQAAVYrWefrXAz
         JZA7INZ3slCBgjlbgDxyKWk/3DS7aawRe6FOjjtDcmYedHkDImLenNFp9++jDL7vLA60
         HfCVy5lSIk8KHw9p9mMEZKd6m72TSCMCY96nGUR6yKMrjp8yXAUq1mbPPQfvbEHFrbfm
         dHxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787822618; x=1788427418; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        b=N/9CXmyH5ZA3yuT5sWoq6ccqE4jFAIAbKZDuYmufvz5csYrdBvAypgbiYduatTIWAH
         r+9JZ1d9Z9/oCn7vHw8hxEaHnVfvTFowEBFqSxV/mMvLuXMgvv8Y+9ECu6DMx0ldMvwf
         rrDwNy13uSIX9WCQXL31vz9UIXDnOGZNg01x7FInncPFC6kMNEiRJPtf0uU50/91Ujd7
         5j1LaTrWgqY+prhgPpQyiwuf5fDijvlTELVYj9lcYnK5lWdp4KvgLwRyxC/n2a167PHA
         F9nwX7EVvwZXFi0e92O8t7Hfr2ygUN6aZ/rgxy7SzjNEqJNDd97Jisv9/LTzAAAGm0c4
         hJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822618; x=1788427418;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        b=N/SiX3U4kEQarumX9CYMgYwSUS6gtIS9LU9xN0XjLedAJVjr6RoCTbFhtIU9xvALn2
         98oS8WdVrYSH2/xF+xGjW4Tf1xXIVRdqB7lwlLE1iNpkLt5DXQY3CzJh4KlIqAwMc4SJ
         zTzfY9zVNDvOjz4yoNi7uONqEQ54HmeVBWO421PssbmeaeU15NxMMvjWMB2VFfeEIEfJ
         wgyNtqorQOVDu1nzBD5Id0PTLYYok4PVrydAtxXGeblDm9ECEIZelPpNYem49iV6IW1T
         0LWpgFrvSAxkq6LlEoR8JzbJZhh1gCQUYMG7skGCM6V2bHoZyv/nSU8GxRYrAiKiGvk7
         fVBA==
X-Forwarded-Encrypted: i=1; AHgh+RoIJcT6VwjF2i1fxlc+OuiQ6TvR/UvxWKRgr+d++GknkLzJuSCasUbE8tq0oNQHM9sZ/qHCKzbouV/d@vger.kernel.org
X-Gm-Message-State: AFuF++nZkjeFuY5LsBStiMiT+9hVWickkBM7kdZkrJe2r+QQOHLVFnu+
	ikAFHspveWsWM5QiTEw0FdKxrvdvTVwHHgI1ipGOmi3StHHhGy9jymqIpflzTOokzMRHnOBRF2U
	I70p3+m5C2AnCv13wXuDUgCEl+Ba8J6TO6KljpLyR2yqkzf7OUU1WN2o=
X-Gm-Gg: AR+sD12tNDwUQX+aKpIaqcT3zaozA2s4dvGFGHWIB69OUR/LPKFCiaegZLarwbvXrni
	hZUrdv3XdW27vfb3Jzwykx6yBvGtSCfMohGw/okNrQLDRR1Q3TnO1fA/YBVuIKlnwlG7O01FgNM
	Rtb/RhgbyjwPnGVkG2mdSt6M/OdWokcwvgh5RXhVuZ1BjT/TT8u5C/N+QSChGj0OYY2dveeNbZv
	rIkYpxHqeGqpErplLG1vjHVE0KpNBM0CIx37qSEmfPxRLkn9JQej8CzmChfpo/oY6lhk51Yj1FY
	j9g646255CmluruXcApZ2QN+IlQomLkPjKXMJOg9wZCvcCZ2ofAR1iHG
X-Received: by 2002:a17:906:9fd1:b0:c25:362e:fb8b with SMTP id
 a640c23a62f3a-c25362efe10mr476489366b.7.1787822617738; Thu, 27 Aug 2026
 02:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824164707.225547-1-max.kellermann@ionos.com>
In-Reply-To: <20260824164707.225547-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 27 Aug 2026 02:23:24 -0700
X-Gm-Features: AcwNN1UwIC-FqqFXy9MiN3M9lqUGjoxGkQeIpqgmUwjYu1w1OyWgOlMiaP06l8k
Message-ID: <CAOJNxR+vqTNU-1k5tCO1XPBbaVYi+GK_X+x9M5cOtN+BFvecdw@mail.gmail.com>
Subject: Re: [PATCH] ceph: lock mutex in ceph_mds_check_access()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Mon, 24 Aug 2026 at 09:47, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> MDS session OPEN handling replaces mdsc->s_cap_auths under
> mdsc->mutex, freeing the previous array and its strings.
>
> ceph_mds_check_access() traverses this array without holding the
> mutex.  A concurrent session reopen can therefore free the array while
> it is being inspected, resulting in a use-after-free like this:
>
>   Unable to handle kernel paging request at virtual address 003aaad64b2c8bb9
>   [...]
>   Internal error: Oops: 0000000096000004 [#1]  SMP
>   Modules linked in:
>   CPU: 56 UID: 2953037534 PID: 1253231 Comm: php-cgi8.4 Not tainted 6.18.45-i2-ampere #1146 NONE
>   [..]
>   pc : ceph_mds_check_access+0xd4/0x550
>   lr : ceph_mds_check_access+0xc8/0x550
>   [...]
>   Call trace:
>    ceph_mds_check_access+0xd4/0x550 (P)
>    ceph_atomic_open+0x138/0xbe8
>    path_openat+0xa24/0xfa8
>    do_filp_open+0x94/0x158
>    do_sys_openat2+0x88/0xf8
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 4 ++++
>  fs/ceph/mds_client.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 3c692ad02c85..0348e8b848ff 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6532,11 +6532,13 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>         doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
>               tpath, mask, caller_uid, caller_gid);
>
> +       mutex_lock(&mdsc->mutex);
>         for (i = 0; i < mdsc->s_cap_auths_num; i++) {
>                 struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
>
>                 err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>                 if (err < 0) {
> +                       mutex_unlock(&mdsc->mutex);
>                         put_cred(cred);
>                         return err;
>                 } else if (err > 0) {
> @@ -6558,6 +6560,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>         doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
>               rw_perms_s);
>         if (root_squash_perms && rw_perms_s == NULL) {
> +               mutex_unlock(&mdsc->mutex);
>                 doutc(cl, "access allowed\n");
>                 return 0;
>         }
> @@ -6572,6 +6575,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>                       !!(mask & MAY_READ), !!(mask & MAY_WRITE));
>         }
>         doutc(cl, "access denied\n");
> +       mutex_unlock(&mdsc->mutex);
>         return -EACCES;
>  }
>
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0ece4c9e3529..8774c7d7d18d 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -603,6 +603,7 @@ struct ceph_mds_client {
>         struct rw_semaphore     pool_perm_rwsem;
>         struct rb_root          pool_perm_tree;
>
> +       /* protected by mutex */
>         u32                      s_cap_auths_num;
>         struct ceph_mds_cap_auth *s_cap_auths;
>
> --
> 2.47.3
>
