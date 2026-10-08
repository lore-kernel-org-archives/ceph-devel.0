Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A62F8E8F
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475218; cv=none; b=MRYvN3s1B9mUWKEOZBoNFIZtoNlJPCpAzFBVR/gWTRL/CGJ2Ngy9vPYKRxAlOZveNypUvXDJa9YJfOAvlnXehXwN5dF6YFIcA+Pa7yzFhPRZk1Nent+PXJ5Gc+trQF5cpJhfyt2Ug/il9uFnDpObk7+A7FVGRwg85CKRTOPnhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475218; c=relaxed/simple;
	bh=rHHfyKU+y9uG6X4mYuYwDWk6VJP8ahLFWyNIduWcOOk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kI3mdF929XsSiIzbb+EGGxj+po8jXnoghst4/Lz/3QboaFinJu+x578F9R1eTN/hTdBq2aTbUxbpDp5tyUtBeLQYpPZhCoPi65VhLxqTnjYSltbai8o1HoF2ASEvO/GH1p1SzQBJUJ2UfuB5ZvaJD9zwGBb/ZhhJxnQHCSA9L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W00qMsbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W00qMsbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791475216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCsUqcglH1KIjLocjMaxk5bfkL64y13HObwU0wWvIhw=;
	b=W00qMsbuzfVPomaA+NVt9xcgTS0e/WhLK8LKQU86mRr8X5BBAxaL973Cjr+TZxpEvI8BBR
	tJoOU+aWoH0r+Em4OwDcaL2NyoHLjx9TeBDPgNxDgO+325rlEsXqODhSGEUUaDgPsABRJx
	mrQyUwfUDDI+ySnm2OKtzFdFPCnfRRw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-xt2HwfwMMxebjcX32PsPnA-1; Thu,
 8 Oct 2026 16:00:13 +0000
X-MC-Unique: xt2HwfwMMxebjcX32PsPnA-1
X-Mimecast-MFC-AGG-ID: xt2HwfwMMxebjcX32PsPnA_1791475211
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB01182E6A9;
	Thu,  8 Oct 2026 16:00:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11BD21956044;
	Thu,  8 Oct 2026 16:00:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
To: Tal Zussman <tz2294@columbia.edu>
Cc: dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Zi Yan <ziy@nvidia.com>, ceph-devel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] ceph: convert writeback path to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1043694.1791475206.1@warthog.procyon.org.uk>
Date: Thu, 08 Oct 2026 17:00:06 +0100
Message-ID: <1043695.1791475206@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Tal,

Apologies for not reaching out to you before, but I keep getting diverted on
to other thing - usually by AI patch reviews.

Just to note that I have patches in the works to convert ceph to use netfslib
and thus strip out all the dealing with pages/folios as much as possible -
even getting down into the protocol and replacing the five different page
carrying types with the same structure as is at the core of netfslib (bvecq
chains) and pass the bvecq chains all the way into sendmsg() for transmission.

This also lets me remove ceph's use of the PG_private_2 flag which the MM
people would really like back.  That's then replaced - transparently inside of
netfslib - by setting a special ->private value on folios read from the
server, marking them dirty and then having writeback write them to the cache.

It's unfortunately stalled on getting some netfslib changes in, though there
may be hope for making some progress in this merge window.

If you go to my tree here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

The netfs-next[12345] branches are the prerequisite patches I'm trying to get
in at the moment, divided into five batches.

On top of that is my netfs-crypt branch that has content crypto support

And then on top of that is my ceph-iter branch.  Note that it's not fully
working as yet and I'm still testing and fixing bits of it.

If you want to push these patches first, I can always adapt my patches to take
account of them.

David

