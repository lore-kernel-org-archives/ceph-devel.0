From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
Date: Tue, 19 May 2020 06:43:10 -0400
Message-ID: <cc459ce1b7314919eaa506a82b9c28df6f41a169.camel@kernel.org>
References: <20200514111453.GA99187@suse.com>
         <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
         <20200514124845.GA12559@suse.com>
         <4e5bf0e3bf055e53a342b19d168f6cf441781973.camel@kernel.org>
         <CAOQ4uxhireZBRvcPQzTS8yOoO4gQt78M0ktZo-9yQ-zcaLZbow@mail.gmail.com>
         <20200515111548.GA54598@suse.com>
         <61b1f19edcc349641b5383c2ac70cbf9a15ba4bd.camel@kernel.org>
         <CAOQ4uxiWZoSj3Pjwskd_hu-ErV9096hLt13CDcW6nEEvcwDNVA@mail.gmail.com>
         <e227d42fdc91587e34bc64ac252970d39d9b4eee.camel@kernel.org>
         <CAJ4mKGbahd8CbkEauBHBX6o93jipkCVoYe9O-1rAJQJFZkqDsQ@mail.gmail.com>
         <CAOQ4uxjdu7=wXNBHZBQmtNexcG3qfu=XQov9HsRNi=os+QHAUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <fstests-owner@vger.kernel.org>
In-Reply-To: <CAOQ4uxjdu7=wXNBHZBQmtNexcG3qfu=XQov9HsRNi=os+QHAUg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: ceph-devel.vger.kernel.org

On Tue, 2020-05-19 at 07:00 +0300, Amir Goldstein wrote:
> On Tue, May 19, 2020 at 1:30 AM Gregory Farnum <gfarnum@redhat.com> wrote:
> > Maybe we resolved this conversation; I can't quite tell...
> 
> I think v2 patch wraps it up...
> 
> [...]
> 

Agreed.

> > > > Questions:
> > > > 1. Does sync() result in fully purging inodes on MDS?
> > > 
> > > I don't think so, but again, that code is not trivial to follow. I do
> > > know that the MDS keeps around a "strays directory" which contains
> > > unlinked inodes that are lazily cleaned up. My suspicion is that it's
> > > satisfying lookups out of this cache as well.
> > > 
> > > Which may be fine...the MDS is not required to be POSIX compliant after
> > > all. Only the fs drivers are.
> > 
> > I don't think this is quite that simple. Yes, the MDS is certainly
> > giving back stray inodes in response to a lookup-by-ino request. But
> > that's for a specific purpose: we need to be able to give back caps on
> > unlinked-but-open files. For NFS specifically, I don't know what the
> > rules are on NFS file handles and unlinked files, but the Ceph MDS
> > won't know when files are closed everywhere, and it translates from
> > NFS fh to Ceph inode using that lookup-by-ino functionality.
> > 
> 
> There is no protocol rule that NFS server MUST return ESTALE
> for file handle of a deleted file, but there is a rule that it MAY return
> ESTALE for deleted file. For example, on server restart and traditional
> block filesystem, there is not much choice.
> 
> So returning ESTALE when file is deleted but opened on another ceph
> client is definitely allowed by the protocol standard, the question is
> whether changing the behavior will break any existing workloads...
> 

Right -- that was sort of the point of my original question about the
xfstest. The fact that ceph wasn't returning ESTALE in this situation
didn't seem to be technically _wrong_ to me, but the xfstest treated
that as a failure. It's probably best to return ESTALE since that's the
conventional behavior, but I don't think it's necessarily required for
correct operation in general.

FWIW, if we ever implement O_TMPFILE in ceph, then we may need to
revisit this code. With that, you can do a 0->1 transition on i_nlink,
which blows some of the assumptions we're making here out of the water.

> > > > 2. Is i_nlink synchronized among nodes on deferred delete?
> > > > IWO, can inode come back from the dead on client if another node
> > > > has linked it before i_nlink 0 was observed?
> > > 
> > > No, that shouldn't happen. The caps mechanism should ensure that it
> > > can't be observed by other clients until after the change.
> > > 
> > > That said, Luis' current patch doesn't ensure we have the correct caps
> > > to check the i_nlink. We may need to add that in before we can roll with
> > > this.
> > > 
> > > > 3. Can an NFS client be "migrated" from one ceph node to another
> > > > with an open but unlinked file?
> > > > 
> > > 
> > > No. Open files in ceph are generally per-client. You can't pass around a
> > > fd (or equivalent).
> > 
> > But the NFS file handles I think do work across clients, right?
> > 
> 
> Maybe they can, but that would be like NFS server restart, so
> all bets are off w.r.t open but deleted files.
> 

They do work across clients, but a file handle is just an identifier for
an inode. That's completely orthogonal to whether the file is open.

-- 
Jeff Layton <jlayton@kernel.org>
