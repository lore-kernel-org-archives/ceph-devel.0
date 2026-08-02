Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E4312837;
	Sun,  2 Aug 2026 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712990; cv=none; b=qA7MR4sy7ccBiW4uYOuxDufNLtoWaMe+0pRa8gEHYAEtVgXe5uFs7g0JQS411loa7Mxwjdw8Ixuy1hKBUjveMw2A6S3ipX6mhju98b3ySz8bhNl/9gzRkbmTLX2N790h12Xuu2s1fdUvFsDQM9V/jip96HsMJf4u5tAmgr/rFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712990; c=relaxed/simple;
	bh=aCQDa0pBNH5kw9U3N7mQ/ekpncdK7B5TtQhFRdP51+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyLXldHVttPioBKgr85YCRw4gAtKQtS9s2Ydo2OPFEazNhKIOQOd7PV5p/ia7KLRrfT9YZbebGA3aDgj4iOLdeJ5NMNkWTZGUBf3X4EIp4dSe36CIAxDvJGYvXf7T0Lr/8kDNcxAne9fq9KpIShGhHwe0j1BBUGkyL2cq5ue2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SQkOZwYd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SQkOZwYd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JI1ktj3Bz3caTxqnuCI4TmhxMGBgh+dVMiaBP2zCz4c=; b=SQkOZwYdQ6aROR/PLvxeztwjsl
	A6QyQsShXcTzOPW/XpH1Zr7axPN2BtzTrDixng/CTDk5sWMVt6EQ1PhzZuz8210YEqv2bBmVUNE54
	2QLm1YvBS51NbyoxfQuTBczwg6NImLwZLftV9vWPKfeVCukNvgY7AanhCBLPn9nH0CKV29NsV3Jl3
	RdJwZEmb0K/sPtoJkt/OdzeJnQs5YezzfLy1DXvKYfuivXhc+r5KICXRx2SBMFgcGnnj7xjsD3SDD
	ZBXoIYMqf33/DPczcwBOYp3vM8dGDUisP75kOERfF13y9jGKZin4LPePcjsNHLnNIxSGScr8EgknA
	SGXZsZLw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqfWH-0000000CCTg-3fst;
	Sun, 02 Aug 2026 23:23:01 +0000
Date: Mon, 3 Aug 2026 00:23:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: remove wait_on_page_writeback()
Message-ID: <am_RVfvDCDDOA9L-@casper.infradead.org>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-3-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-3-6c35d6b3ad36@columbia.edu>

On Sun, Aug 02, 2026 at 12:50:04PM -0400, Tal Zussman wrote:
> The last caller was converted to folio_wait_writeback(), so drop the
> wait_on_page_writeback() compatibility wrapper and its declaration.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
