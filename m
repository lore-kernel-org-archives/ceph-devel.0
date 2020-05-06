From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before modifying/releasing a page
Date: Wed, 06 May 2020 08:57:58 +0100
Message-ID: <683739.1588751878@warthog.procyon.org.uk>
References: <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200505115946.GF16070@bombadil.infradead.org>
Content-ID: <683738.1588751878.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > PG_fscache is going to be used to indicate that a page is being written to
> > the cache, and that the page should not be modified or released until it's
> > finished.
> > 
> > Make afs_invalidatepage() and afs_releasepage() wait for it.
> 
> Well, why?  Keeping a refcount on the page will prevent it from going
> away while it's being written to storage.  And the fact that it's
> being written to this cache is no reason to delay the truncate of a file
> (is it?)

Won't that screw up ITER_MAPPING?  Does that mean that ITER_MAPPING isn't
viable?

David
