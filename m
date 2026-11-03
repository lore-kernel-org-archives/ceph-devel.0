Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793689587;
	b=OlDNWLgRLIO/dSAMLgBPbtem7FNolpD+drjhtZAyIowbDDNPNlakMhQbK11EHSoVWSXg
	 PrYfdAQDv+Lr3NurRM8eG6PtBDc6Vhm5VZ50dyzzJLSmXb3Q3N6kvBRwa8I4ppzKJCUat
	 piMSMyYTT7D4wS+3QxMNW3cosazE0EsxMC9IEAPs6//abzTDigtjZq68mvSmyEc04+G0h
	 qY1P31aKYUsw9RqmehMz/0ITO65uq2W3XvAki7omEKUC5FoJKT0g30akCsJ4Q0m02g9tF
	 udBzdaXWxMW0fgCvijiNszBJXdk0vwk3Dsb9S2F3MXPJZ9vJvMzsdRH6PAm0VV+RSjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OldbtTu8SRDvvfag5jP+7J6kAcMehcX+OnBY5+x8nzg=;
	b=wdFt1DNsIq6UJmXxk9WgkC9jHue3qu6j5w5m8esm8lVEE51GsmEX+Y4KRQ9CC07b/XNj
	 DAogBBQYMkcwRzPHpEj+uTsStDMMItCZyqGUE8W59pKzMXFLQ2OIiFgmimBSIWoRfcWfJ
	 lUtPvtz8BfsI5qyC4vLMPWjFdvTFMwt491Q8NEig95WKqtk65gq9vTQk1+f0huKZDq4Ow
	 yzGBUDGITo/V0Xz8ahSYQd4sGztRG/wt0yqTXlnvNbVHl8AOfAghiyIICxCuNR2X1moeF
	 AHefSWgJhsjQ+uRv2USp2MDJt3ZQ1T1psPvrocFKv5Ot4LEgTcbGavQHQATWc+f8DxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=FdIjHudX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B6606A32F
	for <ceph-devel@vger.kernel.org>; Tue,  3 Nov 2026 07:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5B6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=FdIjHudX
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c411e139259so337335466b.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 23:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793689585; cv=none;
        d=google.com; s=arc-20260327;
        b=GTfAaUZxGjHrtBPoM5nVh2rpWm58TnD2LfF6Bbitflcs1yioue0Jq9jlxgM4Sc0qBr
         AqqS/gt3egQTidHwowaedX/KT3CrsAjJ4yG3gSBbpg4zOYW+ue715CkUlSoKID/Oubzj
         VwUshCaYnW5K/DVpPHko6yui+Eyg2EeqmYSV9Ir+fXQEyR7fzyKxWUemcSpYH7NuwnJs
         VF+bU2spPxmThPuNu5Z0xBB59/uMIDvBrd/oBX70pzOwwzmwqLHxdKCSDgI+cRnCRA7r
         G8uMlSy0ff9aksom5JZIwiq1nqd6VKX6wlRivtNREuOoAcuKPrBuwsNaok38cPOQFcj2
         oA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OldbtTu8SRDvvfag5jP+7J6kAcMehcX+OnBY5+x8nzg=;
        fh=EqRa8YoRIqQ/n6s6vy4U2Yeyu61gYsnL5nWgQVaf1No=;
        b=BqJJRVZF4dw4E+QTumXPF8ACNHr3pyWBbR0vDmbjPiFuNGkc2mK9C0gqcY0e2TvSTF
         VLguCvGLl/Yk945LHN1TBx+abCoeqmKvMkZOovmJ+Tb1B8+AguEtb2eiPRsZIPMlK+mH
         vYtJpVQ4kVUttHyXIIqrh922Q63Ab5ESO6fFt8ABEz5ZjbbEg8uBCthgmzeYES8lMny/
         7JGjsM/rDxSzfqsgLrTpn+Vxc2HxqlwNxvJg9R3jnp7lOt0Y3R6JQXisLtwoVPgSAoQU
         RlLsB0Ha/o2CAj2vfgt+D3fuXyrbS7kl8pPhZvrqea8s2u2pFsyDliIzNKXuO+jB/kEK
         9rKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793689585; x=1794294385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OldbtTu8SRDvvfag5jP+7J6kAcMehcX+OnBY5+x8nzg=;
        b=FdIjHudX6MxqbBj+cVmyFTnWIcwpTaNo+lwV2XKjTKXc9O8YyLFtJ6n/uQNjHiD+ne
         HzdKzaa9N6V+VS9M2u1SjHpSKozq38Jc9c9/+bBSDbeeq6TscsRW9RNuxskxZTT7qhMP
         p7AHXRbJkGEd6ZvvMYFWNtnqJm1K/OAKDlWbs2GkHYV4S8tyUBIkBqeMGFKVmujCxVjR
         GUU7DB6CO+zt2Ej1IIJ/McvdLgIPG3kqLan2w+++68UgrsfBSSh+LVSVnOQZH8tjDVLP
         5Wtw7shCie2a5VjrbaIflrOX7fINXYVgaNa+dzBDQhT/32QhNGFc0P3nyFaQCRHwAuaL
         RCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793689585; x=1794294385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OldbtTu8SRDvvfag5jP+7J6kAcMehcX+OnBY5+x8nzg=;
        b=b5u6B84oqPNTXgSaUZYYGTp0Ch3neLTe/MMSqyh0oclhf9Z/KUzb6wSAoX++V7hTpi
         GM3WCkJzlBkv4PuVKaBW6rgJHbx8/odQZwLU4wyXafsMnwBkLHYfn9S2S75wDvtM0p/R
         /sS0d4DXCPhj3RgEmIwYaffsh6S27OGjHjc+vYldspKPaXk/D3RSScoBeJfRop9UGA10
         8zQ+e2D4qq+loAi+5bmZ1rhbgj6449X5KOvqjE1X8Y9aMgfj6PG2WiDX5R7cDldCjeSJ
         4d/3UDYSzBScP5wsadkKLFeH+RIeQRwrtxo8KiEUW2WpxD0J/DKfBdPm9psU5X54JCYi
         1EfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYR0WSozYoYTrMH+um4dSGgU4hKy6aTCAjqQ6aErhdwdhCNI895VDPO6uf8GFGBRUILg9L3h3Uk+gD@vger.kernel.org
