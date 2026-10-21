Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583406;
	b=GRlw2qB2lDuKefOfZMsYEAgq13wZJgr7lDD84pbk03Z4kK2g6ZtKqXI9LQhD8AIRopHO
	 +FwOunuG2thjFDjwZH8Ut4e+2KeHx901eUU2+dn4TvfFUpzX6FGPXGZDUfaKL6Aqzkjkp
	 tygUicwPM7uham4oooN9buc8lhDhWoiy9W6pvfnIwwDohfRi2jaZsMQO5gH2ctC7w04L9
	 ftuI8vOWdfL+ZhFx0POwJ744pT6hGfJYph6mgmJGyRvJSX39F1AZgyErapgYuwEtgJ+eK
	 wD3SbS2RaoMTzbxxcCE6HBcXSAll1i5RGjLnC+onSlJInRc4a57O2C7yLqOpiTusHrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Cp/79PwyfE5T4Tg8H2grwuVOCFMA6czvzFC0rPchCKQ=;
	b=WrVDKy3U0132sb44xv1zro+TzJs4EWt0pNuphg00+M7Nr5A7KidYPXp4PKYEFffQ7ifH
	 6ZDlSEb5sa08gljk5btw9nUlvmhw9S70hzxTMQbG1jZR7aErce0hkybkFJreGk3p/Yk40
	 LhSpiU0AfgAoKM0UGhnkNb6cfHQorKHKffPDgCxeDsobEwerCP0YuY/J9exakUDsadhrb
	 NoPBVAIdDgEi5NQBAzxvBf6+397YtNAf2p0HzNyHGsNCGo56MpHxa53PAbBYOwTANYNNC
	 UlSv0iAlLGy2iI6xEPT2501gcCfWiTzTI+qp+rv73Y+ph9DIs9Ubof8YJB12nJJ4lkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=FFdPnAGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF407606A319
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 11:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF407606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=FFdPnAGz
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so346670a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 04:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792583399; cv=none;
        d=google.com; s=arc-20260327;
        b=sJRjPdCP3sdnb8G4ELeWIUe1Sh+/8Lv6jzC3JPRPF53woRAGSEmR6CQMV5aDAHkrbS
         7c/A79aJccQB+dRe7AoytypbPVojzUodDw6SJCPG1WjElfOWo2xSh3/rFRr0VdFwVxcz
         mxaYGB8Oi9NzsZrkhHtUgmDBna2HBwS9AUOde1E4ZcOu0koRCGn9Zj6F9L5Skw7pqbHm
         /I4w2ftceaEP/5yN2UswEPHlBQY7aigAf/wqF4/5dVjr3la5H3DKoPxeNz2b4ppLdZOB
         4EnRM5sRd5s20WzmhtulIkakEutbEB0Ai1oJ+L61rbICC4X+khlN/LQbHYpMtUKHhsQj
         wX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cp/79PwyfE5T4Tg8H2grwuVOCFMA6czvzFC0rPchCKQ=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=a8Or4ZnuMB5884QAXqGSBme1c7BQero1eZ0jkSTkxutt9yMWowlb8pfwopG0o6xhnv
         GdQJdpgMPglhaHb+qHc3b7avih2SWFGRBauVQzPo3GG/nUIQL2cUJbAGqY1cpPwkWmqm
         PugjHsJT5B8b6lxBsZN08hi0Af54q0obIx+qVwmLqvU7WQ8PADUtSXU2BO6Wz6/ft/xq
         2ER24Bu8hvMswi122kLT7asWNZhQhxtpyKS62Apy3h4CMRoEmEjn82c2ze28khjlw0yr
         j2/NgM+OzP76BWwNOeHP7YgmY2ixU9lHZKxj/9jBKQj34EiAFJfgv1dZnBGv51EucAy3
         ty0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792583399; x=1793188199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cp/79PwyfE5T4Tg8H2grwuVOCFMA6czvzFC0rPchCKQ=;
        b=FFdPnAGzDQVAlyHxVLTXYFe7m2p00njjA4/1IRTIl342rtecl0EQLDWiJibVXyM0p9
         /CZFhrmoKemJhOJX095ocXbnt50rrz2SlLIEC2bdBGYB5ihQVIQBM+toxv6k372MGnBf
         8RxGXFopJNX6C1FRIT0yhKqFym4C/lCv+IsJR7cpTEoeZzDIwUfE8obYCgIAhP37pWNd
         zLjWxYMtPalT8BWmLJtWuCCBz5zyYfC/APG2qyszYTIJKBW2lS/b/j1RyozdvqZ+hPPV
         B7hW/7Zgp5ZqNQ4XZO4iFeabYoe0R0u2RMINfUFTxuLBXjs26jYqozniWG7Oomp+nARi
         63hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792583399; x=1793188199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cp/79PwyfE5T4Tg8H2grwuVOCFMA6czvzFC0rPchCKQ=;
        b=AjNsaiaXhsOGNo1rzX5R67WCdVhsXUaGPJeloY92xp1UA+Zq9ve6fwYukJNZacd6T1
         tb00O8AiapbbHqT8Hrk5daNXraSi6L97qCVptXxCqOPAYdvcKTS53h6mhQpPR0yARLUP
         ZGKUsBBzU7OxXQV99vWc/7kIWnYAe7sjitlI979MiPiok4NHiUdy1RTKdkPTU5pbPIvu
         JNjqptSLJK8QG8wiwGvwoBVKiZiA+gom8oFfrj+WQ4u6wwjdy2XXGy62DStM872GxIm4
         dcdFP9cQ6bH9cCQw2dZgLZLpD/TshhEmSi5d//ZMNHXnxLpvCbJ3Gdepe4CjJakWX2Si
         MO0g==
