Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C023D7DF
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831315; cv=pass; b=pyViE8VwnLbJIenPFDbuP9VWTWSMRo/m8NeeWODXaqCAml0pkPQYq25GpLBqlqT7bFBn0QWefD4OZvt4d2dBeBKseqnBPT0BFHwd0j7POr9OF3oanasQ2dFrGeUPU/lPOzvGWaEcUTch6gmYajQGCYa4bI0XD29TLO5n+SddCqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831315; c=relaxed/simple;
	bh=INc7vJnKmcPadUVe0TBusKMD0asFCz4Y2fnVdUat3cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUlcyCXAK3gViPhe1lgWWazchBINr/3NJoqaxkPipzcbD1EYkEWlgULQeQuWkDakK0pI4JQeAWHPmPgrUemcVz6a7MhUIKRG0VhjPO0FPXqaH5bM8WQgHw0xpdt1YQuR0FmwguMz3lFVCzQd1VwJ+dyFOJpsQf3HbfWSkgPQ7/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=fn2U3WK0; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="fn2U3WK0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c252c7270faso587013266b.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 18:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788831310; cv=none;
        d=google.com; s=arc-20260327;
        b=d27jlckDJDOCgrjNqoCFezrjlkknW4RV5hWqQ/yoHxHUL47TC5gBlT8Rptq4itfFBM
         s+zqnu5ofBzCZ+32f2EMxGQmrH7pXlsf66MeLbXSioQftXd397JhZiz34SpNMKbfDxec
         Dwob01DGNbLy/beJMhxKSpQAVpNP70X0vBOo1IO60wbuWWZdmfusUwB+n6LREaviafL4
         CMfFGp0NK+y+3Csr91bVmxSvSvkoV5IJUv36YwXXJM0UBJy+n3XMrxtdbKBmUwxVyLMk
         2T5R+/DD1XPHONpkt7DaWsVqk3OuSXiF0hVRGTbVI7pLmlEUE1NVT4L5qATOOYtvT6yT
         /qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        fh=LBoLDUnuYzsFOIsHMI/XV6siPH+DEswsAu7SF/quFMk=;
        b=BmFF8sgBtb3RMQOs+kbiTxdQZ4F1NsF9VMbx69c9gKmvK+VIH+lzFF8zPfCFDeGc57
         vVGk5ZxWAv+yzGebsWCzwdlKe5Koz95T+2Zi0gtxe+sTS68F9DTJDroEd+7hUjg+JzcY
         AoIYvTbaG9fIkDpnk3hT+BJ9usgMgL/h6XGzJgiA3C7PWIfPBJ0APKE/y6Pbu48WN2gH
         BpSCSFWFeYnbXPHsnxmVBo5YezKHdK8eFDz02sxMSYDXnSDNGbgdExs8aa3zTB2WVCuK
         feymMQNp7WecKd9fxJHhmMG1wbOuGN3mVkCSEjKiTb+ZGfaiobnbcw3UQ3QJDefus4qD
         f9VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788831310; x=1789436110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        b=fn2U3WK0LRPIWvBglrbhzM3uQGjBLbGzcSXeFddhdU5EixfXzSoB8ocYAkYLdTs8fg
         mfsP1n8s8IFKBE0P/5LPCl1MBrVoufZk13As7rtUcfKf7VqyGZx1VtH4y/vk7kGa2zUP
         EPkUYRMNu7Ih0cEBZna1Q1exOf9tcE9yTb1R7qFva7aAM5LyIkwGHezOYhbpYFE0aeqx
         G6J+W6EhMS0ZBGE4RIHQVKrEjEkGhEYFLerbsyyphg4P5i3IWtChN8owqffS3Xr7xPnr
         EasiIrmoPyT3n9ao58sL7gy8Qkc7zGB+Z6ace3gPQtgFALcbIs+1/m9SXAVUp8gHfm+1
         WZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788831310; x=1789436110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        b=CtKyXloOyJyx0o+bwf3W/NdX4OzIONRt6bGG4VTw6wkqUdvSawYTpf5DU7N4QCXtft
         7FvRHPO1M49WbPnV+itZsBsRevDbMZ4vWaKGxoVnoi51naztlL3KYhsRmKxzco/hsEZd
         hcK+Z7S7j2fblY4olXvYh07FUFvRsP73ZtJXG7W76DT3aoSovORpaUa7JVaycXW0Vxl4
         VSk6FpUfFeHSQbzG6ZfgtXgQ73K+YwytbkLUhDCBc2K85yXHEwBOADeyLEptXRfMd6kJ
         AqQ04PEKAVGpkFvrPt/dM2ayIHP3YjXn3hyEzxemO0Wkxx7agNHe78KUKdBXCXFDlIoc
         P2Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxQFWU0Swl9mzARhfjOYsIR8ilrX21/FCFxTaZdXnRM9ZXbgWYUwIIfYjk6XETLgvsL4DG/PhT8SvlZ@vger.kernel.org
