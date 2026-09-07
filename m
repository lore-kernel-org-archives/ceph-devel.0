Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1184302155
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808530; cv=pass; b=YWyRXSPeaFPAJyn46oOmQTICgRpOkqYa5SzeloclQELseCQM9KmLjf6rQUhAFXj/epueSFUk3r7Wg7XpLxDEL8JdbKiQtcuXdrMYmnehlkNERJtouogdLgfDsBILUpoSbFQ23t/CyZmUHe4V2qEDNFiyfDBkuxJ1+XaMtK+Sx1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808530; c=relaxed/simple;
	bh=x5vPF2zdApbc1bQDHCY5MbAFgU4op6PaAJerhpeqC0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsfnK1R3rcWoyvGC/lUFPSdIg7iAsgi0Xcchxcrm8CoyTQxKhKXs06k+43vY0hvFI6wGN9Y62rEthP3oQvvnO737EPv3WQD1JTdUWg/r/fBu+kY0I3U4wrb7GfijFmjPzKUMW3d1UdjK+KCotBVS3ei+aPZAbccJfbfESaqp4hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cutZm4vn; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cutZm4vn"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c26d7e951so628079966b.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 12:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788808527; cv=none;
        d=google.com; s=arc-20260327;
        b=JF4pOs1VDI4K7P8oTfZLhewSOrGu66NbunmnBN1HR6IL/Xkf+atCqhmrZMopeYZfeJ
         9mRjpl2tLfR9zni6SSceYck0Fs3GDY9IGOTP+KWmIRjgkyhRkOAM/ERzuphBadf3js3h
         CbjQVJupInc2lzVXq3E3ix4++C9JP6uzDsaEJ7qwaip5DA68pU475FBu5oZOWW3fYqYo
         edNydY+gSdvOsi2586HMtjn+jomGnjAROcPzJ6uWjnJD3/2Tf/waihtrTkySaN/Aav3n
         jsU+GZfRhxDUHM9Ydc6GTYYxeVrpJCMMxj3feRjwCaevYfcJEmhw+l5nK+mA7afQLuGR
         k/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        fh=iHUVeN116trdihIiBtZ2dJBeOMZ0oFAlqMnS0sImpfk=;
        b=LuCWAV3YFP4gU1RavCC9uaQ0t33O9NK4sOANCQVEDXvaICCe3KCxgdVzw2o42p0E4I
         kUDOi1uVbq4MXe3Ga6kM8RFTOnAvNmaStWKafC8H0cEhPvqSIhkSiIWQNAHQeGVbJCHD
         0GEuQ8S6A+j4Swb5kbYxhfnW4jTRZ3ZionRpcsYqffrWmN3DrqR/bx0IqYNen0XgW/Ge
         c0/UOP0/KkL5bNdBAakYhpPFhBSvo6/izx5wPZySNfWIOjDvvF31E641YYwyIE27+1OV
         6Djetl8G5SotKZGsePDLHu9U5vlO4WBmE6jI0ccRfKhyEGJuaF5v8ZC92mlwaQ40XP5R
         Q5rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788808527; x=1789413327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        b=cutZm4vn5t2JZOR9OMgI6pnmqYqQFfvcFwC63fGWUTWiVKer5VjKXFZo8dC1DLyJgA
         JeaS+sEUqPRQeejiN6VA+HRNH5InkI62g5gY6mmT4CmtIqHG3xgxoXiVxzJrA8AfN0/X
         /abBW0tO2dEig72VExEuxJTYAu5kRqLLxm8i6HRQ+0VTirB8F8uoubAZj67hfsLNw96O
         BBkaCVu3HHgzHYwxIfgyb4hT1cNZpUfVBzhzLcCIKbkSzu9yi6m3fqa158hrCnkcD+6d
         LxrtoCmbP+P21eFmt622XvDz5NLoRzP5zQTG0Ie8ErhkuFy5FGiCglCwIO/NXF6EPF8Q
         AhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808527; x=1789413327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        b=NuC3KKOtR8SeJ5ci7xzE6pKeCEL4Q3In92iX8gFDqT2Vf360dz1ljoLyT8l9lMgxVN
         QwLf61/jVL8EguomhmYEXDOkWyf/1/EemQ+Iwi570TH067+4C131OvYZVzu7hJSMXk0e
         ppa6ESok/P4FGCf3fR3J8/qE+vNXKvN6eUvx+Cl9Aolwcol8fXvd4oU8HtkVpvGQg1Gj
         3eeX5LFZKsznpy4khT7XuygGaikaq4blWUxjzvBOOmb7MrmE0R6/EegiTb9VkAIbM8Af
         JzrJXqqO62gdgJTzEzyLCfegSEUr3FbKan2UNpNdwyZMlD+I6m4QFjJtkiqipX60rn7f
         G5KA==
