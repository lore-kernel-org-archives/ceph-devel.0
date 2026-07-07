Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD85316190
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461763; cv=pass; b=diAtyak+wt0ihoZk1tr8SoxfSNuzwVS7/mawZ87gJ/R8d2TnZ0i4VNluoL8vmUaIphxzsjuHl9FHq4oEP0Ti2a901eWPb6X/wROhwvLlsfNj2cxAwvaGkOHkXrsu6qUB1bd2tR5m0NaDysOyYyCUfsILZFNKex4XaiC/JljzKas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461763; c=relaxed/simple;
	bh=lh2rn8ARyycTnkUmIt4xcMInPF/hzqU+Qq/YcStSkvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6YI3dgeUq6pdrI4Ty5GAYalqiri//iNKY80z9ceucm48exPHsSNAWuLdaifK2jPnKeT5ZISongS+ZpL2LjLwQxkZzE2PlDgHbY3HkwVR9T0xE3wiJSQXBC3x5Mxh0FWuWi/1CeO6FYl+4KpG4fhZ4CqbWHTe/HOGpt/FpOUzWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vq/3X8nC; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vq/3X8nC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c12c22d0f86so7442866b.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 15:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783461759; cv=none;
        d=google.com; s=arc-20260327;
        b=WXQLCD6orJbqxYWeYFV2/n5EHO+/WOf2+cK2iAXrg1LtftZKhveN6qXI8aQn/MzH2I
         qZd+uLyIaF0gXx2YbFHSkgflnMl+Rdk0Ot4yU7YbSlWZP9GJr6PxoRyDlPxj3SRaiHJb
         t4LU0GHM92sDKq9UC72jcdgluwjiNMK7ERYJFwCe5ZNUNZzjsFYVdnrxXp9B4AULEXwX
         o2idetO69yQPpom0hTAuOXrVdtkkdBsxHfiC9SJ5m8Cs1MJJQbbRmAACCSZxipUgo657
         8bpZxxTIZuygGdMbVj+Dk9vFSMbr93gat7yOy26eny63ncGpTr88bqeePM8E6x5VeLsR
         WXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJOOrPSclHz2Mec2NzjmxiBZyevEt6mHzo5L2dvOMeQ=;
        fh=sdaVl8TMzIKGMM/kQnuywuPPGO7AjfepORUONnWQH4U=;
        b=P+yY8RA6pZDosw4IGnXSo4XWh0tWm4doyHp74agVKAJNGnGZoEjlY3O0fpcXEO33fh
         wGxnp4Vs6fAEOjCDj2Ai6L5jqj1nmjFo1LiXrc3rirS3ZiyZ6fjEY+H/sZJZfD88JauN
         JZaB7Wp9lr9x9sRFBiUReWXukQbJqCpt9v8AipwxTYp3fnGScwAO4UXGyH4HoZfHUhxA
         zH1k5jZCsr0MBnrgUrO3Tr2n92EHRtyvRs0IYgCR9gMZlG8kxJUvNZasZgyGFPRnctVW
         Bj3c6dykfmLTJMH5noyTu6g26quCwgPu/VjXXQFaeO+k5YhaY7sLiX1Vq5QwbSwbaXgn
         m4Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783461759; x=1784066559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJOOrPSclHz2Mec2NzjmxiBZyevEt6mHzo5L2dvOMeQ=;
        b=Vq/3X8nCzq8Dm6+npUSxBGn0PWshLY1EowUTJ9lHYPWT6CA71KTpduTFNpVVxWmI0Q
         GKoVY0LrMQV7Uq7Dh8dVd2FuuClh2AYo7oz5FoUe+kPqFWrA/BxXE1KftyVV8zTQwZKs
         lXCuLobL3KasJGGpRjZ81Q49efVI0PC9gv52hTdC5+TsQPVNM83fgjMg3ccFGz8/VAvn
         di7gR/TJ4lXOchVUQwGr9J1UpovCpOcWmHQ7AA5zb3oed3sOI2TMYdGeBYbnNOuCRP71
         ev5+mB1pj1kByGf+AbYjYIC/G264Kh/JXuvSQpqa/BSTy+iQjvnAsumG3ThIIWSUPHcT
         mbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461759; x=1784066559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJOOrPSclHz2Mec2NzjmxiBZyevEt6mHzo5L2dvOMeQ=;
        b=tIkApDh0GYuU68QIC/02XzjFHt7l8cBloK1FU0+8q3nJR0hyolI0Jwhk52yeV9UYxu
         Z4Dy+iVLBsU6mPGGFMqRynRCo1wd6myapAxa+RfJ7k6hIW/QRWevCQsKzyqHbOVQMoiy
         loIOS/9BNmQ0vdOrBall/ZtMHw/U4LeEaQZ6UyGZmZYHWBTCSrBii8ugz4MVTNEEyEPt
         CwwpWytLJx6vEkL8jnpGsdyfGQZnBZsAXnnK+L0dggbiD+mI4hPcwqDBj5W6asclQzo9
         u5fP9hIkI3/QHoVc5ppqKllKTvr2oU9nHjEfwvfrt1NoAfUeSKOEAarkRt8V3G+ajxon
         OXeA==
