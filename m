Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1A1C862D
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018820; cv=pass; b=r2qEC4NerP+996eQOuDLvMDfMws8f+zvccJiTglcnYui6ryScOTZTI7HZBdJ0e9yi1NQNGT1TLO9Oh2EiUM6uFbTfMN2J9YEHtTQkB20cZgM+r0FgDMHW8OuI+rbMrEytraVOiOoteyoh/QqBfSROS9UFegcI3+TCMOOCJ97HlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018820; c=relaxed/simple;
	bh=dV+Mv1wTf2ZiiiOUDruWCgO9+N96aK//vXBOFBN+g+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THxmnpdpzu8pSqKYr69mgFpuiYgmLMSa3R7VXlzBJquWG2FO+1uOLnU/7LLXv6yMWUUfxyLTwm7ANVbU9uh6Z2y3wpkP/CefWg2WX/myy6vRQ7pSqw4Mt7L59Ns6GH8NFwMtJ4I0T1EYUye3xj4oQNi0wj2MPd4g5JcPMm6ENyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=JBoYtrTv; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="JBoYtrTv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so4993205a12.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787018815; cv=none;
        d=google.com; s=arc-20260327;
        b=Y6bX06Pl++wqsqbUwC05W6T2Jf7jUYBWZ4jx2ql67ABUvJCCEHwz8ybJauZhIPQcG1
         UE8XYtpoSDnUXk2y2ngJ/L79fsqwwqMwYOP4FQ5L/pTImb4xOej/flPfpYdMgYtlffFM
         3jV5EipmYJVq328iAIQfm43XXXueehXiPmhO+qRM3DRQD//P8Yo91GfUZE/E4U7HUpa7
         gMxcWaSEvbH7XkgW187I6Ns6Ro+QwdUHbOs7G/DdKkuknvwJm5v1vvGcsKde/JrPi/vT
         xgIfFdkeFtHvgHtGjmWSMroAufDBkaY6szbnDZP8ErFRIcLNmMOKZX/f/IWz++ruDA8I
         mYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dV+Mv1wTf2ZiiiOUDruWCgO9+N96aK//vXBOFBN+g+w=;
        fh=F9VvIKHiE90M8BiuLBcOyK4cXGCUTnYm/ekfM3xdMuY=;
        b=n85Jy+/8REHEquswnPWrfoouGRRZtXgszLgmkv+iPWaS0dh8JoRfdzdqjoyhtsQS96
         KfcmFosif+G/4nparnz4ltz3XP9pXwNaPAwwLeqvGUsmsxyAq54C01UgV6E+py/7cLrV
         UdrkjBtTUiggApJFgzMIck48BgQ4XjlrPdYhYgyPO9nBsDX2HQWcfHiRDsDvWncklUHe
         pFGCUoISooQeZSd4UVNwpZhrY4gN3wBTWmKeBUUBKUtjhfnzyjA+N/lss0pGDvD6Akin
         r1p1DM5zy5QLl5o+5VN+OBSeiA2S1rzcdJIzBMoyLUGQoJTz6oh8YvGP4gsQue3Sqzwf
         0nZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787018815; x=1787623615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dV+Mv1wTf2ZiiiOUDruWCgO9+N96aK//vXBOFBN+g+w=;
        b=JBoYtrTvA/ljZIqzoX3lmIU0oiT/kfLoJ3jnnPm6QumVQyIvjYLowcot/PYsv2EFqj
         plMEx7Q7/tCkO1BuNoKsxBB/Bd3fMVJfhIWyvoucTSKNe02/Uxlp2I9VBgruavXuGCHT
         xc0bx44EdHeMTg6sQuGYaeEKe2dtd277KzQZ2ijZpZTyKyYaijgGbbCYxGOaqF85XPQg
         wx7wxRqBRwwq1pCf7HEOcLIS3oToI1NV3ztTy1vUQV75NvNtVOfVcOingZ/8CLxUH13S
         bUs07Ky5FBzuzcaiOlB84P8+VUYwOHpss36LXfpBgssiMVeUsXMQTU8SJvONgqKlI4dP
         6ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787018815; x=1787623615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dV+Mv1wTf2ZiiiOUDruWCgO9+N96aK//vXBOFBN+g+w=;
        b=IqM7UEd5qZocJKEAVcAxoRP92rn6VUTDuHQBcjB83uE3WH7Kxv978PzSv6cLmS0dr5
         fm7OlxoTc//Bmjyo+RxYGgizzLR/55g2MC0+CSuOZfTfA7T163TcfAkHcehg+BKoluH8
         I12zujx4CpdmlVuamOdrlmweTSjrbmUPcjOxdTQTbiVc8qYXsTc9m0A6/H7nuZaW7vmo
         9puQGspLybCisJ3IEX3LKIf5tJpbtCW7y6o1kP4ISMg4HNz8C4e+w2zEyqx7/+gRrv3U
         qhqsFfv7QIrELVbYrCKcZvLrTl2JrgqiYSj47o7dkRaWoNpj7I1d7HkYPlrDbI6N8f9E
         CjEA==
