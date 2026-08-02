Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA433122A;
	Sun,  2 Aug 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712964; cv=none; b=gZOa9p0LpVrXGEHK8yCZEzfq57bcQBB0phZ4wg1cSrAZ80pbJnHDgJDH6E3I/kF8+qOomun/YXjwb5orqmoN4Jy2sGBH/G/6fvRhe3RVP4g+Vz+E+w9RsIeMNmi6437eLhT8uxZuhaUAVbMqorLWVIUVI4AC8zxEHNgP5vcrsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712964; c=relaxed/simple;
	bh=FXvgVbgjBbFQvY2YAiPg3keGj3Gem90+G8iCPBisMiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpdfu52eAZsnTR6w+85wCoeaFyf24i9qyhWplWC8oJdm5a/GEe7si+EuaRoiInoirsJLokXff/RkhmD/4Eq9PVaHFvVhe+QU01Y/4Im9Zyc7qahUbblhxZPxkDhz3wg8c0qvXCnu6AQLNz2TVeEiHkJAuA1WKk65qQ+M6I1DH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bNCcfmfX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNCcfmfX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CYPOkQbW1lOvJHgzDB/D42RIqBuqUE7gwCxeBtFkNcE=; b=bNCcfmfXzYPcDZU4gQ941j5m+e
	ezZSwgr3RloMRdgx0AtjFMkwQv2TZcjb5FxNEO+bLaQhhSYdInhHgG+cIC+ZK+3nUgiWp1JM07dPL
	pEB4m2M6GzM47r7k6Q2hStBVUUU0qvd/67jn/wsowipJ3J4yY0F+pqIwjYRrsGK+1OrHV5LNehNJq
	DRw2NG62SGqccFo52U6OfpfykBJWe+M9FBtLKr+Pm/9/y7Ap/pNaMDGPGZbU5b99YEYTpV2kWQajN
	cxOJy+i1wLHH5/obl9QyKatff8oACgs9wpdeTNsFdh+6YUkxuaploALcfmznKBTZkOHuYldJR8gIu
	w8jxBHzA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqfVl-0000000CBhr-0SJ4;
	Sun, 02 Aug 2026 23:22:29 +0000
Date: Mon, 3 Aug 2026 00:22:28 +0100
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
Subject: Re: [PATCH 2/4] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Message-ID: <am_RNGURAG-chvAM@casper.infradead.org>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-2-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-2-6c35d6b3ad36@columbia.edu>

On Sun, Aug 02, 2026 at 12:50:03PM -0400, Tal Zussman wrote:
> Iterate the writeback batch as folios rather than using
> &folios[i]->page. Use ceph_folio_snap_context() for the snap context
> check and folio_wait_writeback() instead of wait_on_page_writeback().
> 
> This removes one call to compound_head() and the last caller of
> wait_on_page_writeback(). No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Beautiful.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
