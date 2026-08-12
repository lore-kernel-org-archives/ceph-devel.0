Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDB463B73
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553473; cv=pass; b=SY6CpoNyRYtQ+0yLOAqUP6oJJd+gOl/gzLPA18RUSJ3xQTH9RVYfk072Eu4T6w048ucqrdL9oFhXsTap2Lh7KoDZnCvqkrBog2p95qocH70Yz4hqJ8l7+9ZGpYrHPAvJ+5IDqTw6eCBdzuPFMf2m0E3ggNawjbTRi6yhBqUR0YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553473; c=relaxed/simple;
	bh=pJruB626C82DN3Zt62X+NwKxRbE9X9fmV+ScNbq+da0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5jugcQWRvLEtsnC+iY5td+dWl3SOR81inw4enTR3RuHXEiwOfC1nvd5H+IFPHJsvY6hsjm/hqFVj1J6vSEwpY+lNh4WPNFuBBjR6xVBJNaqQbgGQC5Ghkc/Wd2dJyyoFStqo16Hcvdf51D8Hjr6V+fmKq65sWTf4KofHjFrdJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com; spf=pass smtp.mailfrom=bargrove.com; dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b=VKT7OfN0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bargrove.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b="VKT7OfN0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4798bea72f9so640840f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 09:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786553469; cv=none;
        d=google.com; s=arc-20260327;
        b=fbBUJjLJfk2Gkx5OWMQt5zxCoXZXBNM428ebJoZRCBt7SCjLs9U9hIW7lyeoG0VRd0
         jzYyMznuCeiMO5w3atdTH42UFe51F7lTAPLnnO9m87fY2ZddkIhHFdgLNtGQr/XSvnOw
         016JNF4TLMVmLYWvxfFhos7pFdlIC6lBEc+3hGjkEOXhV0Sjk0BGLArBsTcm5kyRZn28
         Ga35GLqV2hzIQii2b4KWewb+MImHV6wze4fyxEHLE471z9NOB+KL0bJwxTWje+9CA5kq
         z+5pNRB/otzODIRHWTfWYPqDYvtvBHfaqi2EI4njZuku2BTAT3j/TUl4mVttV0n53Eb2
         Zhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7vv6vD/toBVwd2r8Q2xZVze7Zj5dG+bA7FWoodChzoE=;
        fh=OUkOnbBPUeqIi+sFVFVtH/Bu5PYK5iMyny7wd0/JG+s=;
        b=JKad1n5kCXqGyZvSwgr1FPdRL5xbp5lh2ALN3tAxXCtIMPHPsyk37+7ComKg/3mS/J
         UDTmbvjqUTPCkopBamZ2SxlFhQPSScky+WQQgI3iQ5ZqjQz7z1ZNsFMEJNApn3dhCrQl
         ZhPf6hjsdFbal/7U5mOGn12EJ2KjlArJ59HS/RhY6gJ7a3UV2yLvK3kF5PXESWjYWK3H
         VaRZrI1Y4JdBw6FtbsL/9IcsP6Pz6ex1dHpk6FWJUU+C95j1Anzt9qJwtmNW/UgPcY9F
         v6FKPoPACi1ENyaXpdPEDnpJ0Ek4NMl79n7QKeR8URIIQAYXTBypdPPkBDVd9mk6lGfA
         BvzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bargrove.com; s=google; t=1786553469; x=1787158269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vv6vD/toBVwd2r8Q2xZVze7Zj5dG+bA7FWoodChzoE=;
        b=VKT7OfN0L+PgxPS8I09sBpJNLD3KXoz6X/GlZJ6tdaft/CQE07nP3Qlj+dlVg3fbZ/
         yIjEJCzD29UVUVtKL3VwOizP+0/FJ7XoNZs2VwCYnr4Gw/HjALflowiOJkG8jB0yErMG
         BJltHazepz122gSRYyTRPojyP82jfHKKIIWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553469; x=1787158269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vv6vD/toBVwd2r8Q2xZVze7Zj5dG+bA7FWoodChzoE=;
        b=WTayKXK2+HNkex9Fex8v/+xEk1oPcdRGOag4YVYCyFR0nx6WT7thsx5hTMZuNtXPFJ
         cnZeQRiuFW+Kha8vkpBUUHnBaCXHEbQI6a+lfMeP4/e960Pe9it9BF1WzkAe7xQb5cP2
         ga1mj2O+vdBwf9KXlzb7bUntGZl8CIyvFnbQpWZIFb2qhNgNiLkudzfQvoGuEk3xk7JM
         WvQIdeVFMNtbVKTK1iIytm/DU8YILr2N8noeO49RLY0+KspqEiumXbz7Gvs79DyOEpM3
         gNz1yzdAaP1ppkDLD9ZFQq7NyBC+fQlnidFCzGNTmAGLd49sY3LMKS2nh7Ep4AbIzlqY
         tlig==
X-Gm-Message-State: AOJu0YyzVtlBVnVEAASOpU1tT/E5k5U9Kc8dpzdaMkWsNydQw6e3O078
	pzEmCzUT3Vmnh8n+9Kt1FBTXVH7ED9DaoV16EM4a5uGPJjCoelUiwmoFoimGoDAwblFA8sCalbT
	Cf/5GZfIjEM6OTBZN4UtEJ04039WWiffnNM5GfzTBCcnrt3mzh3rbDdEkiw==
