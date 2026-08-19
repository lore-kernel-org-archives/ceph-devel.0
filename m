Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD46353A98;
	Wed, 19 Aug 2026 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149606; cv=none; b=bwB+MHGWR1Xk/mNMpt5AVqjlCOAK0mStKk8Nd/OhsRSfRNC4/Ml3IJwxx5EOoVOfWt/fpq2GTpz0Y1vHwmONRS3+IVWPgcMiiMFOp/v6IKUHhvdRCfH39TOCx95UnWauYps46fjo03TpPR5D3BjK4cotdbvEs7r9R71VOGKn5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149606; c=relaxed/simple;
	bh=lnOU8jHcxERZI0URj4AyCfcwoh3SarByZt1ttBWMzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6CMJrLgqa6FL3ud96EyM5qMOgAbWXvCD9C9/ZPzsMCPgJKIrEDVPZcrU2uq+awQryc3rq9tEX9mqtaJJvCUFGYYbsQ4pCYRgTax8j+uIaJJAblsa1ykN/QpZc7AEkCvc1rpnEY5vJWyfzcpCOoJRLFklaQ33kYA/NRo4G70oa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9099D68C7B; Wed, 19 Aug 2026 16:26:36 +0200 (CEST)
Date: Wed, 19 Aug 2026 16:26:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: use iov_iter_extract_pages() in
 ceph_msg_data_iter_next()
Message-ID: <20260819142636.GA825@lst.de>
References: <20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu> <20260819054413.GA32590@lst.de> <9d9bf5c2-008f-42ba-9c39-403ce224cc99@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9bf5c2-008f-42ba-9c39-403ce224cc99@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 05:07:05PM +0300, Tal Zussman wrote:
> I'm perfectly happy to do that. I just want the PageWriteback() gone
> and wanted to try to fix it properly rather than just delete the BUG()
> or throw in a page_folio(). But seems like "properly" in this case may
> be a deeper hole than I want to jump in to right now ;)

I'd vote for just removing it and unraveling that rest slowly.
