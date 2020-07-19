From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/32] iov_iter: Add ITER_MAPPING
Date: Sun, 19 Jul 2020 10:51:51 +0100
Message-ID: <3418.1595152311@warthog.procyon.org.uk>
References: <20200719014436.GG2786714@ZenIV.linux.org.uk> <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk> <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbgGSJwD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jul 2020 05:52:03 -0400
In-Reply-To: <20200719014436.GG2786714@ZenIV.linux.org.uk>
Content-ID: <3417.1595152311.1@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> My main problem here is that your iterate_mapping() assumes that STEP is
> safe under rcu_read_lock(), with no visible mentioning of that fact.

Yeah, that's probably the biggest objection to this.

> Note, BTW, that iov_iter_for_each_range() quietly calls user-supplied
> callback in such context.

And calls kmap(), but should probably use kmap_atomic().  git grep doesn't
show any users of this, so can it be removed?

> Incidentally, do you ever have different steps for bvec and mapping?

Yes:

	csum_and_copy_from_iter_full()
	iov_iter_npages()
	iov_iter_get_pages()
	iov_iter_get_pages_alloc()

But I've tried to use the internal representation struct for bvec where I can
rather than inventing a new one.

David
