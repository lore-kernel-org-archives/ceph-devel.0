Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BC18A93F;
	Wed, 11 Feb 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795202; cv=none; b=KjOX2Jmfud3e+GFCnWYzqrXcxzQPV2o2SqEl3ywlzlycpohulIq3+2Ga52rJ/vZr9SC7ACG/+YjZQrLrvaydAcrQQyOAO0lUoFQBNmxrF7oXeJwwZWaIjPSP0WIowZiiXwLP0d3LFYC0XLOFBlJI+MBCDfAeCHWfEiOCYkj6Gws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795202; c=relaxed/simple;
	bh=bq0bQZprqGv2xDzXpQE0zNCpjy7c+E1AUMFH87hnano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy4K0WGaJVvTtXPrht9ZrsyBjwca6YpYJbBy1RgPVHP2ZGZce6TgpHyMADQcVDK9nhes1Kuai/5DQ9zCzWRyuETHj6PLgOYfNT8JTxoLeAOaCldPMPGHIHELM6Izrk1sQxhgEqnYWCI3rLGJrb5DFJrffoawiSyN6P3t5TdsED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvrO0Wal; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALKUUzFV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvrO0Wal";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALKUUzFV"
Date: Wed, 11 Feb 2026 08:33:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770795199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs+B88hANQRpkxFpfy9EC2ikkNTRuzXax70gj3aIcRk=;
	b=bvrO0WalzE/yVMtDuD8FFmLtoALR9bn4qGWSgN9RFMBQIunVeO0rzeP6rlk8NYGCc5/+L7
	1V3bnpQQFS3qlhAczs0Hy2Q1WqEqfH+wzg7oc+PPlL/uO5aXLmqYiI0jqxDuolAnoKsvWt
	JgryzInQIumaVMyaSynfs2DsHCF3ICz6O9gnId//zWMWLiLs4dcnmNezn9jZIzhJmPZrdk
	Ts8qDCKEW89bqyZ7+sf+KUUfSSEkZ3kGCOaXcIpAVgmVsMY6jGaOQlcrFq2w7lQtr8dVrj
	Jaf0DD4r91tdryyJdtZF1U1GyMZYJP8pC592OC+KQZLzc5LyRia6HRbJzZUhew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770795199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cs+B88hANQRpkxFpfy9EC2ikkNTRuzXax70gj3aIcRk=;
	b=ALKUUzFVh/ZeWrXMvl6Q7XVdOf537VQqjXFc/Q+V7WZ6KT6MPi7mT3GUIWSMlBtT6/blzi
	6lZNEz3XaItcjPAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org,
	clrkwllms@kernel.org, ionut_n2001@yahoo.com, jkosina@suse.com,
	jlayton@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org,
	sage@newdream.net, slava@dubeyko.com, superm1@kernel.org,
	xiubli@redhat.com
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
Message-ID: <20260211073317.M73faj98@linutronix.de>
References: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
 <20260210071929.15602-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210071929.15602-1-ionut.nechita@windriver.com>

On 2026-02-10 09:19:29 [+0200], Ionut Nechita (Wind River) wrote:
> You're absolutely right that if the address became valid in 1-2s, the
> third or fourth attempt would succeed. The problem is that in our
> environment, EADDRNOTAVAIL does NOT resolve in 1-2 seconds. That was
> an incorrect generalization from simple DAD scenarios.
> 
> From the production dmesg (6.12.0-1-rt-amd64, StarlingX on Dell
> PowerEdge R720, IPv6-only Ceph cluster), the EADDRNOTAVAIL condition
> persists for much longer:
> 
>   13:20:52 - mon0 session lost, hunting begins, first error -99
>   13:57:03 - mon0 session finally re-established

My question again, is this specific to PREEMPT_RT or would also happen
in a !PREEMPT_RT setup?

Sebastian