X-Forwarded-Encrypted: i=1; AKwUvBwIvFDH3qSn5nZph6roSCHXVHuSP7YzjJy3sE7jjGmV4dHjVZD/nC1txdGJtLX8p3o1MZ4qPOGY6cLq@vger.kernel.org
X-Gm-Message-State: AFuF++n4F1GlTfDjY6X23ibrFmvI3HM5F3X/T6crqVoyKaw19b7n2KX/
	ftFbFjCqhdIt28l2hWbB/GwtWal8/55NlNWLMn/GK97UtoT3BEmTzQucrmUXGiB+y/DkIbtQUwL
	k3apZisRPzX2urQ/ksLL891wq3qseSoFTkE3zvV/8SA==
X-Gm-Gg: AYBFou24mYXUnEeJEYfDZDaZuBTwlaDia8i0T8cx89LRshy/OlS5TPlUAIRMWgjlUmY
	vaBpEfZXuD/nGlv2h0t+BsefyVL/HYkupEjOmyeBH/ucMkOvRjsquH8UhGfdd1EHkxocbKKJGk+
	tJlsmS1EhMZ0bzz1IEv5Kt5NKwIrEOtXagorqSH4zUldxqW8KIXiYVtOthf8Zuekcn97nbGCeXf
	OY+PrB00QiCnwPbTeLdR+lI6YkyL8mXMzqNpxZqwivUrWBsICiXvMsulnptfRKGzNaL/rIL7md9
	Z7l1SxrRlxh1cFqcfBBGolLGBpMhnQ+bOUznZ0O524LLn+vCq0ydZkqqCSSXBnUge3Wnq1WjuY5
	TlinzKKLA
X-Received: by 2002:a17:907:c20d:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c260c9f8920mr994472866b.17.1788808527122; Mon, 07 Sep 2026
 12:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <20260904150304.49104-4-max.kellermann@ionos.com> <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
In-Reply-To: <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Sep 2026 21:15:15 +0200
X-Gm-Features: AcwNN1VSJfSMfCn3vuBaXzqEcc2QZfWjSUijicTPAmQje5KrNhk1pl3uBSLDJng
Message-ID: <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Xiubo Li <xiubo.li@clyso.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:56=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrote:
> Just one remaining teardown path still unregisters the session before
> removing its caps: the fallback loop in ceph_mdsc_close_sessions():
>
> mutex_lock(&mdsc->mutex);
> for (i =3D 0; i < mdsc->max_sessions; i++) {
>         if (mdsc->sessions[i]) {
>                 session =3D ceph_get_mds_session(mdsc->sessions[i]);
>                 __unregister_session(mdsc, session);
>                 mutex_unlock(&mdsc->mutex);
>                 mutex_lock(&session->s_mutex);
>                 remove_session_caps(session);
>                 mutex_unlock(&session->s_mutex);
>                 ...
>
> The rest of this series consistently changes the ordering to keep the
> rank occupied until remove_session_caps() has completed. Is the
> ordering in ceph_mdsc_close_sessions() intentionally excluded?
>
> This path is not limited to shutdown: it is also reached from the
> corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
> and handle_snap(). In those cases mdsc->stopping may be false and the
> mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
> __do_request() can register a new session for the rank in the window
> between __unregister_session() and remove_session_caps().

I don't think that's true for the call paths you mentioned. They call
ceph_mdsc_close_sessions() only after ceph_update_snap_trace() has
failed, and on failure, that function always sets CEPH_MOUNT_FENCE_IO,
which prevents creating a new session.

The only other callers are ceph_put_super() and the mount-failure path
in ceph_get_tree(), where this is not relevant (no requests exist).

Am I missing something?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