X-Gm-Message-State: APuU4Z+OvEh06uGxVbBnlVETX9gC0Vtn1QhyqydawBE1K8YSdjl80XpL
	oHcFBGy6F/QNfuNdxV+XIIxoHFrTSVKpfrHHLEThg5XwQ4XIZQMK3thLPF2rmJwpc8wxh7JIS81
	nMFtZbaArKXZSj40pFWSAyRkyfLnly4fgtSQOI+Fymw5bwI2gyB8zEss=
X-Gm-Gg: AYBFou2KZ2qapg4D6P8qKcGfZhJZYUn1QFYke40zK/M4gGWlsaEda9s7+hIoHKVcBeT
	MrLnD+kCDqcQbmfuFzvE5UFyl/J+DSzlJZC4LTbgoYMVcTBRm+oXsJbAyWGP5XiRdBDsCForS+k
	S3bDm8gYOWyzTnWQ6h3hN8+RmW0evYD64icslMl35dHYD6Qg3VpRn7crB93Hzm9jiy5obHylHHJ
	fOf7dTs8Jmn3v6eKxYVlk5MwsSW8HEmQ4klHBK552JR92oCxNZiupL6XKTY5Q1xlMcPu9J0jdbA
	N53dAMsrtVkkH5R/hl98CJ/eZZKguWkPJCxaToSsIIiOF/GN1gtgMgZluPdoTeqIGVpey92eWPx
	5j8XyVCsbUVX1ca5Um5XlMAcPB663soqhDoAUqlsyQZXQOGTcbdLsdwhTGLULAGna8zA=
X-Received: by 2002:a17:907:daa:b0:c42:102f:15d3 with SMTP id
 a640c23a62f3a-c4ca7b45a46mr990474666b.34.1793689585134; Mon, 02 Nov 2026
 23:06:25 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910123951.1241279-1-max.kellermann@ionos.com> <CAOi1vP9mrDMaABV=KtLRwrGVkBrPrGGBU8mUUnfm6wpdn_rM7Q@mail.gmail.com>
In-Reply-To: <CAOi1vP9mrDMaABV=KtLRwrGVkBrPrGGBU8mUUnfm6wpdn_rM7Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Nov 2026 08:06:14 +0100
X-Gm-Features: AclHuK-x6djlZGI_sS2fECMKb-dIFjw_YiOQ82Ze7VryW84eodaM5B7131El-Hs
Message-ID: <CAKPOu+82TXE2PqXSmSa2hPdj1X-AtP3BVACsBEhn=EKuOdjSRg@mail.gmail.com>
Subject: Re: [PATCH] net/ceph/messenger: print TCP connect error
To: Ilya Dryomov <idryomov@gmail.com>
Cc: amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:08=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> I wonder if saving the error that way is actually needed.  Can
> con_fault() just reap it with sock_error() at the time it runs?

Maybe that would be possible.  I wasn't sure if sk_err (from
ceph_sock_state_change()) would remain untouched until con_fault() was
eventually called, or if it somebody would clear it in the meantime.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
