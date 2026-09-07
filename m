Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04E40DB3B;
	Mon,  7 Sep 2026 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764045; cv=none; b=VvlPrnUzqsHW6UsPj96IknwGpNlJJ682uImKHPxNWITgWCE2lLwZ5qetzty0JHUu53yYtBaiVjddWte4NxJBM1YpiZk2zz7rULhIOID3eBfPw6uhlmNJ9UAY667yXwIdDxkfzvY7HIiu2ojbvnlsp5te6uxaxwSLGhYE+5IiqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764045; c=relaxed/simple;
	bh=eGpIQiAybFsbuhuz4aT6Fz/ja1HX5cMd30MixwmNf5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1arLYY31heWIphBy//IKdt0ov18S5KHt/O8ogctfV2kWtxCHIFz4E2g2Anpv3XyHZp7nts0+1XZIgC9VbrR3tjarpotRaBAQS0nXlx4tpDRGECwQDGVp3JRv4A0F7REZ2zllJ0TWDGOlx333dUKmR0YMz7Z0wbGuz8Vsf13DmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE6D768D09; Mon,  7 Sep 2026 08:53:58 +0200 (CEST)
Date: Mon, 7 Sep 2026 08:53:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@lst.de>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: use iov_iter_extract_bvecs() for direct I/O
Message-ID: <20260907065358.GA700@lst.de>
References: <20260905-b4-ceph-extract-bvecs-v1-1-b1cf2c92b671@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905-b4-ceph-extract-bvecs-v1-1-b1cf2c92b671@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks good from the iov_iter_extract_bvecs usage point of
view. I don't really feel qualified to review this from the ceph
POV, though.

