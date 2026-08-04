Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA43F0770;
	Tue,  4 Aug 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886964; cv=none; b=g3SLRKogPN2vQHMBi1n8QOJCtrnf8avkPTd9letujmQMJWjGe3WtIteQQvfxa0O+edETG09TsB1aspk5gtF2P7bf7uCHEiEXIAGyoZWsWSU4x6KLeMocXP+M/GSVI6sSnuJ/36Krtg9g1dfdeycj+hXqPBm1cQidJt47cY7jS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886964; c=relaxed/simple;
	bh=J5rjbWKq6OEyzLf8kVEjD7UANtTb6xie+mHxanqf0FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjQ/YuB+dBPgNPxKBYHpQas1Mn08J6WbjxirqWtx58MDnn7Hl0M76kIzdjdnpDoPAoGvA9A/dVG3tAKTds5akNk2BDbNaBbbJ3VgPUQV2xL7WhF4p7hXsHSoAipu5miDjnM+e8ic5VG/j5ol0kjOovWBvVeMq8ab4NjdDoKD3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WNMaRDqS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNMaRDqS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SgPfd1vWJv9VMjxLkdcbY3fOZgi9Hm1oyp5+bOca4VU=; b=WNMaRDqSCSBUUlGBay1cyFZnkU
	e+Wvan9+u3JSGYm5Sbpjr8yOnb6zQiP/f+Leip6u7U3R5MYSU9vhdDR5gQT2jsTpZi0w6n+L54NiK
	nMOVVJcb1xO057pFWx0Z/NvQ6KZ9zuoID/Dh1JgEq/RgaHUddMYAx8SFuDm228pZ/WzqfG1aBRnLK
	gC40Rp725xJeFpWFjORymbUeyOsLDxL0Toy3QAW01TdgS5JBI4clidRO86tPzREdN1xotN8w/Ul26
	VlXcxYd4ZACD7AbPPWy0IEIfgQl/XmLVX8Dtth4tmkrei+zVHXpitlXRaHJPWkE1B8F9pbKh+Ztv9
	yZ3/QWsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrOmA-0000000524Y-0wVJ;
	Tue, 04 Aug 2026 23:42:26 +0000
Date: Wed, 5 Aug 2026 00:42:26 +0100
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
Subject: Re: [PATCH v2 01/10] ceph: add ceph_folio_snap_context()
Message-ID: <anJ44lo6HHFLlkNZ@casper.infradead.org>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-1-81f0ab065284@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-1-81f0ab065284@columbia.edu>

On Tue, Aug 04, 2026 at 02:52:09PM -0400, Tal Zussman wrote:
> Add a folio-based counterpart to page_snap_context() that reads the
> snap context from folio->private directly.
> 
> Convert the three writeback paths that passed &folio->page to
> page_snap_context() to ceph_folio_snap_context(), removing three
> open-coded folio-to-page conversions. No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
