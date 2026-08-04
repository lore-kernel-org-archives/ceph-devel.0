Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653244210F;
	Tue,  4 Aug 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887636; cv=none; b=gFv1OhkLumvWLzd52w6g78uLskqJ3uK0iVi+dUdi1E6HYyy1CYOv3c641Vai1PTkkTMJcj94Z2pSL7JkU5HSRzYXX8ryXMOFIc1ORL9fIG5VD+LsP7MvGFTNp85AdZ2LegM1NggB4trmvJeDuUhGb8/88wZx/cRAaylTane9h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887636; c=relaxed/simple;
	bh=iOdLhzMPTAMKj1EefOnLmIw4T5DknH2A88xDazQYVPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KISaN57bUTeNeVxwdAIavg8YiVSQi/wUsq6pIRHmkTVizWC7sZUDPrxxQNAZSL7FjrpzLbPJJ5L2ffbZOJAPIGfm1Ts+Co0Oy4Lmsbcq9yb4ES/J45qXpj1hyPIkKNH6RgD62w/HbDiDa9lD9V/NPpLOZwh4bXnRjZQU7nbYVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jH2dFmcx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jH2dFmcx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qMeVpFS6N8BZKI+nhMYBTzNMVKlCDDpkyjioJy+/0kM=; b=jH2dFmcxEefQtDz1cvmV2YpJaG
	gWAhL16FO9WXtCg+BwwKZB4MQLPVP4Dag/k33rNCCLrqvJmAbtkhXeZVXmQ5qGZU1nCuNO07bHadj
	BEKHOI63rXldkkvyT2AmwLrvOPdjB/lCeEnxo4JOYrxBJuVXHPWF9pOkTzRoddU2KFyf4QwsSYQU2
	NPs+/txzIFHVQMgBLwDGKaDE9KtMUZz+9knX+GY/FhyHWq0l55eaOG6hUvHpYCkrMPElJmL261tLP
	8RTdYlmsWJup47q6gSt4M+xNZ1hweYGzjymL7KyLI/qBO6r/YfteKwB2RwSepM/PGydABHxbhubaL
	+BBz4mhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrOwc-000000053I6-2gPY;
	Tue, 04 Aug 2026 23:53:14 +0000
Date: Wed, 5 Aug 2026 00:53:14 +0100
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
Subject: Re: [PATCH v2 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
Message-ID: <anJ7am6p8iDi-wmT@casper.infradead.org>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
 <c0cc3539-be7d-47e0-82b7-9d7239c37907@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0cc3539-be7d-47e0-82b7-9d7239c37907@columbia.edu>

On Wed, Aug 05, 2026 at 02:33:34AM +0300, Tal Zussman wrote:
> >  		for (j = 0; j < num_pages; j++) {
> > +			struct folio *folio;
> > +
> >  			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
> > -			page = osd_data->pages[j];
> > -			BUG_ON(!page);
> > -			WARN_ON(!PageUptodate(page));
> > +			folio = page_folio(osd_data->pages[j]);
> > +			BUG_ON(!folio);
> > +			WARN_ON(!folio_test_uptodate(folio));
> 
> Sashiko complains:
> 
> "Since page_folio() invokes _compound_head() which dereferences the page
> pointer, won't this cause a NULL pointer dereference before reaching the
> BUG_ON(!folio) check if osd_data->pages[j] is actually NULL?
> The previous code checked the page pointer before any dereference occurred.
> Would it be safer to check the array element for NULL before passing it to
> page_folio()?"
> 
> The BUG_ON can just be removed, as fscrypt_finalize_bounce_page() cannot take
> or set its argument to NULL as constructed, so the check was unnecessary
> to begin with.

Heh, Sashiko beat me to it ;-)

I'd agree, the BUG_ON was always unnecessary, and I was going to
recommend just deleting it.