X-Gm-Message-State: AOJu0Yz7Ex7Uku7bVZzxjv3KoZEv/JIihXBBMiPZFggczVubAjoXZmT8
	heUv8w29pSX6GVktYr2KC5mV8Gc1c2ZbHYqwFKjL21Lqv6Z+110w4EvmG5KIgcRlLeRRmCzNumJ
	6/Dn7W1VIB7FFGmW4DxZuMd+hsRIk6ZssEUPGJIEAEg==
X-Gm-Gg: AfdE7ck9Rzh+ek98QjjEVIfSJ9qw0xcSI/KHvu0X0rErPeYL58hhACq+fWltJIM6EdY
	bZJh6T7mMHm5ZUM+6+VIr/wylcYlxcAqLSEGHRYQFPwX0feb2i6O6fbRKBQLhLdmgRdlywOCu7s
	BvbzghsJCRsurfkJejG6tKOFpgkGtuIKCp1CsgjVnIAVqTXHgEoDhgbimeEe1B+HovQbEznx6Su
	0XIqzOwvUVMhdLnl0zObpMx+HO2fzCxhhKsnqcbSF5PbJA1nEs60u3YjhKlEsIid2Z3lAk126RB
	lybRURZNjOJwS0qk2J5m5rtJGw==
X-Received: by 2002:a17:907:c30f:b0:c12:a9ad:68dd with SMTP id
 a640c23a62f3a-c15ae59d03fmr259445666b.0.1783461759550; Tue, 07 Jul 2026
 15:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143843.1980879-1-amarkuze@redhat.com>
In-Reply-To: <20260706143843.1980879-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 8 Jul 2026 00:02:28 +0200
X-Gm-Features: AVVi8CedzM2HNcVeY4wUJaYQ23MAODN104BKHrIZaw6b80EGDNBOCl-jK_-R7x8
Message-ID: <CAKPOu+9D=++vF+gkXrVNHMmyNYg+RmQpNHJQ51+qmEkk1DeQ9A@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ceph: add binary logging (BLOG) for CephFS
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubo.li@clyso.com, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:51=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Add a lightweight binary logging subsystem for CephFS that replaces the
> existing dout/doutc text-based debug logging with a binary-serialized
> format.  Log entries are stored in per-task 128KB page-fragment buffers
> and exposed through debugfs for offline analysis.

Why don't you use tracepoints instead of adding this huge complex
subsystem? I mean, 5000 lines of code for something that invents a new
(and undocumented) tracing framework with no existing tools.

Tracepoints were made for exactly this and there's plenty of good
tooling. Everything that does eBPF can easily interact with
tracepoints.

Last year, my Ceph tracepoint patch was merged:
https://lore.kernel.org/ceph-devel/20250925104522.3501812-1-max.kellermann@=
ionos.com/
It would be easy to add more tracepoints to Ceph (and replace all
dout() calls with tracepoints).

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
