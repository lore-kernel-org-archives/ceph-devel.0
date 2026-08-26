Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E862253FC
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712756; cv=none; b=d84LDnVPAMqJVnQkQFu2L7Z9dWpmJBGy80mEoMd/lc8HSHwTGayGipQsnSHzNfOxG3pf8tOvV6ZWHucwo6RJnlPpwNckuoQpmbib18KM2a9z77NXC1HW87B8qm1E855StSnKDZ8NhX+lhwMFNcbdM6vlK0mARnOuya2bA58Bm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712756; c=relaxed/simple;
	bh=hwUSa1nRd1SwllZhMoO2spqdmX2c4aOTqYJxzj3itz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDBBnfQc43xWGbZvA85Xm4avAskEliG3XTMSnQRyERfrnVPGGVutf/FaXgeUhUOldZKend9Oc9SOajN9En0UmSIks5bLILIp9paEBzlvIADC8kyPU1LC6DbdrHhl5xlXsoehQDpR5Grh4pQmmVbmffRIgZox1o1jUqSmloE/rPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKMMeamx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKMMeamx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924091F00A3A
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 02:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787712754;
	bh=E2X9DS9pCWUk49qxnYpeh/o8NmrhP23AJZnDYf3SMkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OKMMeamxW73OWrsOerOeeumoCKFc+hTazNRNd/z2CJQy+9bpG2verFnh4W5a7UQ5S
	 s88rlO4Z5h56wsGifFiAdPvjSvi8jBw0wmtqoUehwGFu/vsRR/dST2GfTgFSj+8S35
	 wapRGhylRhPnJ8E6rZuq8HgCIayLK0A7SQsBO7GVNYxkiPSIjqZ4ef9nIrnMQnBWh8
	 Ul7UR3ZftBow1kKR3yNQbcXStP+dOajI4Eswtl5lCpyg/iFd149jyccBxRMoCp84Fm
	 qfAVCnLpB87mU8w6aL7kNRL5wG7g8jiz6Rud6kzbHOT6LbW0v3sAFftd/zmJ7nPcy3
	 YoJniUj0uM5vA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so3556961fa.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 19:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoPE7tlq+Nets89CgmeWdRIdx5Akfaxx7ej0sK2eRJqA5oK+Qf0CZXrIQNzvrqOQ9G0nyV1UJYB7Aan@vger.kernel.org
X-Gm-Message-State: AFuF++lzDdiHBKF4Z1VP46ZxIveO3pJTiLQIunypAFPgwImztLS/yGWo
	m4/9Ev21OFDTqaGHVxyOAk8CntkupceRhzSi8QEtNA1nF/xla9BK+xtHJIYaAFPmpmIB66jWraV
	xAUP+cDvkEbHjF0JdlI897idk2Ef+9Z4=
X-Received: by 2002:a05:651c:325a:b0:3a0:f4e4:9262 with SMTP id
 38308e7fff4ca-3a1fd6a4dd1mr6492481fa.14.1787712753290; Tue, 25 Aug 2026
 19:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 25 Aug 2026 19:52:21 -0700
X-Gmail-Original-Message-ID: <CAOuZWzxWz062Xhzrc5iasq+irppRCG2SfriYEnGPOQXuM6HOMg@mail.gmail.com>
X-Gm-Features: AcwNN1VjMX5RDtEbj9QInQpp-7DkSoswjxJKAkSm3W1qm7ppo615dYrNG0NHW0I
Message-ID: <CAOuZWzxWz062Xhzrc5iasq+irppRCG2SfriYEnGPOQXuM6HOMg@mail.gmail.com>
Subject: Re: [PATCH 0/6] ceph: convert the inline data paths to folios
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tal,

Thanks for your patches. BTW, we are removing the inline code please
see https://lore.kernel.org/ceph-devel/20260729-b4-ceph-remove-inline-data-=
v2-1-db0c92dab8ee@clyso.com/.

BRs
Xiubo

Tal Zussman <tz2294@columbia.edu> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:49=E5=86=99=E9=81=93=EF=BC=9A
>
> This removes the last ceph callers of find_or_create_page() and
> find_get_page(), and one of the four remaining calls to
> __page_cache_alloc().
>
> The last patch converts the direct I/O put_bvecs() to folios as well.
>
> The remaining inline data struct page use is the single-entry page array
> in ceph_uninline_data(), due to the OSD client using page-based data
> types.
>
> Compile-tested only, as inline data support is deprecated.
>
> ---
> Tal Zussman (6):
>       ceph: use a folio in ceph_get_caps()
>       ceph: use a folio in the inline read branch of ceph_filemap_fault()
>       ceph: use a folio in the READ_INLINE path of ceph_read_iter()
>       ceph: convert ceph_fill_inline_data() to take a folio
>       ceph: convert r_locked_page to r_locked_folio
>       ceph: use folios in put_bvecs()
>
>  fs/ceph/addr.c       | 70 +++++++++++++++++++++++++---------------------=
------
>  fs/ceph/caps.c       | 10 ++++----
>  fs/ceph/file.c       | 32 +++++++++++++-----------
>  fs/ceph/inode.c      | 14 +++++------
>  fs/ceph/mds_client.h |  2 +-
>  fs/ceph/super.h      | 10 ++++----
>  6 files changed, 69 insertions(+), 69 deletions(-)
> ---
> base-commit: 86f405187248b7a5a2104eba07f941d27593893e
> change-id: 20260825-ceph-inline-folio-17bcdb200850
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>
>
>