X-Gm-Gg: AR+sD12C6mIJPCjaJ+IoCARii1PuGTC26vpIOXRQvFP0iR19v+UWcXzQtNZjHWu0Mgv
	dJcMJbFAAmI5ehlxUfUqheAHoanU7F9pGPyjhnzJIVBf6y/FDJ6A9BmBadDotu1LS+cWy1dz2yQ
	B5yETRl5vZSgfjvWRdSsEUUDMnpTPXoB1uSYMHHaTnF+/WQ3+wonN2QNZJg5V46klGtn97lqWoc
	tyDur4mqcY0LdAE5JiW3FcX/VxQ9boHu5YVET+fZSp6tvaR/ywMHWVRs4uYQOeZ8/mzuN/Ribhf
	vHphx6yTCERgzFlicTA8N/+WwMer0gYi9tLYGss0ABxCfKMw+sA10Ou/duK4OpgCaer2A2gyfp6
	61DPlfiJ2pruE
X-Received: by 2002:a05:6000:2287:b0:47f:7526:598 with SMTP id
 ffacd0b85a97d-481528a9ba2mr9085955f8f.12.1786553469287; Wed, 12 Aug 2026
 09:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808101425.49616-1-matthew@bargrove.com> <20260812134219.3306354-1-amarkuze@redhat.com>
In-Reply-To: <20260812134219.3306354-1-amarkuze@redhat.com>
From: Matt Brown <matthew@bargrove.com>
Date: Wed, 12 Aug 2026 17:50:58 +0100
X-Gm-Features: AUfX_myDWxe_44QzKb7QUNAB32epbFkO0PzjWhy4leW9apo3QNZ0MWN7jubhtn4
Message-ID: <CAHpZVt_c_eixPai4TPNZKvpt=Ve-X0mVe87hczgHejPQujPX4w@mail.gmail.com>
Subject: Re: ceph: fix leaked inode reference on writeback abort at umount
To: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	linux-kernel@vger.kernel.org, Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks both.

Alex, thank you for the correction -- you're right.  As you describe,
an aborted (never-submitted) write orphans its wrbuffer claim:
writepages_finish() is the only release path and never runs, so
i_wrbuffer_ref never returns to 0, the ihold() is never dropped, and
the inode can't be evicted.  v2 will rewrite the commit message around
that, and switch the helper to struct folio * / folio_detach_private().

Xiubo -- on the ownership distinction: folio_clear_dirty_for_io() is
the ownership-transfer point.  A folio reaches locked_pages only after
this call clears its dirty flag, and the successful
move_dirty_folio_in_page_array() NULLs it out of the fbatch, so at the
abort the two arrays are disjoint.  The locked_pages entries are
exactly the folios this call dirty-cleared, so it owns their claim and
must release it.  Everything still in the fbatch was never dirty-cleared
by this call -- under writeback by another request, already cleared by
another writer (folio_clear_dirty_for_io() =3D=3D false), or not yet
reached -- so its claim belongs elsewhere and the fbatch loop only
redirties and unlocks.  I'll fold that into the v2 message.

The code is otherwise unchanged.

For what it's worth, I've confirmed the fix on one of our production
machines: busy-inode reboots on our CephFS clients dropped sharply
after deploying it.  While evaluating it we did catch one residual
fs/super.c:650 panic on the patched kernel, but via a different path --
preceded by "ceph: ... umount timed out", i.e. the umount drain wait
timing out with inodes still pinned, not the writeback-abort path this
patch addresses.  I've reported that separately as
https://tracker.ceph.com/issues/79436.

v2 to follow.

Best regards,

Matthew




On Wed, 12 Aug 2026 at 14:42, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi matthew,
>
> NACK for now. Thanks for the patch, but I have some concerns
> that need a v2:
>
>   1. [major] commit message: Commit message describes a nonexistent redir=
ty mechanism
>      The commit message claims `redirty_page_for_writepage()` calls
>      `folio_mark_dirty()`, which re-enters `ceph_dirty_folio()` and
>      double-increments `i_wrbuffer_ref`. This doesn't happen. The actual
>      chain is `redirty_page_for_writepage()` =E2=86=92
>      `folio_redirty_for_writepage()` =E2=86=92 `filemap_dirty_folio()`, w=
hich
>      sets PG_dirty directly =E2=80=94 it never dispatches through
>      `->dirty_folio`, so `ceph_dirty_folio()` is never re-entered. The
>      real bug is simpler: the wrbuffer claim (i_wrbuffer_ref,
>      snap_context, ihold) is leaked because `writepages_finish()` =E2=80=
=94 the
>      only release path =E2=80=94 never runs for writes that were never
>      submitted. During umount the osd_stopping_blocker keeps failing, so
>      the claim stays leaked and the inode can't be evicted.
>      Suggested fix: Drop the double-increment theory. Rewrite around the
>      actual failure: unsubmitted writes orphan their wrbuffer claim, and
>      releasing it before redirtying lets `i_wrbuffer_ref` reach 0 and
>      unblocks inode eviction.
>   2. [nit] fs/ceph/addr.c:1429: Helper uses page API instead of folio API
>      `ceph_undo_wrbuffer_claim()` takes `struct page *` and uses
>      `detach_page_private()`, while `ceph_invalidate_folio()` uses
>      `folio_detach_private()`. Functionally identical but folio API is
>      preferred for new code.
>      Suggested fix: Worth converting if respinning anyway, but not a
>      blocker.
>
> Code fix is correct but commit message wrongly claims redirty re-enters c=
eph_dirty_folio(); needs respin with accurate description of the leaked wrb=
uffer claim.
>
>
> --
> Alex Markuze
>
