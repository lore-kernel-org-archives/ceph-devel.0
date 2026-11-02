Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793653278;
	b=ReUl8YKHV8P4QiSqVxg3858DArMeL5pItU2PrJpZ0ff4LupqLdw0nOvNM+Pm5hk6YK42
	 PmIWWH32ZrF7I5HKWEE6va6xdDlbATizbRbSAZhQgKxKev5VCus0UvdxvmosxYrGRwLBr
	 sgYOCbKCLsnrmdEh71tP5YFoKGnNOXE2T+Hx148GJFqyyIFZuhkmQ4qPh7ylvM/yMgoWp
	 p9Z4+y2Ql2NtQ7GKdCZ3Kxh8Dzc1VdqbjU799om+R3BRQiMFMjVSX4P8wec4DI+/xBzFD
	 CQUMbIFoewXjNw+h2m6hCSunWb8fiH/9wPYL2PWo96YpmBQypAYFfDI8AVTQS46zkMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
	b=QSD+fc02lfm1Pd7xAon7rfB+FarCl8Xv6YONPxkJHfWnfGLp1dyu8EQ5nzcNk81P4zyd
	 +ZMVXlh+ihDAkuCL+2KDyw82e6OlMXtb3jkKfa0XqTxBEYpRaJpDsIRmf8/EE5avWJMR+
	 AO1xlBcYsBsrmIrgxHJ1bBENTVg/AiMbpOZDJ1oYyyYDp/swIlK4dH4jvviSIbAInVqgM
	 l53SIdH7VlAxFysMPPqbhbmrhzjzFrJeZyFcHipa2M0JdSoltbzcSW0pBekyLK+OzDNz2
	 KXTGjphJjIc0xaU1Ph5/7LFAckItiKRRjZ3vti04CPyyyGHZlVtwqvkyByy/P5fQWJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBfI2ztt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583A606A32C
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 21:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5583A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBfI2ztt
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso2288944137.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 13:01:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793653277; cv=none;
        d=google.com; s=arc-20260327;
        b=qRkcoK5sT9YeqY8/1r2gYawY6HKCOMvu/nYAXAfmb1Hqmmc6ldr4duJzKX1dHXOnKm
         F/HgXocqLIB3wGVwFFxDN51lAYPM6Yin3nfi1V1GLYszPwzimEgMlbQlrXwZ/H3Md6ng
         lJtoZacZipZt5944CeVBxD9U6QTEra90b0niUr3os7F4UZgfIVBy+tMZz4g2GUhxiJhm
         jLqu5Wx+GT35wK29OEYkKJbFUF8dn3+rGB0jfnwBtBrEfxb9CxVJrWeDlXdH7aQauFQv
         Bz7fSjrR+QZDlQnU36bjJtxCqaY5Fiaz/Wl6MXwyXmakFJqHJKvt0PUqMLqhY8fWpv2z
         q/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        fh=MW8v9vT16ndla24RvcABfdNXoTq2BQR1B9VifOjW1Ho=;
        b=R6/Kr2HWNmMD5BPplQg2yKH3FnQzh691/TlommukNacLBNi9I5oO1cVuKvUljXtYjL
         Z7OInMQ2R+bh4rL5H2oEHvMgBCsLgVQpzLpFskLHZvaXWZst0+9vKiSWSs3s6pspycEL
         h6T1ogCMQP5vAbK1tbds/5a2P6VvgI7Q2XvLIEAvpVkS8rNB2KPfgwLRxA+TOpt0j5IN
         7iATw9Zu2EX/Q9hTBQirNPX84R6/wYw4E2iOvn7EB6RTtr0pi9BqcpTTCsPnpPitEEEU
         BDc3DvXU7HaO+++eh+Fr5fw0rIPMlcTWSnI8lzifa1mxeIFWAh+6e0Za6m+VxLb1E9BW
         O1sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653277; x=1794258077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        b=FBfI2zttRykbqqNw8z4HxKujtiV24G4bOxEEs5/kej5apLbtjvnvYOBc+nF5msb0tr
         wpFZv2PyUKsW+dAhcTzl2EUePlx/KlMAZbEZ+V9pWxIJrRI7PN+/g5CKhcSj45lSSMCH
         BBUMM+RaDARP02KWS8ROuyOTDeznVnRCw87a7EP0D6+5rKL/U8B+MBJLRkjIF3AHq/g/
         CDKCIwW+Nf98qaz2WYB4KT6oc+6mI0okbGWx4hScMOU3Rx0HOEgOVjnSL/Zcg+hZplaL
         Lk+wdHscQT6TCk8dIPg5bYAbnlExR1UM4Pbku3Q2p8D3bnzF7tKSShDOqzrNwdkUVCai
         lkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653277; x=1794258077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        b=rlYbvsNNc0ao0RA2Jmgt59krCI0/mpbV0Skh6/TYLv6VWVMFkCFQGUDPVmqf0guKIZ
         YHa+TDrzL6MhUrEGKTELTvDC+kR1imU66BG1jd2bQxHx2c+2NoBrYo+dkY+FCahyMRE6
         eDOeaG//C4osHrcuGEMitVNPyE7sm1jKMjTwVzuF+jso6SNLUz086xuQrkusJXOxFjK5
         whBty38a+ulO3KQg288mNkJ+ISLFdyLaq8l48n6RqiI/wF/1m6GJf8ie5QMR56CNY+BU
         T+9qrnd2gKTVAGIpmeXnHgjRU+ITCWaW9x26rhuAZBxUR0gx6B3DHZi5wHXDiz/bhr4T
         VInw==
