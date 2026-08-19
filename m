Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0653C98A2;
	Wed, 19 Aug 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118260; cv=none; b=OoUpL+C1IXCV6Y+1QNW6OAwSJhwWc5aEuE3FpOHQU52xzDuKRpQRvTjSaFju1Ou8A14QJbr66L0wT6bfXBbfeNXX+qIxIVEK8rFNgOI872F/ECH6Md2cZ2vkwdPi61o7YJd6riM5CG62UWFmwXEcUgU6SpLhAdq7YrkR0HAG9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118260; c=relaxed/simple;
	bh=wqRWz6K394Gp31cUbupIZqkYFYxIyT9nNJwbaMA05Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoVl55dSKS+lvIP8DUAL9nmA1ej74wt1WbX/RqGIBs0TljcgL2TBXQCf+No5J2HuVFY3O1JjjpxzdHaknXz7KtGvw8v/JJH6jmLVwjuQazhivXakjthG/IZMbMh4E2gnYDik22vUfivSF1JlrIMfux5mkNRuOubS/E5sBgGrCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 254C968C7B; Wed, 19 Aug 2026 07:44:14 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:44:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: use iov_iter_extract_pages() in
 ceph_msg_data_iter_next()
Message-ID: <20260819054413.GA32590@lst.de>
References: <20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 17, 2026 at 06:16:56PM -0400, Tal Zussman wrote:
> ceph_msg_data_iter_next() gets a page reference from
> iov_iter_get_pages2() only to immediately drop it, asserting that the
> page is pinned some other way. The FIXME here predates
> iov_iter_extract_pages(), which takes no reference for kernel-backed
> iterators.
> 
> CEPH_MSG_DATA_ITER data only comes from osd_req_op_extent_osd_iter(),
> whose only caller passes the netfs read iterator, which is always
> kernel-backed. Use iov_iter_extract_pages() and remove the put and the
> assertion. The messenger still relies on the upper layers to keep the
> pages alive while it uses them, as it did before. Extracting from a
> user-backed iterator would pin pages that nothing unpins, so add a
> precautionary warn in ceph_msg_data_add_iter().

Yikes, this goes through like three layers of pointless abstraction
for a single user :(

But trying to unwind those it comes from ceph_netfs_issue_read, which
is the netfs issue_read method, which is used for all kinds of
reads, but it does seem like for direct reads it uses the kinda
interesting netfs_extract_user_iter helper to turn the user iov
into a kernel one, which makes all of this such a freakin' mess.

So yeah, the analysis is right, at the same time using
iov_iter_extract_pages is just as weird as the old version.  Someone
really needs to clean up all the mess in both netfs and ceph :(

> This removes the last caller of PageWriteback(), allowing the page
> flag accessors to be removed in a future patch.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
> The assertion is the last caller of PageWriteback() in the tree. The
> removal of the PG_writeback page flag accessors will be sent
> separately.

What about just killing that assert and leaving the rest of this
mess in place until it is sorted out properly?  iov_iter_get_pages2
is a pretty good marker for that, and it would be sad to loose that.

