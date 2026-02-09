Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EB36C0B1
	for <ceph-devel@vger.kernel.org>; Mon,  9 Feb 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635053; cv=pass; b=TZ9Y/TrdLkivOcwCE42e5zeIU8qQrlqCpU+dzpCQ4FI0xTUT6HBzM3nowHlYm9PzJnVQ9KhbkiMIsWAf7qBl8KtISDoGdEQkCgqhcHaX0h2ca/2VgZmxts6Yl39oaIusAbV/BYovfYyOLnRSvRG3nF+bAM2vJVWrOq42RAjULeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635053; c=relaxed/simple;
	bh=JAiWmBCCEPyc0JQWScBFRX3hfPSMgstOHCCBiGGXHY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2kdGqdviddQb8H3H0xVpA6mg45NpO7q8CA7DIvOmZT2Wr1RzERfVYPYrIFONMGtXqvWCqeH5tUa5x+QDJW3+THMRskJUs/XiD3xp4tYsJixi9a478GlyIhr04gDAftN5vaYoY2HQv9hqaGhRReHGdLN1CNArTxsi/IbwCydylg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExYNB0eG; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExYNB0eG"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233bc1117fso2912375c88.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2026 03:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770635053; cv=none;
        d=google.com; s=arc-20240605;
        b=HPxiwldRsOQ4W6qxaBEaGf2kjUQpO00EUOlV5IpMf9clL6ZRDpoSuVUj1TAaJLUuJs
         bxE7ULrg2+BQxFQcwOuRbKvvdm/ObI9FFAZ97CLVVVFBPjSqPJc140r29RHHsjaisab2
         ObTCpVvEBRvCxTZk/cRjc9rZmiXSA6fXs3pUXDFuYhEKD0Y3sEPf2jsrKMcwkZzxMkdO
         KHtxuwwkOyNmnUFvR9wKX65i3sBec66gVAQemjNRBEw/yiB4LkJZRbFR6+5QssHD4Mxh
         PZoLxc71mLhQ+yq0+vFGKFetF0hcMwiZzi41kfRnPmBHkqcVNaJhPZhDjRpwGHYOY6Sz
         LVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        fh=7GC8CDPuGbHOmxkycWwGmiuckTqMq0LOmx/h/Vt/t74=;
        b=H6xcW/EyBXOcvtijVz8zd5To9buVvkTuZbVf5M9IWiY6x7pQxIHHjPgTStfTCc+qlm
         GVNI4cRaHRk2CzLlVHvKsAPI3BxtsJMqaaRoNeATMU7+vC2ERIxq3h5JGDUPIlmdgqPm
         B5jzd5eIauMs4hCMg93txmrMfJ6JXb91DalhUm2ccx4lO3WIQggAhTj5qY7yIdTxxrjo
         9Q8q+VustUEHh/2yz0wTUQEZUmG7fD3f8wNrEDKaVfgKQWXM+KeVwQsOSVbFp72Pw6ic
         MIZxl4eQZo8K4rj0T9L7+Ulb490AoiekGUC0cs1PURFmpN+evAecKFSGZvSfnibXJorO
         8fwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770635053; x=1771239853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        b=ExYNB0eG+QN79g8F+6XU9c8zjmh/+VMl2m2GxmSCo8nX0ZT0ShKh7guEgkQwospT/B
         Mvl0ux1XD8hO47GvWnZkoqdgErPcH0D78Ddb1blWHmHyp5eE+SRNPWPBvXUWOboCTbY+
         HT3CLRKhl/c7SJoGZkn6s5caCO3KLEBbtii5xUrd3UbaVsqT7C82EvX23brchTMnAHv4
         Ksp6+EmUJyXi2NJdNcclLaSZxwnsMc4NatIY+LT3axn/PTlWR9msKLGporscx8scT+hi
         M7LaFen7KiagQEY5JnP8uZBZShf/sY05SdWAuwk7wgPb73Xs021YNQAd7AsCg5zoMWkw
         hacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635053; x=1771239853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        b=OW7SknhJNuWSVbDvpEny02rZDAJ/zEM7y29pGWxMgrS+PyTOWKolUuqGGL4PgBgI/u
         EOG/25Y8JNTsNlAnBgjUr6jMmu3wSnt4Q6ll4gdeJpvZ0gHUfr8ZiVikOOtN2C/15ccU
         GGEHfpIiG7zuSMbUXk+23HFlqInin8qmW8PMZrgkuSubR7zeLUgTer+I8yK2WHKyWRPn
         HqXzZ1k6Q866zG9hyBSWe86m0++bJTpx2pwo+t4UbzrX6WTTaRSRXzvjtqWIasUb09G/
         TmkHQvNObgp2XzOeN2+Mve4JL5TmTl/oLaBt4SCLLxHbpXv/qWlOSn+Jch/R+NYpNh9w
         Mclg==
