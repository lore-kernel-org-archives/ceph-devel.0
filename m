Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8E214813
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835981; cv=pass; b=uqYaHXEelxSiLvB2kvfHOk0iADvNZ+NDpx6RllEOEeCPhtd+PeWxgY5ZPFp8Y57Pb9kWrlRCqg7JAp8ptjMSPTaRLlTNVYae6UX4gztjAmP848FJQLm5/ryHi2AkiPLAXJYN/P0gWeaBLY6vH3wynKRrsJUmO7V/+r96eM5N+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835981; c=relaxed/simple;
	bh=VQFK7ZwMB7l+3tnBDAMOGl43tMqCD1UC+16gpsfhLoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3MQ7aZ0l/CnnYv1Wd4yMjCzNqd9QpOw3uOFOQ+T4bZ4S6G/UOWnwHNDJ4PDSdHefcj2v183Z9FbmEAqBV6jWYvXwb3bGDRXL2AIgS/YE+FPfhw83X5lhp+FWxp75HQ9VdCxWhp6D2/q1D8mapX84UoUjQEd4OorhE49WSaKomY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EjOeDJOa; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EjOeDJOa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c0e124d2a21so560222866b.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782835979; cv=none;
        d=google.com; s=arc-20260327;
        b=EM4KMAa7iI8YvOWbcgR5oym9SsPf30u42Omnkeuxs3NMWt4DzCEj9h5Hn2c4KbuTpw
         8JvDmQIubFbnMLVtn1luahRmmkuxfFEjJG6WOz+qg0WUlZFiA63FDATk+zuRmssZG1EX
         8AFbpmxtpdaZPwPuSbieS0QUNYAmYlugXYz68MTHxBIogWwu/YeZjvdioCVnv+vdDwTf
         8E2OiJAUAPfTrOk7uOl/rn4Nef/x8E5VrdNtJjKy0MLcfbgc8bFDO9/UdyOLmbZeIHA3
         Ro9yczD2NNEkiQRYB4/bMvJomTpH2+UDCQgdNX3c6pkqyMrjopmlRH1FX8/2FHm7QfmZ
         wo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQFK7ZwMB7l+3tnBDAMOGl43tMqCD1UC+16gpsfhLoU=;
        fh=t2Fim6qITV/sC31yEazkgMJrxpgLn+vGUxaXiFLs2Ak=;
        b=JyjMve0+qjdUzMjge0wYZ+KiY8nu/064zDLk9KfZWdECHvYoXCWFc49Rg91cmt8gaO
         t9WuRgHCE/0SRPP//DTFczHuQuQeaVJwN+5iroQSNGI00vI07/m4LopzeZFeytgJznyv
         aOMRNxa0y4+2kpAb0UXSaL2gA+70HDpPqOs5uBJIwd9jN5w53oDq7E5VoNxuZqpyEayJ
         VVn8a0Q5GCKF49ZEpcObpz92qZK/aW+qYMxb1FfM5QM5dwVEPbU2AvHc2MPne+UmCIAP
         QCeRt0EnvqouywaGuohS60JV5V7hmavFzGRq9lL3o3+u+W7WvmVuAFKwJeQM+PsmaKH7
         LGuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782835979; x=1783440779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQFK7ZwMB7l+3tnBDAMOGl43tMqCD1UC+16gpsfhLoU=;
        b=EjOeDJOa4aw4o5x1MRnmUxh7BVEWO3wxJEMWFYE6JicUSv2i+6qIlMuBxyz3uf7F5S
         U56sHUMHAbPHLYnKcADis9RggUQmQ69f5IvfuGSsiU+ElIoBxDC+GHI+4GvttDq+1UCE
         e306QyE3qOBNl5atDumDJHszNPYEArZCR7WpPp+ajcGm2bsZOhehJ198IhEBZjhjDcUf
         /Hziyvgk/tCh3vQJ8X0C0iXzaqRsKh8IEqJCBY0WQQXPDqVQ+bJ1556XGd8FwpSlxglL
         +ZsvBZ2qUc40nTH0vXG/DEDWl84ugbVHxpED4pvLnAQpG96HDKl2BlT6Py3TP8/p8eT7
         v0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835979; x=1783440779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQFK7ZwMB7l+3tnBDAMOGl43tMqCD1UC+16gpsfhLoU=;
        b=HsnopQRaLw69fvLYY85iJrkMnWfAw+rKaXGQ+0Aic7q8feeJrLy0ofGoFgvQsmNI3X
         YnbdoXzGU6LCRBWKDlCGmXKyKpBQvINnNmRMbyZ8nf20BkaqDQRCeMnL8evlJ+7hthD/
         +nfICHdyy5Kb7JEXB7wr/nAKJME4HcZ+Alrpg7UE5f41Ybr1ATahIgDRL72Dk6Fks/Qu
         amVY40TPeFdGZNjnaqv6lMhQBWZvAZy30OPn20X5FPhp3T48flMqP+w7ya4LyIguBndB
         rVsh8UFOQoX5WfvKm5dnnnxuAPezX2s5GjWXLKNoiY21jWM6jQrHm75/bCWG1slci3NF
         zcPA==