X-Gm-Message-State: AFuF++kh+Tni7/6rAy324qjU7e5JWPFatZfww20sbmo4jrN/PvbfM6MD
	aNVgjlmMHVq8YYjnlam5inHDpzJLKAr4fqBWkEKyZoWMYj0kxnqKQtJZmydJ+34FCDbokU6gdch
	tru6gHTIyTtF1QmK4dki/PVcI5Pqw/XfjS7crFyLggOaVDE3rdgHtZbw=
X-Gm-Gg: AYBFou3438U0Dp5m7KmOMUw9iOoi21THQDapHGVr2HqdBRMoSQHZBJhaHPQxeLe2JEQ
	aPIgvez200XCmW0rDxas8k1xcKh8vWsyY/PTIGBvJu4dnKOmWapEtK6KKqvhA5IWN9m47hhUC9E
	Vg4bco65QTFXQElU6t7lx1NEugzroR3ox+cl6M/TMNPMflDH8iK4wpKc1QaMTCAvuu57ya3sOHe
	bmwK+70aa/cro8nyw1GLexTkZ9K1SIrRpJOtDJa1upXeGzSfNc4G5rwFn48tzD8TRFYc3awxVlD
	OgKydVb2XgJW8x6N4c1XFGm9zQgviDmpv0vpRyQDTmy//Q==
X-Received: by 2002:a17:906:2083:b0:c26:18be:68a6 with SMTP id
 a640c23a62f3a-c2618be6a62mr1178802166b.18.1788831310377; Mon, 07 Sep 2026
 18:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <20260904150304.49104-4-max.kellermann@ionos.com> <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
 <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
In-Reply-To: <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 7 Sep 2026 18:34:59 -0700
X-Gm-Features: AcwNN1Uuu5Oqsq4KB3cfDtW8BQx-uR9OtYrv2nZUZ2oDtvc-LBhe7NJyJM4ABBo
Message-ID: <CAOJNxRLW_nfbqDReOQTS3Tewv8EAhKOAMzAuvzC8R_1gq0uHTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max

I think you are right. I just checked the code again, I might have
messed up the code with my local temp patches.

Then this LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks

On Mon, 7 Sept 2026 at 12:15, Max Kellermann <max.kellermann@ionos.com> wro=
te:
>
> On Sat, Sep 5, 2026 at 3:56=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrot=
e:
> > Just one remaining teardown path still unregisters the session before
> > removing its caps: the fallback loop in ceph_mdsc_close_sessions():
> >
> > mutex_lock(&mdsc->mutex);
> > for (i =3D 0; i < mdsc->max_sessions; i++) {
> >         if (mdsc->sessions[i]) {
> >                 session =3D ceph_get_mds_session(mdsc->sessions[i]);
> >                 __unregister_session(mdsc, session);
> >                 mutex_unlock(&mdsc->mutex);
> >                 mutex_lock(&session->s_mutex);
> >                 remove_session_caps(session);
> >                 mutex_unlock(&session->s_mutex);
> >                 ...
> >
> > The rest of this series consistently changes the ordering to keep the
> > rank occupied until remove_session_caps() has completed. Is the
> > ordering in ceph_mdsc_close_sessions() intentionally excluded?
> >
> > This path is not limited to shutdown: it is also reached from the
> > corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
> > and handle_snap(). In those cases mdsc->stopping may be false and the
> > mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
> > __do_request() can register a new session for the rank in the window
> > between __unregister_session() and remove_session_caps().
>
> I don't think that's true for the call paths you mentioned. They call
> ceph_mdsc_close_sessions() only after ceph_update_snap_trace() has
> failed, and on failure, that function always sets CEPH_MOUNT_FENCE_IO,
> which prevents creating a new session.
>
> The only other callers are ceph_put_super() and the mount-failure path
> in ceph_get_tree(), where this is not relevant (no requests exist).
>
> Am I missing something?
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
