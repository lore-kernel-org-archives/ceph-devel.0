Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717E38236C;
	Fri, 21 Aug 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334798; cv=none; b=nWWRR8fw7mg96+OQbkM/pSbl3GF6ZO1K7h6xHe7fU38RQH7Zmbzbw8AMwchYnCwfDEO9tiA41X7tcdz3xYnORikKA+Q8bBXVPXNuejNxLKmIb5YhWyxNPAWudv+nJ2+u2gwHruOg94DAtshwpkRZjyHDI0UdtZH7L6WMVplL91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334798; c=relaxed/simple;
	bh=sVAVAskSBK3I7gvYU7LbyE3hPjyQJtySjxMxM+AzHeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGBR2rt8vXu+yRin06TqcEGICvwEtpM7AxW0mT1Ue4/mnQv5jl+HtyoAiPihqfsGhu0XI4+/KxqPcApGPIwPvLTUvknOfI2YzqaCZIckfyegBbWMLanJXvSz0MQEPw7ICLH0hr178Xxu7XPL8G83/quweejZxT78NfQM2lVNhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9OamfVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9OamfVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4960A1F00A3D;
	Fri, 21 Aug 2026 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787334794;
	bh=i+VHzk6UQfoHBkoJ9H9hL1t+2BennulS/NZSB8biHMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N9OamfVKw4RDXi7autnbogWYFuBROsVrlSWpzgdlnncBIM4iLEhPaZhbxUbm+14y+
	 r0339D4Oz5J/i8chbeA7fpdnqn31IAq6w10fX1CtnZXyJpqOiyDkl1P8/bLEcHzs6h
	 3Guz4AWJbrF4U6yYTqnitxjEYzZPWGrpXNCL/CVzCwsTNHBtFxjx1uPe5lo6QYT8Mr
	 S15QqykyKev5v2muGUgDs96o/rvsl4dBQWChju7WUy8PE6JcNSfU8XE3eiZAi9NyOo
	 AP/H6BFnb3QtXEa6jpp3QMK10IxGJxSwnz9BMMexRe+rp12J3OgUrckO+WBT+OkZzW
	 ceYHZEErdfH0A==
Date: Fri, 21 Aug 2026 17:53:12 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: Re-establish the FIPS keylength check in the
 Ceph code
Message-ID: <20260821175312.GA3141245@google.com>
References: <20260821144323.776371-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821144323.776371-1-thuth@redhat.com>

On Fri, Aug 21, 2026 at 04:43:22PM +0200, Thomas Huth wrote:
> When the Ceph code had been updated to use the libcrypto hmac_sha256
> functions instead of the "hmac(sha256)" crypto shash driver, we lost
> the FIPS key length check from  hmac_setkey() in crypto/hmac.c.

Well, except on s390 which already didn't do the FIPS key length check.

> @@ -720,6 +722,9 @@ static int setup_crypto(struct ceph_connection *con,
>  		return 0;  /* auth_none */
>  	}
>  
> +	if (fips_enabled && session_key_len < 112 / 8)
> +		return -EKEYREJECTED;
> +

I assume it's intentional that auth_none is still FIPS-allowed?  Kind of
ironic.

Do Ceph session keys shorter than 128 bits even actually occur in
practice?  It seems that the Ceph authenticated modes support only
AES-based cipher suites, where the minimum valid session key length is
128 bits.

I wonder if the client should just reject session_key_len < 16
regardless of fips_enabled.

- Eric
