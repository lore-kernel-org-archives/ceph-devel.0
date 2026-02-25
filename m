Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06902765F8;
	Wed, 25 Feb 2026 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052472; cv=none; b=uqBd4gDtli6qSZ5fsJqqF5WulGqQoo1FHFVPOlhmsAJsINJTw6A8hXSCALIx/D5WoCm8tcThYpEmoL2K46H72yTVz2MadcFpTo4cnBl3CkCNyzHmGJOuq1G65ddt4yQ+/ZngKVDi5UqaBSHpYhKy/rYjBtKBBkSHFflLYtfLsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052472; c=relaxed/simple;
	bh=2yT4ADSBPPCG0CTUvlfoVWgrps2YVVrBlCzLte10rO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JzLtjhMthNm0KemCpce1hKdrMlWl6qWyiImFnbhg3IPskRIMPSx8OzsN07l+5kXms3l1WSJ9y5TAy1zxt/3P3rObfPS16yq241eNCSGxB/I+xu278V+1ql0AySOcPd1+nsgSmXaJEX0gN5l8eLNeZksGCX8fIcpWd9/de19rFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=AMZRPdDE; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="AMZRPdDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=2yT4ADSBPPCG0CTUvlfoVWgrps2YVVrBlCzLte10rO0=; 
	b=AMZRPdDEW8KzP8pgs5e9OOx+19EC75mmrb2oFaRa1lMVFR4lBsrmBsfQmNADCrp8bLW5cN3ubhv
	HT3DRfJ3n4U9LuYUrkgLmsDJ2zDRTOjiaOhJz653/Mp2phUjDhRjxXuRxDmMTW4jcbxWFYXggJch6
	cTE0Edmf0OGMIwlvVLzRJZO7BLTdvePZahxIH7z5xQpcyOKHLXmTC2f7zCOEjub2pCA4bYyg+awVg
	hP5RK8AKsdsUHnYKuPcTuZPh+xWVsQcmcjHj6X33wSv/NAWD4QVVUgTWZpo37X7zxmfxF+jU7O6tx
	QJkIkcBP4xs5nwjb6+UZvo5+PRS/21Uppct1Ik8EoHH2637RjoMpuqhVNt3deTwJ2zij3W0JD1ZrD
	ZmCAVgJq0FzDTqvv1jCXBOX+HEZ8hM9scqK+rO2hMxQJDmnDT+O/wnflWtdHQcpTTw3zscBt9vnxB
	jHEGhsEBotxUyGds5jQge+OvmyNZZya72g0PO7rkdt4RTq6Th9gZ2kaRWkOBfXcI9AarM6ks40FVV
	Z5cwUr64aqfilYThwBUCRp8oMzB9XIV57KN5WHYiN/PE49G4t3FWyVr7AQcKOFxapEN+CL0yZxyZg
	RJ2klyVOheBCCSHBeW0fqL9cAAgGwYqDDM3AxM1i57Sbd6AYeYViQbcIdu8q6nC8WAvhs=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vvLnK-00000008yMR-29CS
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Wed, 25 Feb 2026 20:47:42 +0000
Received: from plank.m.venev.name ([213.240.239.48])
	by pmx1.venev.name with ESMTPSA
	id SGXJD+1fn2kdoiAAdB6GMg
	(envelope-from <hristo@venev.name>); Wed, 25 Feb 2026 20:47:42 +0000
Message-ID: <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
Subject: Re:  [PATCH] ceph: Do not skip the first folio of the next object
 in writeback
From: Hristo Venev <hristo@venev.name>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, "slava@dubeyko.com"	
 <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
 "ceph-devel@vger.kernel.org"	 <ceph-devel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Wed, 25 Feb 2026 22:47:41 +0200
In-Reply-To: <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
	 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 20:24 +0000, Viacheslav Dubeyko wrote:
> You mentioned in the ticket that you did some testing. Which
> particular testing
> has been done? Have you run xfstsests/fstests for the fix?

I only ran the reproducer scripts in the issue, as well as some basic
smoke tests like "does my home directory still work if I access it from
two clients". Do you have CI that can run xfstests/fstests?

> The ceph_check_page_before_write() executes three checks:
> (1) It returns -E2BIG if we have end of strip unit. So, your fix
> sounds like
> really good catch.
> (2) It returns -ENODATA if folio is beyond of end of file. And we
> clear
> dirtiness of the folio. Finally, we can exclude it from the dirty
> batch and
> forget about this folio.
> (3) It returns -ENODATA if folio doesn't belong to current snap
> context. So, we
> keep the folio dirty and exclude it from the batch. Maybe, everything
> is correct
> here. But I am slightly worried about this case.

If the page snapshot is newer than the writeback snapshot, this means
that in the writeback snapshot the page was clean, so we don't want to
flush it? But what if the page snapshot is older? I have never used
snapshots, so I don't really know.
