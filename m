Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B963603C4;
	Thu, 26 Feb 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134977; cv=none; b=tp2xHgB5Wt2cHo8jITgN9HWGjAjRWLEtNvAUe86DytfV8bBRCCxYVI8tFvRGcpS2b5QCI42FljyKAlwFF+IBPZ+a1eK3iP9RUQe4y26BNkDqATNeRYjklBpSG3cvFRQBJUmOZYAjQAVm3YVqpkz+20hluYO0CYIqiOA84BATEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134977; c=relaxed/simple;
	bh=dpmSNPihyAoZtkoSmLLmgVreHbYGe36VchpfBBM4isA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VU3FdlqyQAhUAIZAC6na6KrBdgjc29xDpMtbnAd+yMvsOL93ImFYoC/XOqrjqpAf4C1xA7b1b0FGEwtEvpTRAYuejATelWET7UMv5a7O9o8AMp8RXliFKHKR0ZHO7ploTYUQNpG02jiohj70s5DhFJO+6/6gtpeNiEaCu1kaGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=RSkWrCHf; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="RSkWrCHf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=dpmSNPihyAoZtkoSmLLmgVreHbYGe36VchpfBBM4isA=; 
	b=RSkWrCHfLCikNJCsIB3ZmI9EKOKoxZeQKmf6cCT4cApPlCxRaSGsJO4RxkBzKf143l303miaYHJ
	IKRmXoDa5S2Bs84COVabSKSmemYMRrcBr8JtThBsmlsa8F+/hCOIMTeul/munqq8uT55Yp4aCrt/R
	63gGkQOgWMr+bux7COwfN3MF6xstaPkaLXlGS4nDYYBVrt02ie+L6CSBq3+HYvgb1g3zGJEb9KAqe
	PwA7BibAIgkKBhsYpA9LlsG/vV4Pckng8FtsbkI+ahbcFavjSfdHXcRlExIXWAEDWj0ahAjuEWzRL
	Lo04kaCiH4+N2QEcEbCPdfoYK/DWbkq6tn78f/5eqnxVC+Xi3+gm1XHcFKbC4XifP/H11Lu+ZbHkC
	hy666UuIQx5RcuPyEWE2StFYSSlCef373jywNKIunRAxIdUttJAv4/CXyuaTTsqcz+FCUd3TlIJSv
	pILZ2VQWuSuCCn3IIEUuEopsFH6QWL4hFR7neq3rS75uaOrpTxXRVtQRaGC4sPnVxEZ7sMFBGnbsz
	GXb0YyA/k9gQVlPQ2uAzScIQmbZfJaa3aM3kL90O6T0y1r8nWxmaYwyK5/GygKUf364XgVZPRFJYr
	n+KH5qNzJzsOphG0uOwMU+FCvnV9mcnAZWNh8Wyr0twO9659e/WFxafPQyGAqYatBxcq8=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vvhFz-0000000A2On-1hNy
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Thu, 26 Feb 2026 19:42:43 +0000
Received: from plank.m.venev.name ([213.240.239.48])
	by pmx1.venev.name with ESMTPSA
	id a4TXATKioGm3gSQAdB6GMg
	(envelope-from <hristo@venev.name>); Thu, 26 Feb 2026 19:42:43 +0000
Message-ID: <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
Subject: Re:  [PATCH] ceph: Do not skip the first folio of the next object
 in writeback
From: Hristo Venev <hristo@venev.name>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Alex Markuze <amarkuze@redhat.com>, "ceph-devel@vger.kernel.org"
	 <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
 "slava@dubeyko.com"
	 <slava@dubeyko.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Thu, 26 Feb 2026 21:42:41 +0200
In-Reply-To: <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
				 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
			 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
		 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
	 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 19:31 +0000, Viacheslav Dubeyko wrote:
> Frankly speaking, I have troubles to apply your patch on 6.19 kernel
> version:
>=20
> git am
> 20260225_hristo_ceph_do_not_skip_the_first_folio_of_the_next_object_i
> n_writeback
> .mbx
> Applying: ceph: Do not skip the first folio of the next object in
> writeback
> error: patch failed: fs/ceph/addr.c:1326
> error: fs/ceph/addr.c: patch does not apply
> Patch failed at 0001 ceph: Do not skip the first folio of the next
> object in
> writeback
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am -
> -abort".
> hint: Disable this message with "git config set advice.mergeConflict
> false"
>=20
> Which kernel version do you have on your side? Are you capable to
> apply your
> patch from the email?

This patch is based on 7dff99b35460, which was master at the time. For
me it also applies cleanly on v7.0-rc1, as well as on ceph-for-7.0-rc1.

The patch I uploaded to the issue tracker is based on 6.18. It should
also apply cleanly on 6.19. The conflict seems to be caused by commit
fa589acaac08.

> Thanks,
> Slava.
