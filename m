From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] ceph: check i_nlink while converting a file handle to
 dentry
Date: Thu, 18 May 2017 17:48:05 +0100
Message-ID: <20170518164805.jgvxvvvseurrur7e@hermes.olymp>
References: <20170517112107.31025-1-lhenriques@suse.com>
 <DEB2EE75-52B1-4C4D-9F05-E0458CB10FB3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39195 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932196AbdERQsJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 May 2017 12:48:09 -0400
Content-Disposition: inline
In-Reply-To: <DEB2EE75-52B1-4C4D-9F05-E0458CB10FB3@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, May 18, 2017 at 09:36:44PM +0800, Yan, Zheng wrote:
> 
> > On 17 May 2017, at 19:21, Luis Henriques <lhenriques@suse.com> wrote:
> > 
> > Converting a file handle to a dentry can be done call after the inode
> > unlink.  This means that __fh_to_dentry() requires an extra check to
> > verify the number of links is not 0.
> > 
> > The issue can be easily reproduced using xfstest generic/426, which does
> > something like:
> > 
> >  name_to_handle_at(&fh)
> >  echo 3 > /proc/sys/vm/drop_caches
> >  unlink()
> >  open_by_handle_at(&fh)
> > 
> > The call to open_by_handle_at() should fail, as the file doesn't exist
> > anymore.
> > 
> > Cc: stable@vger.kernel.org
> > Link: http://tracker.ceph.com/issues/19958
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> > fs/ceph/export.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> > index e8f11fa565c5..7df550c13d7f 100644
> > --- a/fs/ceph/export.c
> > +++ b/fs/ceph/export.c
> > @@ -91,6 +91,10 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
> > 		ceph_mdsc_put_request(req);
> > 		if (!inode)
> > 			return ERR_PTR(-ESTALE);
> > +		if (inode->i_nlink == 0) {
> > +			iput(inode);
> > +			return ERR_PTR(-ESTALE);
> > +		}
> > 	}
> 
> maybe we should do this check in MDS

Thank you for your review.  Are you suggesting to do this check *only* in
the MDS?  I guess that's probably a good thing to do too, but don't you
think it's a good idea to keep it on the client side as well?

Cheers,
--
Luís
