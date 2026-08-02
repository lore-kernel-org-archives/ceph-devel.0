Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C9175A86;
	Sun,  2 Aug 2026 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707558; cv=none; b=fVWHwgb2tnsg0oLXngZDbWeenvhTUsYzJr/4zgSVVf46v8oxZYpX7uxi9FEmebxrKYw5XdREseKAcLmG4GvD6vFtfNzrtLOp7wRoxQlIsYrcn6OshV1NaTthn5zHlhsMkw3dM6pLB3fwWxpUmT9IMLoPzoljdMtgKmWCNjhsdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707558; c=relaxed/simple;
	bh=W3vLDaFF88PJ2fpPD9x2e0R+IazsVlhy+sKpGO1xT80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuQjBVEuoHQftBQre03bfXsEZBpz/YeT9cqqEum2JVxdK2PGD7wEs+Xx/3ZlkxcF93mHlrHyhlbixifCkOkeGUapnWooO0cMjGTav682YJsyrQj9zMjNB41veOlCF7RG9CTgmHRyXZv2SJJ7bJNNEdU9CfNVaaJlRuT+uCslGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cc74KTxl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cc74KTxl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NkIZNLyjy5H2HxUDtsPS0FkLQCvxSildqvdFqEyK5e0=; b=cc74KTxla2ziUPV1cjMhrHDDtD
	qc+2wJV6rBHWzv1DbBUH6EU3plv4phcv7RRqsYv/0IZ06ugmGZzK8rCyZ+1bp7daMTGCl/NNu8RCi
	M80z/TQBsdY19YLbCt78ZjWE9W7kfemXeWqQh94fgLBuSa0PADSGA7sCsEUIpTdQ83yFsMoaBT0uO
	XooUUgXxO61nnwzclSBrbpGQ+cyEflz3GY7rtyGsMK4JsCYr5sglDkyS7lQtPjdmJYTBsIN4a2HN7
	NThFm2ykmg5gRBYlwxxwOnGf+jhcGWy1cpTODKzeD1G+MLhFOQkU/FobtYs530PfdekKxrrRvDFJk
	Y5YhyK9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqe6D-00000008mjd-3nGW;
	Sun, 02 Aug 2026 21:52:01 +0000
Date: Sun, 2 Aug 2026 22:52:01 +0100
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
Subject: Re: [PATCH 1/4] ceph: add ceph_folio_snap_context()
Message-ID: <am-8AaWEHm7I9b7N@casper.infradead.org>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>

On Sun, Aug 02, 2026 at 12:50:02PM -0400, Tal Zussman wrote:
> +static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
> +{
> +	if (folio_test_private(folio))
> +		return (void *)folio->private;
> +	return NULL;
> +}

Filesystem folios _ought_to have folio->private as NULL when PG_private
is unset and PG_private set when folio->private is non-NULL.  Now, ceph
could be doing something Bad (I believe hugetlbfs does not honour this
for various reasons), but it looks like it's using
folio_attach_private() / folio_detach_private() appropriately.

So I think we should just do:

static inline
struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
{
	return folio->private;
}

(folio->private is already void *, so it doesn't need to be cast).
Splitting the definition where I did puts the unimmportant information
(static inline) on the previous line, so somebody grepping for
ceph_folio_snap_context gets the return type, while not breaking 80
columns.
