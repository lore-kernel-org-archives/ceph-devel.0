Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183533B6D1
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366106; cv=pass; b=BFxB+erXXvqIJ3s//0SJBV/7kTYC3VOWTruuTLfTaAjbQrdISQ5ImzLglhoP/V7lukEXHCnbCIXJU2jSDmHscq/JqqANiBFK0gvK9mlVRPw6HlPuNyfJbcZ7iX+g84la6VmBzSgy0cW2v2DdWRWejl9RPpePM38bPN8uh+Umqgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366106; c=relaxed/simple;
	bh=RFAeKKyJ/X6/FKdKm0f+0wQ3jNhrppINMYikk02ntEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/aYItFEJeUuZUlM7ASwTPBZWzs6B3ks4g+liWefbCgqNXb5VN/44MpbGV3jMa0AXX3uIkVn5E46ODUaQ96siCxGtdBjFzA6Biwf+gEZvgraWxv/E+W/qfdoXeXIcJzjWEUWR/YFpJRjqx8wxmAjl4Fvmjd4e3HMLwqOE39aFBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IOGfNU58; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IOGfNU58"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1fso274617666b.2
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 23:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789366102; cv=none;
        d=google.com; s=arc-20260327;
        b=oCblT3jeaq3ULkSnZdp53hQvvswNoLFAudyoufhxNn9Jwu4Qj4212WaqNiXJLO7tCF
         dsypyqXUorLUe0UyrRGuWz3N8hY80DO7z5O3YtdmidcVlURyWcoiHYj/P9fKrq2udf4Y
         HX74DzahHQB5iLRyHEZpfPXlN5NkoYl6q/6/VIW+uctd5sAZM/0xJ//Kgvo3uckZjRtI
         QmBNIJkZoXKec3vTRp/acaaO01WB8wOTh89SSHIO4roAkqR7PtSiZeR4NXuwsAMCYTLJ
         7HRdBmBp9v1KPC0jpsHE/AUt9P3AE39NNOob5hIhUU100VtOMk7YxZOqeVPUqFKZTJCS
         e0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Srs7a2zbayyn4FAFz/vGB3FP7vaxpRMgPJAgK7V4/U=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=jmk6+jiQEvDWAH3vZGOEaOatQOhFZqpDUQ7zHbNlRyaeJUL486uUvnRPYAJDphDU/h
         LLEK6EtLWYVIREjx5lLzXtWLPvrRU+DUQSUgxQVKoTfShzyYNSWJN718LNZxZQHMxydI
         ROj8MewXWYyGt7QcaGoqBuztUsJXVABE9ilJ6OcOtTqAX3oEkQy6JDqlFiksakMRELN1
         xWh/jLy2oOtrML5ccfJo5ZrGhzJQiCf2ZZCVgQg+oOV7qzypLcUYiyisjRqce146j1rF
         1KIOhT9H8sKg+D93771fuDAEIm669BBoIBJT4x1rRDeVJD+HFFdh8/zSqxinQdNX43o9
         8QjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1789366102; x=1789970902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Srs7a2zbayyn4FAFz/vGB3FP7vaxpRMgPJAgK7V4/U=;
        b=IOGfNU58xwvkkgYhwuxg/Ogmueo1CIQB1vXQZH1l/9DBtfvTe3ng3pVjpb8o2rj9Ic
         zz44upNh1LggfHtYFwW8uyRu5Mqkwiw2e8HlZ0cyvmacaC/H7NFlPf7oS0zJuqlye4Lk
         rX3fOL2AQy0EZ0qnhiPM40g0DUlFBw2PoZmzn2zpB8t909MAq4iCWzEh0O0Fx2r1upEf
         nlqbh9eHwXpZW8HbsHN9mEtYUl/6rGiuatK8zzSZFMNXcdPqp1rvEfhipfIZhrJLROoa
         x/iD4M/pQlI5uJpd2E5LLEH0ceMCxLMcDiC3hg/7LrzEMUGab4NU7aaWe+R4QaS2sdtr
         UZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366102; x=1789970902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Srs7a2zbayyn4FAFz/vGB3FP7vaxpRMgPJAgK7V4/U=;
        b=KEr2LYVhQer9Yo9JpjEzrRofW0IglLPc6OW/TF8ahflgzyKFGO+SWOcSRfIAdx4cAp
         w5ToxaHzDrcJ8+4QtOZ7Sk6bmg3q3FmDH9Tn2ZWnAL/IfgxToe5/YwluK8EsMPeZwWp5
         To8cDPmb9Aiy5tynrwvTEgvnJzehRRAnbwL5YrWXDOWxSxiu3Ge+eK2JGt89U837Ot8v
         pNBarPSQsyGiEE3Nxg/ve81qPsj5GqW2p2XaivFdUBP5BTftTQgd8qf91uxx56PUet2X
         IRQG0Gt5DmZkAcvyTo3lrqTlXI7Mb8fZmI0oRt7CRpKKOFgYQk8wLSa0QmM953qc3kxc
         s6hQ==
