Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10343290BA;
	Fri, 21 Aug 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340999; cv=none; b=UJ1HwhGmXzcAgtmLNT4g86zVghem75h3U28llgupqFQ9QHQq+4oagC1/I3/c1sI36kS/8jxYYBhE5VCdOIxKqpkuo5LWGij/lBd6ePKwS+6yz1H+0POcuL5PrOQitPx9sZzdT70oh/8Jov0Yu3hhYPCVO4pRDivZo3gTjmQdNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340999; c=relaxed/simple;
	bh=cUsq+Jmf8apQl1NBeoDRm+LBp1wVZs2qURQY2o9c91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFKNS8naZ7HtSweqOpZ+FCwJFJZxU6O/qvVLfcV+SQklGZlFqm/QNOXBWHv4+pU/h4oNb7lSgvzSPoLgZ2TOc9cOBni6DyoQZDrZxgAEC8RxLOSphXQia5qIsrZYbR86T5yFTMyCcROep7gz1JQ5WhBy3n0eNd1JyrHDKjX4qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG4wbAk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG4wbAk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDBD1F000E9;
	Fri, 21 Aug 2026 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787340998;
	bh=MTBVTy5LK2ZrdXijoZ7hCKmeHVYe2AOnTQW1ot5ORYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bG4wbAk+jA0qzDbtfwGpqVh5IS9ShIc//CTT8Z9NyZWONqpwJ7iVEP6gR0heAy1Qb
	 r/2Wzh+DtGdPP68FiTaZdwzlppJ2uoeFDY7czLnObUuHfRY4MAP0se9CmqS+SZuNzv
	 SZadQbrbQDaPx+HlVaqaSdVl3m53GFWLxBflmDI7Dd+yRF0PetD4g8ICGPUQ9FDtW6
	 3uKzsCvDwmLL6vT8HaCiph0gQGEXd65VdFZBp09bUxf15D4iYcO5nWw02btcjLm43i
	 Rvgrq2t5+VRbEKm+3KOZsD1s+A+RgCONiusKZRyT/PKGwXOH6nCZg7S3QewW3W1x3O
	 4HOxpT+2D/hkw==
Date: Fri, 21 Aug 2026 19:36:36 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: Re-establish the FIPS keylength check in the
 Ceph code
Message-ID: <20260821193636.GB3141245@google.com>
References: <20260821144323.776371-1-thuth@redhat.com>
 <20260821175312.GA3141245@google.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821175312.GA3141245@google.com>

On Fri, Aug 21, 2026 at 05:53:15PM +0000, Eric Biggers wrote:
> Do Ceph session keys shorter than 128 bits even actually occur in
> practice?  It seems that the Ceph authenticated modes support only
> AES-based cipher suites, where the minimum valid session key length is
> 128 bits.
> 
> I wonder if the client should just reject session_key_len < 16
> regardless of fips_enabled.

It looks like this is theoretically possible only when CEPH_AUTH_CEPHX
is being used but the session key uses CEPH_CRYPTO_NONE, which seems
insecure and contradictory, and likely not ever used by the server.  I
suspect the ceph client should just reject that combination outright
(and also session_key_len < 16 as defense-in-depth).  It is up to the
ceph folks who are the experts here, but if there are unnecessary
footguns like this, they should just be fixed for everyone.

- Eric
