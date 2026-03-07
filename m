Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7573381AE7
	for <ceph-devel@vger.kernel.org>; Sat,  7 Mar 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909795; cv=pass; b=E1Luj+gzRWTS7jFcY9Qyy+VmGlUcswj6Fj16G7WHpXuEoCPzaC/SkH1GQLfXbsFSfnjapjC/PmAxJFOG5P3JCysThA4cXKqZkTTbEEbsiDqh5pu9Cz6nRZx8UgYbWqPoGSNB29ytZxFAhQS6Hv+RrsVBiWBcSPHBVnUfwkTcYn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909795; c=relaxed/simple;
	bh=ipPnoEwRKGay/Kqh3e72TxDAS0WvWm5QHtGzwkgIhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfRkZXV6oS/+Uy8RjTrxUpHNCJZGe43UU6yOBVRZWuZhWl8yzi4IjoCqeEnQqK7Rjrcxwt1rR/R6WjwFp3GIgMOarOyvzlyz+KF0vxI9CpD0AT+pveqgshJxduD6jobE0Lcp8ws+T91GJKoI650NoP9T124pR1Zm9K2Lx4S0qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=UERqbxJK; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="UERqbxJK"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a10d130b37so3339942e87.0
        for <ceph-devel@vger.kernel.org>; Sat, 07 Mar 2026 10:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772909792; cv=none;
        d=google.com; s=arc-20240605;
        b=WkLjCMEtuW2yaHaCJ2GmkNmuGmnZm17eHVI+GXqhiSRYAt1xp4zv3KBTwyKDtpfz+J
         dVxq3lLDjnZp7hGtsrWK+uPuXYVJY7U7hb+kQ/SzEHCUICpYSuPLFP1e6P02czcr4ptK
         Ep8LlThN5LjCd2GGo8bo2o06vFnbw5Qvet77fnl3BzHh/gBQ8R2BGY+zkyFlqQQFE+/e
         X06gB+sRB1Ez6DilHN/ztRYfDMOkpfIyPyuctMYiUa/J1lcJsiP3A4KfBIlWNVFCuRHU
         IBKChaJeOBfFqJngNdBxLN/vbwqb6IbDegDtuiDT5evT337j+/+oM8h+wFsGf0ZmLRDt
         nmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        fh=dX/I9E8J2wh6p0wHzmCEqTIdk2Y8GDwmP3SEhoqYTSQ=;
        b=CaH0oSwoJ42Sc6+o+DsPMmWCObcybZxMK4Za/ARZ3IXGg0w9vJFj6oB29jLlRFi4C1
         FFN/Wc5TTXiykZx1/ajyL4z9D2xmqNyTOcOCIehgbXdVt8IL12CSKLiyG76iVsvAcKTk
         SLw+/KN1UnSGOx95MkFTLi53esef2BexhEmZ2KAEBHhy2mriznAnQ/p7W/e0IcWFDnVz
         yOyJUxqHUoFhDxT8PcoQif7Ikw9HEu09gsg7Dz5gPYYMBzEYfqc5tQaCUs5hBxSuBQd2
         GreNKHprhRJW4eOnHCoftXYcMocI5v9AQq00YYIWeC2GZtZso7csjNwAXDe8v1qMus0h
         POYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772909792; x=1773514592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=UERqbxJKZngkPO2K4yr5YwAFzKHDjj8r0w4oJuzjCO0kMIqLOi33dFigOAK5fZJwBg
         t3vBGotLKf2C2GyPcVqTqi/0bMqWfMRpqQ5rii8Lnt1DIjrG4hklubdBbb0zBjvmrxfm
         0ACUWOD8gJuwgtD1IRPU5MEQjhc5r6adr2y3vMIGiLtTdq4ZL/+TuRATJssUP64XLQ8k
         697wEJo9Gi1YFv8vDxzYYf+i++1UCLQBSHd5HunMVb0RrP2RWyiZRuwnSv/rA/6wMP/v
         6PdybPK88LnePRQ5doBRC2ZH8V1L7CaJDdTOdndxaW4gM9uvjOm57BKxPOmZpQyF5BOo
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909792; x=1773514592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=La2mJc20JkM7GGfC8KvwZtlZhIl/8D1SGNMvg3yQY8bCPGbj+Dr2MAamAxmu21OatH
         Kn3R0D5X4Gw2S0uFmh2J9K2HhmFlQKs7i3KD9K3sCJhJg813i2YbtzxTJmTQ+o2uwP5C
         w2p71B4iEp3YXmK3ywLNilKMxLXPAlPUdxF+ArdWT6LIrf6VToFjUTHTN55VsPs95Qqk
         4hp0A+mGMowLngd2ZCaeoctFNYQqecWm/XSgHh1j1M2m3SXc37xffc7HFh6PC0FubCQx
         KqnEcbWZ4F/ah9vV2CDnzcepr46ssGrKShqG3ZVsRhr5NunYcZ6vPzdTmwoOvAzD44RU
         FZqg==
