From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before modifying/releasing a page
Date: Fri, 08 May 2020 15:39:48 +0100
Message-ID: <1040571.1588948788@warthog.procyon.org.uk>
References: <713141.1588775072@warthog.procyon.org.uk> <20200506110942.GL16070@bombadil.infradead.org> <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk> <683739.1588751878@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <713141.1588775072@warthog.procyon.org.uk>
Content-ID: <1040570.1588948788.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> ITER_MAPPING relies on the mapping to maintain the pointers to the pages=
 so
> that it can find them rather than being like ITER_BVEC where there's a
> separate list.
> =

> Truncate removes the pages from the mapping - at which point ITER_MAPPIN=
G can
> no longer find them.

It looks like ITER_MAPPING is fine with truncate, provided the invalidatio=
n
waits for the iterator to complete first:

	int truncate_inode_page(struct address_space *mapping, struct page *page)
	{
		VM_BUG_ON_PAGE(PageTail(page), page);

		if (page->mapping !=3D mapping)
			return -EIO;

		truncate_cleanup_page(mapping, page);
		delete_from_page_cache(page);
		return 0;
	}

In which case, ->invalidatepage() needs to wait for PG_fscache.

Similarly, it looks like ->releasepage() is fine, provided it waits for
PG_fscache also.

If I have to use ITER_BVEC, what's the advisability of using vmalloc() to
allocate the bio_vec array for a transient op?  Such an array can referenc=
e up
to 1MiB on a 64-bit machine with 4KiB non-compound pages if it only alloca=
tes
up to a single page.  I'm wondering what the teardown cost is, though, if =
all
the corresponding PTEs have to be erased from all CPUs.

David
