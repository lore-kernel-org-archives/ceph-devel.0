Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5425B09E;
	Wed, 26 Aug 2026 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719525; cv=none; b=iSy/2aRVhuqcuLcihERJ4OFrMhFyQlJzIvLXg8zpsVwjKlolOrcqSko0qq8Meq8OsJ7lhztC6L6PlMScrz15PPYZOnynGQZGdiJcjC3OO15I9KuIQV+pWeHZ5S6SNcHWGWLrahIlbHje4Z6I0B4RtyfSaXYCDQauYbGGmNqRV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719525; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQkIS2NyuyIToWa9EgoQHiaSGkWOruTPRkmapL941t07mfnnBwmHgBXG5tKn2Ii40DBIWLlRVRkx/Jl7kzt428ISYmxg1QtYC6RJhhEfZMYuRtNHIsPDuC4i/cA85bi+fU+eZFsIMYgzKfo/bxvL1UARKlOq5j/MK/ob7lZRE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6FE568AFE; Wed, 26 Aug 2026 06:45:15 +0200 (CEST)
Date: Wed, 26 Aug 2026 06:45:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libceph: remove pinning assertion in
 ceph_msg_data_iter_next()
Message-ID: <20260826044515.GA14936@lst.de>
References: <20260825-ceph-msgr-writeback-v2-1-840ef541b0c2@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ceph-msgr-writeback-v2-1-840ef541b0c2@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

