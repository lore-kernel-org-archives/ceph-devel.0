Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D4369D6F
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614303; cv=none; b=Zq+m1AoEFNguy0UX6cRwHh5TZNAtDPplGewwz2OIzh2KE0IBRJ7lHpW2kMrCOOsgqiWAyx40HXilPlp7P/bjVIXUmvS1xslyuFemBMH6Snx5eGyVx2T0V9jFWfh2eKKpVplnHWLW0imw1cVYRiRvUYRXl7Dff7H0qe86nZ/j2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614303; c=relaxed/simple;
	bh=X+SL3SCxfXjKReLDO6t/cz2Tg9ckhBXQW3tanUcnTZg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TSfYtd8W0JLs0g/fQ8DmBxX+ey509vjlAb8CR8zOJJ+6Z+Q/fcrG3FDmluj/OM9yMk1TTKL0exqEXo2Tqbh6UEEQJU+0Yh+aDdbPSnotN5TxEUmEqhGlRYJ90Gg++KpY0ZTAMsiRbKIhxUm+EdsVOOIWE6GZWEhR/kBWTjbr+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PN8LTupw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN8LTupw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781614301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f4COWRiqc1S5CKA80N1C8fgQscr8BG6DIsFW1ivm9s=;
	b=PN8LTupwfVMIVWCFIgGMpPhzq+b8GU4nr53YR/FoY0o3skfHlgw9u5J+gKtkaX1VHGBuRM
	vmzNfgcRLzDXQ+HN0YFvIjcX49GlipfZzpemGkoPotlJw6BBRFPbbeR/nzK+z8BEzwnPjS
	3eC/cGy7LXFKNt3iiiLvZq00Fkouvl4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Whce7UpKPGSqU5IuIZNo8g-1; Tue,
 16 Jun 2026 08:51:36 -0400
X-MC-Unique: Whce7UpKPGSqU5IuIZNo8g-1
X-Mimecast-MFC-AGG-ID: Whce7UpKPGSqU5IuIZNo8g_1781614293
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E88D19560B3;
	Tue, 16 Jun 2026 12:51:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D8853008B3E;
	Tue, 16 Jun 2026 12:51:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b6b19c84-7734-42ea-b2ec-9ace1f36ad08@chenxiaosong.com>
References: <b6b19c84-7734-42ea-b2ec-9ace1f36ad08@chenxiaosong.com> <20260616100821.2062304-1-dhowells@redhat.com> <20260616100821.2062304-31-dhowells@redhat.com>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 30/30] CHANGES
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2102920.1781614283.1@warthog.procyon.org.uk>
Date: Tue, 16 Jun 2026 13:51:23 +0100
Message-ID: <2102921.1781614283@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:

> Is this patch missing the subject and commit message?

No.  I got distracted and forgot to finish folding its contents down into
earlier patches.

David