X-Forwarded-Encrypted: i=1; AJvYcCX00v5P6r2v47HyFSDMP1TzbzhEQxVsiIH6CRQQAFS9F/F/EjzsxtGV0NWUmN8zcOQYD7w5whOrBeRQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2g/A2FNERnlLbNifuvVJNdTOel25UyNiI2Kq8iI+ZRN+w5HNF
	qMlprxwMt1I5Niusz3eF9cGGUMrq9EZZX+NT6TWB5WTj1viMQhymK8sdSNeaykKTo7sODm+a+cg
	ccH6vkuIgfaqJ/zRu61SVYo3iNbFDEbU=
X-Gm-Gg: AZuq6aJSE+d+lc+jKP2bMT9EE3P8WC4WhZIZGA2QFRjg9Q2qk8Mv+GihkdcnBkaFA09
	7F5ngiZGKoFlBgUKM1m8ZpvPWUHHiyl+ILDNhJy3OjCRLW+eFlUPDFHzFfcNMs46fdhr9v6ompu
	5ngOnp9TZZkiZX8pumZVC9J6JxsahzKkyI0OvoB6k7bysAq+UXsvCWIOxg9ItHr9BcgGH4TARwY
	tcsvACho1sc7qA+1rfWvp29facMGwBJU8luhO81wTLmRTmxfvWa6iqHaoVbslk6QnuOlZQ=
X-Received: by 2002:a05:7022:698c:b0:11e:3e9:3e92 with SMTP id
 a92af1059eb24-126fc1e223fmr5913050c88.23.1770635052461; Mon, 09 Feb 2026
 03:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208164033.457748-2-ionut.nechita@windriver.com>
In-Reply-To: <20260208164033.457748-2-ionut.nechita@windriver.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Feb 2026 12:03:59 +0100
X-Gm-Features: AZwV_QiAcQaOSunqwtuX5L0vA3ln57D5IMRDmzftHTXJqxKWMgoOcoFu5ti24uA
Message-ID: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ionut Nechita <ionut_n2001@yahoo.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@newdream.net>, superm1@kernel.org, 
	jkosina@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 5:42=E2=80=AFPM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> From: Ionut Nechita <ionut.nechita@windriver.com>
>
> When connecting to Ceph monitors/OSDs, kernel_connect() may return
> -EADDRNOTAVAIL if the source address is temporarily unavailable.
> This commonly occurs during:
> - IPv6 Duplicate Address Detection (DAD), which takes 1-2 seconds
> - IPv4/IPv6 interface state changes (link up/down events)
> - Address removal or reconfiguration on the interface
> - Network namespace transitions in containerized environments
> - CNI reconfigurations in Kubernetes
>
> Currently, libceph treats EADDRNOTAVAIL like any other connection error
> and enters exponential backoff
> (250ms, 500ms, 1s, 2s, 4s, ...), causing delays of 15+ seconds
> before successful reconnection even after the address becomes
> available.
>
> This is particularly problematic in Kubernetes environments running Ceph
> on real-time kernels, where:
> - Storage pods undergo frequent rolling updates
> - Network policies and CNI configurations change dynamically
> - Low I/O latency is critical for RT workloads
> - sync() calls can block for 120+ seconds waiting for reconnection
>
> This patch improves the situation by:
> 1. Detecting EADDRNOTAVAIL on both IPv4 and IPv6 connections
> 2. Using a shorter retry interval (100ms) instead of exponential backoff
> 3. Logging a more informative rate-limited warning message
> 4. Supporting both msgr1 and msgr2 protocol versions
> 5. Clearing the flag on successful connection and when reopening
>
> The fast retry approach is appropriate because:
> - EADDRNOTAVAIL is typically transient (address becomes valid in 1-2s)

Hi Ionut,

I'm missing how an error that is typically transient and goes away in
1-2s can cause a delay of 15+ seconds against a 250ms, 500ms, 1s, 2s,
4s, 8s, 15s backoff loop.  If the address becomes valid in 1-2s, I'd
expect the third or the forth attempt to succeed, with a total wait of
1.75s or 3.75s.  Can you please elaborate?

> - Each retry attempt is inexpensive (kernel_connect fails immediately)
> - Quick recovery is critical for maintaining storage availability
> - The connection succeeds as soon as the address becomes valid
>
> Real-world impact: In production logs showing 'task sync blocked for
> more than 122 seconds' with error -99 (EADDRNOTAVAIL), this patch
> reduces reconnection time from 120+ seconds to 2-3 seconds.

How many attempts do you see per session (i.e. to a particular monitor
OSD or MDS) and in total for the event (e.g. rolling upgrade) before and
after this patch?  Perhaps the effect gets multiplied in an unexpected
way or the backoff mechanism isn't working as expected in general.

Thanks,

                Ilya
