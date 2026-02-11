Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07993093CB;
	Wed, 11 Feb 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794518; cv=none; b=IvY4iN5C8PJzuNjOEGe/p6TnfVIKunjL6s8enOpwGbetO8t77N1q7udc0Yw7kraVpFqvweABDbkZ0UKxIHp0wzRAa+ieOnO/xBxVraRUSEJFNG4/WL4bYu3p43jmdJwxKIIr/2y93KynqTN3gphV3D5RZfAk8StJc6GbAmr/AVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794518; c=relaxed/simple;
	bh=ERqgR5AM72YGSazcK3+FK7QahMN88pr1gOO+I6p4Y4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPiTRqHM6J0Z67xpckCGce2sxnf5wRaxYOdjN4UmQFCZG9wGBnPaLNI44rG7pTTgfBJr/I2+/ie2E7rW2tFnRYFJC3RofB7m8Qq0kgPOpz9o8ou3jvLQ02RbCeSVD1Ar3T9KxLIGlhVZSO6vjDv+qH8pmQxBrwfMnJrRwqxipqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HB+6D3RG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLZ4aPvy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HB+6D3RG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLZ4aPvy"
Date: Wed, 11 Feb 2026 08:21:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770794514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Ai2YZH9/yhmkTt2rOPJ1vI3sgB2BVPXr60OH2LiRg=;
	b=HB+6D3RGBLG13omUkJdbgEVxdOZnvFp9jKD1pRgsRlL1WQ38J7zkvlDY3KRKxDMB4e7RBN
	HLNoihjrqVXO9go+SJazbdjybcI4FuB7HscwBQ9ORELJBUFWJVU8PV9sctU9wxRTvHIE/Q
	/1FaK5EJCfD+EjpYLUO7yU8FqJ6pk/dsQ3Z8Aba6o1oBLEvPTlYsanAiWq+XQYgBFkkZKd
	WX7EnPnE1pPwbxCB8UvaMmElcnQ4jogzLH4BmCkiYTR4AUrOk2AVfqDWT3FgI1b0Mpnm8i
	3zITN3s0a9TuiNyVQMJwNU6H0Cjz7BM2V3Opyn+jjurdHgH32+2o42fbkRgHWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770794514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Ai2YZH9/yhmkTt2rOPJ1vI3sgB2BVPXr60OH2LiRg=;
	b=KLZ4aPvy8w6rXL2eH1gB7hPOd5cz0+68jQMDGeNge8NA6laMe+18DjDHg5PPqH2APOJ8k7
	Ihq1NozSKVmxRkCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ionut Nechita <ionut_n2001@yahoo.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, superm1@kernel.org,
	jkosina@suse.com
Subject: Re: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
Message-ID: <20260211072153.swbOm1qA@linutronix.de>
References: <20260208131819.37276-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260208131819.37276-2-ionut.nechita@windriver.com>

On 2026-02-08 15:18:20 [+0200], Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> When Ceph MDS becomes unreachable (e.g., due to IPv6 EADDRNOTAVAIL
> during DAD or network transitions), the sync syscall can block
> indefinitely in ceph_mdsc_sync(). The hung_task detector fires
> repeatedly (122s, 245s, 368s... up to 983+ seconds) with traces like:
> 
>   INFO: task sync:12345 blocked for more than 122 seconds.
>   Call Trace:
>     ceph_mdsc_sync+0x4d6/0x5a0 [ceph]
>     ceph_sync_fs+0x31/0x130 [ceph]
>     iterate_supers+0x97/0x100
>     ksys_sync+0x32/0xb0
> 
> Three functions in the MDS sync path use indefinite waits:
> 
> 1. wait_caps_flush() uses wait_event() with no timeout
> 2. flush_mdlog_and_wait_mdsc_unsafe_requests() uses
>    wait_for_completion() with no timeout
> 3. ceph_mdsc_sync() returns void, cannot propagate errors
> 
> This is particularly problematic in Kubernetes environments with
> PREEMPT_RT kernels where Ceph storage pods undergo rolling updates
> and IPv6 network reconfigurations cause temporary MDS unavailability.

I may have misunderstood this but how is this different from a
!PREEMPT_RT kernel? As far as I understand, there should be no
difference in how both kernels react to the situation.
Could you check with lockdep and might_sleep if there a locking problem
and some kind of state is lost or wrongly interpreted?

Sebastian
