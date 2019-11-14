From: David Howells <dhowells@redhat.com>
Subject: How to avoid using bmap in cachefiles -- FS-Cache/CacheFiles rewrite
Date: Thu, 14 Nov 2019 13:40:38 +0000
Message-ID: <30127.1573738838@warthog.procyon.org.uk>
References: <24942.1573667720@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24942.1573667720@warthog.procyon.org.uk>
Content-ID: <30126.1573738838.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, v9fs-developer@lists.sourceforge.net, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-cachefs@redhat.com, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Christoph,

I've been rewriting cachefiles in the kernel and it now uses kiocbs to do
async direct I/O to/from the cache files - which seems to make a 40-48% spe=
ed
improvement.

However, I've replaced the use of bmap internally to detect whether data is
present or not - which is dodgy for a number of reasons, not least that
extent-based filesystems might insert or remove blocks of zeros to shape th=
e
extents better, thereby rendering the metadata information useless for
cachefiles.

But using a separate map has a couple of problems:

 (1) The map is metadata kept outside of the filesystem journal, so coheren=
cy
     management is necessary

 (2) The map gets hard to manage for very large files (I'm using 256KiB
     granules, so 1 bit per granule means a 512-byte map block can span 1Gi=
B)
     and xattrs can be of limited capacity.

I seem to remember you said something along the lines of it being possible =
to
tell the filesystem not to do discarding and insertion of blocks of zeros. =
 Is
there a generic way to do that?

Also, is it possible to make it so that I can tell an O_DIRECT read to fail
partially or, better, completely if there's no data to be had in part of th=
e
range?  I can see DIO_SKIP_HOLES, but that only seems to affect writes

Thanks,
David