X-Forwarded-Encrypted: i=1; AHgh+RqyYwy6rf0PKS71OiBoFXqERGL7X/M+03/3RkDVMKIRJc5UAYmaVFe8lthx6bV8Jvkh/HPs9CSgZ64/@vger.kernel.org
X-Gm-Message-State: AOJu0Yywq3GmrbfJ3XRINzgrwp1VTdGixX+G3IiBHTMxb1k7gIwzUsTq
	//SN2QdnSM+59vKhaltcK6B2n1qeFiwDE0O/ihL98xMxcNmmDcIjqT5q9hkIa7Bva02PNYLxDWY
	9Rdx2RdQI+Xxjr96tIqEPb4bl69NtkAPZfedXbbUrNw==
X-Gm-Gg: AfdE7cnZXDOMVgP2IZajwEhvZdn7Y2OK/cyexduwmsSYE+E1uDi3F3GwkfNL3Oj7NSf
	M4Y0F27hjlkjtGf3OTjV6djzosf+0X0/nDVOGgZIaBll7afqifc+K+D9mxt18sKrOUEUXGklfVU
	Rvkysu9sb6BNhiaAgE2/Z2ew0rI3B9ZJj9Cc1qSp1OhSgIXbxdKBXeUpxGqYjp+dUBrX71pboL6
	QncZ4bob59cqM5hG03XfprgODYlVzU7+cGUr+U2kenxWQwVHuaqHkhk3fjqkMHKdgo/S0HWbMJi
	1zNnWU0SsajJtCa7pPnT3hwdZw==
X-Received: by 2002:a17:907:7246:b0:c12:34f3:9a33 with SMTP id
 a640c23a62f3a-c1287355903mr274959266b.54.1782835978806; Tue, 30 Jun 2026
 09:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612165204.86137-1-max.kellermann@ionos.com>
 <20260612165204.86137-4-max.kellermann@ionos.com> <4b9e77c1d8a3bc69a2b91fbba248bbe6939f406f.camel@dubeyko.com>
In-Reply-To: <4b9e77c1d8a3bc69a2b91fbba248bbe6939f406f.camel@dubeyko.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jun 2026 18:12:46 +0200
X-Gm-Features: AVVi8CcpMd7uI34J5CYa9sNPdd7PALEOGvloGIl2lirKg_8HNuGWtYndP1zTknI
Message-ID: <CAKPOu+8JwnbywKYdZNMQN6TqmLPkbvW5LH=GyGnM6nvVM3iZTA@mail.gmail.com>
Subject: Re: [PATCH 03/12] include/ceph/ceph_fs.h: convert `pool_id` to u32
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 6:06=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
> We have tendency of growing capacity of file system volumes. I would
> prefer to increase this value to u64 instead of decreasing to u32.

Which would requires a new incompatible MDS protocol. As long as that
does not exist, it makes no sense to cast the wire-level u32 to s64.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