X-Forwarded-Encrypted: i=1; AHgh+RoPomkfDfuEVlfFhVfSrJeIS/4BX/wjdWK+igkqy9/5R3x9vwJIC+oWHhje2oFqtg26NPvVZ010vB1n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07Jj36ZhYDh0ejfTJ9QaWXt2nD4Le0IWjL+Nc3dzqvXa6AIgs
	Gzj+XtUZvMFUI3ll0PfxvXajLJddqrpTE7/ceHIj8eFoF0uPgUe3pCBAbVWxc18z0pUuMvpXnhG
	wHrMp+f3ejlvTT1acHKNIhCVorL9vo1XML0kp3PK8Msvif6KyEH5laFw=
X-Gm-Gg: AR+sD10CkXgCIAOcCJzxfyi+QOnl6uTMtnHkwzchVHP1frwD4JDKWFmVMgbg5w3j3a5
	cftCKpTS9R0vCfDep3e9zKEmyD2AVGBWH3oeiZPFb2RWqbqh6o7jPTRe5dpPlLtsJubAK+InHgv
	FD/uocAiQcM/X/oILPhtL5088ARAfn0M62V4fwjrhLvxYGv1U+DJn2NQgOqp4NU2rcQ+896tjFf
	bzCMt+p7EkxP7VN5OXILjx+jdIS3TTF/fjyrlU1L2ew1lArgp6IFzsUUmqlx2WgU5nYlCo69tlg
	5D5NePxuNNsJYkMmyA3Hnx3eEVsVgvl/kXUN16BXhlzUOok=
X-Received: by 2002:a05:6402:a0c4:b0:698:be4d:ca2a with SMTP id
 4fb4d7f45d1cf-6a3e1489e9emr2053065a12.15.1787018815108; Mon, 17 Aug 2026
 19:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-ceph-mdsc-mutex-optimization-v4-1-fca3b7462f94@clyso.com>
 <20260817110520.741393-1-amarkuze@redhat.com>
In-Reply-To: <20260817110520.741393-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 17 Aug 2026 19:06:44 -0700
X-Gm-Features: AcwNN1XLhsY4jyOUtpvKDxQu5XEEhnG1OSoUNNOQ9mMvVGdLgbFuiKfTZT779rM
Message-ID: <CAOJNxRJm8gcaDHQghE1jB5+jV4gcF6FyaVfzsSp9jTWdj0JrTA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the feedback and for spotting those issues in patch 4 and
5. You are right, I will fix them and respin as v5.

Thanks
- Xiubo

On Mon, 17 Aug 2026 at 04:05, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Patches 1-4 look good =E2=80=94 the xarray replacement and the wait_list_=
lock
> are clean, and the mutex narrowing is the right direction. One blocker
> in patch 5:
>
> replay_unsafe_requests() calls list_del_init(&req->r_unsafe_item) before
> parking the request on the local walk list via r_aux_item. That permanent=
ly
> removes the request from session->s_unsafe. After replay, the request is
> no longer tracked as unsafe =E2=80=94 subsequent reconnects won't replay =
it, and
> cleanup_session_requests() can't drop it with -EIO on session teardown.
> The request can get stuck in the xarray with no error surfaced to userspa=
ce.
>
> The fix is to not unlink from s_unsafe at all =E2=80=94 just add to the l=
ocal list
> via r_aux_item and leave r_unsafe_item in place. That's the whole point o=
f
> having r_aux_item.
>
> Also r_aux_item is added to the struct in patch 4 but never initialized
> with INIT_LIST_HEAD() in ceph_mdsc_create_request().
>
> Could you respin as v5?
>
> --
> Alex Markuze
>