X-Forwarded-Encrypted: i=1; AKwUvBw4dJFQrnGeFnVhqwEdCd/st0SfvM991upZAmDaIWtLA4bIAhlQUaimxxE7DSonnslZwvZUGdIG48zf@vger.kernel.org
X-Gm-Message-State: APuU4Z+qz5FK9YfI9jY7V2QHGJm9kCeALXqIRuWPo3lPgI83OnNcsItA
	LYMHo9T+O1BgJqvkD95E2LopOAk+cwzLTkexiua31Ozs6es5xm9yCryqhts0osnIQMIB1L/qXvh
	6V5SiOYBRdYvReAAv/+PbOD6vuJoJ84M=
X-Gm-Gg: AYBFou2KCpCp6oUwO95dzdPem3m0rY8qnx/3c4b3RZhp2W5TadOJZNMhG0KXASbWv8i
	v3uIO6sKLL+TBDYtDAWg+vOiYjlK87Y8zk/Udb3HfTMR2HbFyXkB/ZolFk0AYxo5YlPIlmKYh3b
	jbHWvki08LA+rdz637QeidTU8+4c2li76OBV2vvqY347ctRHrk6zB3h1Xx0pYIjA2e2IUUfcGC5
	mkmineoe53co8jYGcysIfyxZMK/3BTPJDq5Nro8qcvzc4vKqiZz9BK25sAo9OFlnUSeTThpJFtX
	qzR/uEzY1Hbsy465wT141yl0FL+XjEaYF+YrzbqNxoXB6s7Srrh5ZvG2MGc19Ej0iXMWtEBv6yC
	rQNjmNFs0mZz2kKNfkTvA8qgFq4NcH0BGKAVqmyfE8JesjDUFespeyGXSzKv/ME/78uTKaHo=
X-Received: by 2002:a05:6102:5811:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7d072c305d3mr5019729137.15.1793653276174; Mon, 02 Nov 2026
 13:01:16 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902124026.1774575-1-max.kellermann@ionos.com> <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com>
In-Reply-To: <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2026 22:01:04 +0100
X-Gm-Features: AclHuK_u-vaHTlw45n1B7ztDg1G2EXvymWObtejqyMF3Kk8CGrlA6DuBbpPPY8o
Message-ID: <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: acquire caps for read_folio requests without an rw context
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:55=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrote:
>
> Hi Max,
>
> The fix mechanism looks right: a NETFS_READPAGE request issued via
> read_mapping_folio() with no rw context should acquire caps, blocking,
> before hitting the OSD, so it can't race a writer that hasn't flushed
> yet. Two things though:
>
> There is one existing Ceph-internal caller that now lands in the new
> blocking branch: ceph_uninline_data() calls
> read_mapping_folio(inode->i_mapping, 0, file) from ceph_init_file_info()
> (fs/ceph/file.c:262) at open() time, with no rw context. On an
> O_WRONLY open of an inline-data file with no recent readers, RD isn't
> part of the file's wanted caps (__ceph_caps_file_wanted() derives them
> from the used fmode), so __ceph_get_caps(RD) takes the -EUCLEAN path
> into ceph_renew_caps(), which raises the wanted set via
> __ceph_touch_fmode() and issues a synchronous MDS open request. Such an
> open now pays an extra sync MDS round-trip, and open() can newly fail on
> MDS errors. This read also doesn't need caps: the OSD object is not
> created until the uninline CREATE, and this path intentionally relies
> on the -ENOENT -> zero-fill behavior. Could you handle this internal
> caller explicitly (e.g. have ceph_uninline_data()'s read bypass the caps
> check), rather than making every cap-less READPAGE unconditionally
> block?
>
> The blocking acquisition now happens with the folio locked
> (read_folio contract), inverting the usual caps-before-folio-lock order
> of ceph_read_iter()/ceph_filemap_fault(). I checked the obvious cycles
> and didn't find one: a folio that reaches read_folio is clean (dirty =3D>
> uptodate =3D> read_folio is never called, and netfs_read_folio() diverts
> dirty folios to netfs_read_gaps() before the request is allocated), so
> the Fb-revoke flush/writeback never needs to lock it, and the truncate
> path uses folio_trylock. But please document that invariant in a
> comment, since it's what makes waiting for caps under the folio lock
> safe.
>
> Minor: the new branch hardcodes want =3D CEPH_CAP_FILE_CACHE, while the
> other read paths add CEPH_CAP_FILE_LAZYIO for lazyio files
> (ceph_filemap_fault(), ceph_splice_read()); it may also be worth
> aligning.
>
> It might also help stable reviewers if the commit message notes that
> current mainline erofs fileio reads via vfs_iocb_iter_read() ->
> ceph_read_iter(), so the trigger is gone there and the patch mainly
> matters for stable kernels and future direct read_mapping_folio()
> callers.

Hi Max,

Did you get a chance to follow up on Xiubo's comments?  Particularly on
whether the data corruption aspect is indeed gone with EROFS switching
away from read_mapping_folio() in the upcoming release:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De587a984d332b76ab89fab546f1594f61f73d5f6

If so, I don't think the Fixes tag applies anymore (although it was
questionable to begin with as this patch is fixing an oversight in
CephFS, not in EROFS).

Thanks,

                Ilya