X-Forwarded-Encrypted: i=1; AJvYcCWVDVjVeqtqYK81Z9Wup5gKoXvCeT74e5vOht6ZeEZPbDWepaQ1VDGEiQ89YzwEuSeYoEB+rjJCKmfT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7p0gF9e9rlRkNO2z7yCAu3idtnnb0ZGJIZkrhfzhh7CyTFG5x
	Jh0s1qxgByOzRHZr9mTzLOkgM73NICp3rDtmfy6j2ZmA6IpUuXfcbGZEs21wiaJjD5maaQ5ZGok
	nsGlXuG3UbjIKkXJqkMw8B5N5eBMKaiu0G/1AsRjX2z8ScS8Pz4I78A==
X-Gm-Gg: ATEYQzy5wv9W3sJNF2WuPeQS1goMzl968NEsifX68uAZJE3qIO3ew2vXD9HhlavSHkg
	BMDMqWGEurRL3KgsZbRVyf6tjNCivfWRt67RjP/VLIbP86oC0vsElROJ5VfCVXTpF68+B+WJTCL
	ZgCAUPGFj6cpPnROiKWlZjqhhvP2r55Rh7MeQ1+BvhsNEw0Mfl6YJHGweP1pC/JTALyr6eYfvIZ
	/qwgQkvUaQhytHGsymFofp+i1n03zRFrVLoogBLMxFP0oaIq6W0YuzTrqmnJOGcx0Uy1c/e+Rbg
	z1V+XX3f
X-Received: by 2002:ac2:5694:0:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a13c93d9e3mr2016793e87.18.1772909791880; Sat, 07 Mar 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com> <20260307140726.70219-2-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Mar 2026 10:56:19 -0800
X-Gm-Features: AaiRm51B7g_JMhlZIdflpWCsx5DmxAmpibsspywnWIGz_sEa1ctulidKDYlHz5s
Message-ID: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>

I think this needs a lot more clarification as to what "regular"
means.  If it's literally

> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.

I think this needs more clarification as to what "regular" means,
since S_IFREG may not be sufficient.  The UAPI group page says:

Use-Case: this would be very useful to write secure programs that want
to avoid being tricked into opening device nodes with special
semantics while thinking they operate on regular files. This is
particularly relevant as many device nodes (or even FIFOs) come with
blocking I/O (or even blocking open()!) by default, which is not
expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Cons=
ider
implementation of a naive web browser which is pointed to
file://dev/zero, not expecting an endless amount of data to read.

What about procfs?  What about sysfs?  What about /proc/self/fd/17
where that fd is a memfd?  What about files backed by non-"fast" disk
I/O like something on a flaky USB stick or a network mount or FUSE?

Are we concerned about blocking open?  (open blocks as a matter of
course.)  Are we concerned about open having strange side effects?
Are we concerned about write having strange side effects?  Are we
concerned about cases where opening the file as root results in
elevated privilege beyond merely gaining the ability to write to that
specific path on an ordinary filesystem?

--Andy
