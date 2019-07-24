From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH] ceph: fix directories inode i_blkbits initialization
Date: Wed, 24 Jul 2019 07:50:11 -0400
Message-ID: <49ef4b704f7925c584a2bab6650648ba456b5717.camel@kernel.org>
References: <20190723155020.17338-1-lhenriques@suse.com>
         <c657b0d65acd5e8bc9d5d726d68e2ad1fff38b51.camel@kernel.org>
         <87o91k61sr.fsf@suse.com> <874l3b694l.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874l3b694l.fsf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 2019-07-24 at 11:04 +0100, Luis Henriques wrote:
> Luis Henriques <lhenriques@suse.com> writes:
> 
> > "Jeff Layton" <jlayton@kernel.org> writes:
> > 
> > > On Tue, 2019-07-23 at 16:50 +0100, Luis Henriques wrote:
> > > > When filling an inode with info from the MDS, i_blkbits is being
> > > > initialized using fl_stripe_unit, which contains the stripe unit in
> > > > bytes.  Unfortunately, this doesn't make sense for directories as they
> > > > have fl_stripe_unit set to '0'.  This means that i_blkbits will be set
> > > > to 0xff, causing an UBSAN undefined behaviour in i_blocksize():
> > > > 
> > > >   UBSAN: Undefined behaviour in ./include/linux/fs.h:731:12
> > > >   shift exponent 255 is too large for 32-bit type 'int'
> > > > 
> > > > Fix this by initializing i_blkbits to CEPH_BLOCK_SHIFT if fl_stripe_unit
> > > > is zero.
> > > > 
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > > ---
> > > >  fs/ceph/inode.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > Hi Jeff,
> > > > 
> > > > To be honest, I'm not sure CEPH_BLOCK_SHIFT is the right value to use
> > > > here, but for sure the one currently being used isn't correct if the
> > > > inode is a directory.  Using stripe units seems to be a bug that has
> > > > been there since the beginning, but it definitely became bigger problem
> > > > after commit 69448867abcb ("fs: shave 8 bytes off of struct inode").
> > > > 
> > > > This fix could also be moved into the 'switch' statement later in that
> > > > function, in the S_IFDIR case, similar to commit 5ba72e607cdb ("ceph:
> > > > set special inode's blocksize to page size").  Let me know which version
> > > > you would prefer.
> > > > 
> > > 
> > > What happens with (e.g.) named pipes or symlinks? Do those inodes also
> > > get this bogus value? Assuming that they do, I'd probably prefer this
> > > patch since it'd fix things for all inode types, not just directories.
> > 
> > I tested symlinks and they seem to be handled correctly (i.e. the stripe
> > units seems to be the same as the target file).  Regarding pipes, I
> > didn't test them, but from the code it should be set to PAGE_SHIFT (see
> > the above mentioned commit 5ba72e607cdb).
> 
> Ok, after looking closer at the other inode types and running a few
> tests with extra debug code, it all seems to be sane -- only directories
> (root dir is an exception) will cause problems with i_blkbits being set
> to a bogus value.  So, I'm sticking with my original RFC patch approach,
> which should be easy to apply to stable kernels.
> 
> Cheers,

Sounds good. I'll just plan to merge your RFC patch, after I run some
more tests on it.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