X-Gm-Message-State: AFuF++noGFI3+3l5xe8I0SzuUO7Omhf/QxZ8l4/e8cXIXVXg7NcqaH34
	+6A5JmqzNMc9/80/46t2tOMGODSQjTSYq9RoIy5pngns3Pj5X/GE1b3pDN3PLsk3VHBmWuVEimb
	nbyPCpama1l4TSwdRkj691a1tSKny643TsyiHhYsrVw==
X-Gm-Gg: AYBFou3aKzGgLngg0uuSnnykj0c2kQ40jcRQkYYB+bAkA5d4az1uSAodeLPTOU9zy6T
	80775ncDvEUt/ZU4I++5X7K4PLPgegEWyLAl7k7Aa9zeLpVCpV8OpmTi5VEKDcRc9+jpKJENqjT
	ndI3KJZnLS8XUsbt3vUGyESJdV7bki4JISmRWmyKcfwa9XGy6TDklYtZMKAXKgeyLr7m8Zrc41V
	qKqJaGB62mqCf1b1ci42V0DQkV/6Rs6vMCnMj+PZjGcSQrm7TW+Q+0/5iMIWk4HyTFrqSWlNjqK
	qfZswy0nTUxqZ+lC9qyVR8EFSlMZ/c3rfK79d9EwjwgQ0pqmy/Gg7GV1QuE2SGSpphhJPk/glid
	Pcv+XmCmC0MC1p1xz+Gk=
X-Received: by 2002:a17:907:c5c6:b0:c29:29e1:2a07 with SMTP id
 a640c23a62f3a-c29b85fb015mr124320966b.7.1789366102173; Sun, 13 Sep 2026
 23:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911185244.1420485-1-max.kellermann@ionos.com> <20260914053353.132489-1-amarkuze@redhat.com>
In-Reply-To: <20260914053353.132489-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 14 Sep 2026 08:08:10 +0200
X-Gm-Features: AcwNN1VrJLUo9Aqx-WcNWm3hOaRPPk6KzndCaPrdcWdwO7PTABm5eBdemaKhGng
Message-ID: <CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_Lx8i4KgZOL5JnMtQ@mail.gmail.com>
Subject: Re: ceph: acquire write lock only if snap trace has really changed
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:34=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>   1. fs/ceph/snap.c:963: Fast path rejects the global realm, so the write=
 lock is never skipped
>      `get_snap_trace_if_unmodified()` treats a NULL `realm->parent` as
>      "must update".
>      Match `adjust_snap_realm_parent()` and compare `realm->parent_ino`
>      to `ri->parent`.

True, this is a mistake in my patch submission, sorry. My patch is
correct (and is extremely effective - reducing write contention by a
factor of 678), but depends on other patches I submitted long ago
which were never merged. It seems the official Ceph kclient is lagging
behind our Linux kernel fork too much now; ensuring compatiblity is
difficult. It doesn't make sense for me to submit more Ceph patches
until you have caught up. And then a v2 of this patch isn't necessary
- it's correct already.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
