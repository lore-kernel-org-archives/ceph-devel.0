From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC PATCH] ceph: initialize superblock s_time_gran to 1
Date: Thu, 27 Jun 2019 15:44:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1906271543440.17148@piezo.novalocal>
References: <20190627135122.12817-1-lhenriques@suse.com> <0459c2a46200194c14b7474f55071b12fbc3d594.camel@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0459c2a46200194c14b7474f55071b12fbc3d594.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 27 Jun 2019, Jeff Layton wrote:
> On Thu, 2019-06-27 at 14:51 +0100, Luis Henriques wrote:
> > Having granularity set to 1us results in having inode timestamps with a
> > accurancy different from the fuse client (i.e. atime, ctime and mtime will
> > always end with '000').  This patch normalizes this behaviour and sets the
> > granularity to 1.
> > 
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> >  fs/ceph/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Hi!
> > 
> > As far as I could see there are no other side-effects of changing
> > s_time_gran but I'm really not sure why it was initially set to 1000 in
> > the first place so I may be missing something.
> > 
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index d57fa60dcd43..35dd75bc9cd0 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -980,7 +980,7 @@ static int ceph_set_super(struct super_block *s, void *data)
> >  	s->s_d_op = &ceph_dentry_ops;
> >  	s->s_export_op = &ceph_export_ops;
> >  
> > -	s->s_time_gran = 1000;  /* 1000 ns == 1 us */
> > +	s->s_time_gran = 1;
> >  
> >  	ret = set_anon_super(s, NULL);  /* what is that second arg for? */
> >  	if (ret != 0)
> 
> 
> Looks like it was set that way since the client code was originally
> merged. Was this an earlier limitation of ceph that is no longer
> applicable?
> 
> In any case, I see no need at all to keep this at 1000, so:

As long as the encoded on-write time value is at ns resolution, I 
agree!  No recollection of why I did this :(

Reviewed-by: Sage Weil <sage@redhat.com>