X-Gm-Message-State: AFq9FYKQfSgYS4N7uLB02p5Q0Lzkv6rYXE+rcUyjKftWO2mrz5lef1uK
	7++4RJynYle+vFQ1mG/+t7R7yqC8/kK9TnW1SS0UNhWM9rwevTZBNw+F7r6eo4QbpmBr4ZHIuZQ
	NbrtKFelnF/yLxaFdKo59wjrwNVOuMbE0HQFICMDeWxqTHgs3uEhqbWxMHQ==
X-Gm-Gg: AYBFou3h8T0seiGL2cvm03WRZCgnlRmam0I1t2FkhagdufuDwL6HjdbConAhn1ZnXHU
	3TYmMkxWPbXMT+DhfLuFW0zEZ57sgEO7VdcWBfaBkPJU1Y/P4n1rJ5tGEBl87umO0eUdx6vU5Uu
	eQodl5qWcROe1sMjzvbPZq3sNubiq4+BPNcqH6nYZ7shRZAxqVHKuj9CBLG7Dy9EsyKbrS6pw7x
	Ps1yy+Qdyjg2co0GNgO0MN3LnKOMoizMRmUKF6ZAo2f9AO2So9WKCSoZS9wB7T1K/cy6P/aYFNI
	OYUe4JJ5yBYxF98B9tJMwixXOckmUyaiULlDIwEh1qg+luC4taUbt5no300WBE7p5sZul8KwhQn
	/dkSZp3gs9GIdTNeL3Q2X9i8WNofSfJ78nxkOChY=
X-Received: by 2002:a17:907:c22:b0:c2e:893:7010 with SMTP id
 a640c23a62f3a-c467976d92amr143494366b.37.1792583398660; Wed, 21 Oct 2026
 04:49:58 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-b4-wip-ceph-lazyio-fix-v1-3-f4cc62459d37@clyso.com> <20261020105904.1326043-1-amarkuze@redhat.com>
In-Reply-To: <20261020105904.1326043-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 21 Oct 2026 13:49:47 +0200
X-Gm-Features: AclHuK91ECfjTCxrCzRIPpOEF7OQCtpI7knrCD_1nTEa9S8mXnV2mbkwsS0WYbY
Message-ID: <CAOJNxRLbN2BZXQf10y62jB5fa60762khjuLwe4+UgwNBM8E4FQ@mail.gmail.com>
Subject: Re: [3/5] ceph: write back only the dirty bytes of a lazy I/O write
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Right, thanks.  The same fallback was also in
ceph_check_folio_before_write() and write_folio_nounlock() (range
beyond EOF).  Instead, I will drop the dirty state in all three places,
via a helper that detaches the snapc, puts the wrbuffer ref and also
decrements mdsc->dirty_folios.

Thanks,
Xiubo

On Tue, 20 Oct 2026 at 12:59, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK. Please respin.
>
>   1. fs/ceph/addr.c:302: Truncate past a lazy dirty range writes the stale prefix
>      Xiubo, a lazy write that dirtied only the tail of a folio must not
>      send the bytes in front of it.
>      If the clipped range is empty, drop dirty (detach snapc, put the
>      wrbuffer ref).
>
> --
> Alex Markuze
>
