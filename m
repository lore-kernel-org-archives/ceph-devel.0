Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AA3A6EED
	for <ceph-devel@vger.kernel.org>; Sat,  8 Aug 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170667; cv=pass; b=UuPGvnW6BCnwxwQplrvhOesjzZt74FZdHVZ5+Uxv+DBBhuj1U3WNafYVuXvFKD+XM05y5Khv1ls2RLtrcwimoJu+R66/9ojQJy4VRKTtuxNmZp3kilaqevtpVoRIkJYwJCsVNDq++pLV7SAjtXmga6hhBEsEi9JGdbkCsWjKqgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170667; c=relaxed/simple;
	bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi9H0ANYAhxZAd1euQALK8QqBAPRGIeth1CxRPCIhikrQoTN4QHfn1M1K8Dw+9uGGFTjVt4tTImQWobXyZYNpxsqIbD/D7MltuozoeC0U+nOtOFz2dreG9OiAsBhyY2Bv3wYFS2nMmXuJm3cyp2bNkQHA7Y911awfokoUfWlVPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bgIrqiLO; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bgIrqiLO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c207cb16cf5so32240066b.1
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2026 23:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786170663; cv=none;
        d=google.com; s=arc-20260327;
        b=suLQ5FlJSyv/BPEhUu7u21HyyQvvMSxL1IL4FlUbi+kiAWJlmXzMQebrmG2q/APOeq
         Dab+S6gwg5o5iJqqysBDjlBMii72CDVX8rmzKpZCAufFFBDoLdW+vxbb6WKPgADkcQlJ
         VesMYOad6UDOGnwqyAJOgxZPFmhQcWrQasvNCdrcBN+PtkgOn6eo7ewSQxkTCLoRIyyt
         h923s1BjEzkrwcQuKGkzVuMUR6dHsy4yaIoS5eK18kHdbLXFlL1qSIviDATMnywJfMmK
         i8fCk1xMh9hvMe5bcp5qGcBDnhuGXevLRXFVgu71DABFkrIh4iU61T0zByHhtXc7z0k+
         oC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        fh=7fFFnSxN1gsA+7RTI73oQlkaSzfcEjUMchuoUouFWpQ=;
        b=pIaka+DNFtPArucnUrrEgLJPoIwf6o6WMEBAfTp2dybRyIofyp40dpg4NMZGbe+169
         nDFSiZtj+Inu2IY/Oc1nPG/xpgynnanWAxt6ww/Z6wK/SiiTiTgt+fa5P0z6CHxRmdZ6
         TAoXnupj44dxOj/lP0pN+01Mb0HFab/OWabdXovgnNMNibMQje1iMlsVeuDAC3I+msYv
         p3g2KvpctIuX36nBcXAKzKY2zPG20srjGuQVdngJBfrtVrUXDsc1brXoSPHUOwAf1Weh
         S+l370vEDlye4IEePd28MoUUAtxFbqy7eqx/qlZcnfSFV2zT8gukbGvjGUBmz1bB72Mn
         318g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786170663; x=1786775463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        b=bgIrqiLOYkmS9SVkbMnk/Ymlu2fyJtLtmI7FcXNEfJ3ZIqcsdFDb1sdktYCPcUhN6u
         txn93Y7CfRrUI409k4QQgHz+4BycVQ000GrIvl0RJbhHw2umDX0o/sCwuFbizpPxsrnR
         m06Gxm9Pl866PS6wmIR4dmXFweHlqeGacs+FHlQofkNZRYp2q08HceCf1+dy2kfDWRa3
         cBvRIZEMLEVE12U5PM8flnE5mw+Vys5SAUtYN/jdCBg2VRntNZfnOBJuVAy2UN1KoABu
         z4YLs2WQEm8wX7BOd/SeV52rOgyvWgyo1L3/BLnCdgCALFsWBW9pvzq5h4YrYLz3NZe6
         ZftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170663; x=1786775463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        b=NonU4VOZPPYaI+0v2apWmPqG695f+iXs4V0WJFTcwJ/aBBg71jWkOkgz3+D7Ts0jls
         iUkDF+JzS/KXmsKMzpsITDG1F53e1Lxyfrgvzmr6yfRLyBM3xcryM3r1GrHPq/CsBKto
         bAlQ6a5okkcPmI3FykuCF3vYe4RiZlGGzL+S9ASrvmXZGoHFUGGEYM0AqNH76tNjCTKq
         ugZWPe99u0btHPuoWuRFh4uki0lHORSEuQ4989jjRXggKQhOj223FzQjdtiVgmWhMGzt
         sgeKiBJHdYV31CSujjJ/jl4j8i0z5yAI6iGxhLOdVsXRpQiYrelEZgN2wwo0J/+LsL0A
         gg6A==
X-Forwarded-Encrypted: i=1; AHgh+RpY38NHk5K33Hlkt4zx9u3l29vd/+v71nwPuj5c+sVsHCKfeLIkhBARmKycwvzY6UPs5IeWKbQ/Vv24@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/cTh3/b7SCp7KlgXg3Z+ugFNsmW+zKNCMVUvYn2G7MxzJrHj
	BXHdU1Qcm9fKwYLwdnr1so6UmrVUv6sxuY8l11CZI5StvL3DohjyWSzNT7OMl5W9Hqsy0eNDpGD
	PknE4OUNdaJ+2eeNMA77zpa5cjkCdxqidzMdBOU91mw==
X-Gm-Gg: AR+sD12ilFbHxRKr1wFKx/dspJJtzSxqBSi70xT6cslNhmIzJS3Vu3FZi8zPpQNRGFI
	gCzHpHXwbTyggsg4hZAHhXk5bmri5loKvECQMBqYH6SttgTk/qiNiPOXFxqnByS1yOOeF27vsP0
	07osbkrenJSccfKZ22omh73CZLko2Mq0coWjqKors5ljdTXajY8wUsq3PGPOqopHO9+t2o/febj
	AexiySvPKBUhJCj+Gm1+6Frk3JA8BSaMpkGnsHdYSL/9JA2eNemqckX6t/NbMsmf4JUXKf7IoZH
	1k0wE1/4oTcdfwh6b/66F6MI1r4pjanQxaKNR6xQlsW9cOgwHmgLf3EqFp3CcE0B+MY5e5hfpSX
	ki9iTcqcO
X-Received: by 2002:a17:906:ef06:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c2039eef51emr1278998866b.16.1786170663333; Fri, 07 Aug 2026
 23:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com> <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
In-Reply-To: <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 8 Aug 2026 08:30:52 +0200
X-Gm-Features: AUfX_myUHVU95ES5DR6AjP3dNKMdpCPqSEnOWDnoONHwwIDT1_sT3WiV6rWakkw
Message-ID: <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Was there any specific reason you used nop_mnt_idmap for these checks?

No, I copied that check from another filesystem, probably ext2. I had
no idea what this parameter means (and I have never used idmappings).
I guess the amended parameter in this patch is correct.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
