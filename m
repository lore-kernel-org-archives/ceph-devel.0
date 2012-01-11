From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH]: set up rbd snapshot handling
Date: Wed, 11 Jan 2012 05:00:04 -0500
Message-ID: <20120111100004.GA30381@infradead.org>
References: <CAF3hT9Cu0BZQfrgCpBRRaPHyfSy3V-A=jJLe3qGr4UoFMcniOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:38096
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757366Ab2AKKAK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Jan 2012 05:00:10 -0500
Content-Disposition: inline
In-Reply-To: <CAF3hT9Cu0BZQfrgCpBRRaPHyfSy3V-A=jJLe3qGr4UoFMcniOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

> +static int qemu_rbd_snap_remove(BlockDriverState *bs,
> +                                const char *snapshot_name)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    int r;
> +
> +    r = rbd_snap_remove(s->image, snapshot_name);

> +    r = rbd_snap_rollback(s->image, snapshot_name);

Have these functions been available since day 1 in librbd or should they
get a version checks like the cache flush call?

