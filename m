From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before modifying/releasing a page
Date: Wed, 06 May 2020 15:24:32 +0100
Message-ID: <713141.1588775072@warthog.procyon.org.uk>
References: <20200506110942.GL16070@bombadil.infradead.org> <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk> <683739.1588751878@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200506110942.GL16070@bombadil.infradead.org>
Content-ID: <713140.1588775072.1@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Won't that screw up ITER_MAPPING?  Does that mean that ITER_MAPPING isn't
> > viable?
> 
> Can you remind me why ITER_MAPPING needs:
> 
> "The caller must guarantee that the pages are all present and they must be
> locked using PG_locked, PG_writeback or PG_fscache to prevent them from
> going away or being migrated whilst they're being accessed."
> 
> An elevated refcount prevents migration, and it also prevents the pages
> from being freed.  It doesn't prevent them from being truncated out of
> the file, but it does ensure the pages aren't reallocated.

ITER_MAPPING relies on the mapping to maintain the pointers to the pages so
that it can find them rather than being like ITER_BVEC where there's a
separate list.

Truncate removes the pages from the mapping - at which point ITER_MAPPING can
no longer find them.

David
