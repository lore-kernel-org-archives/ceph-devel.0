From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/4] Revert "ceph: fix dentry leak in splice_dentry()"
Date: Fri, 12 Oct 2018 06:56:23 -0400
Message-ID: <c43b550e85a3139a9b75be2551ab1b1b870ac7a0.camel@redhat.com>
References: <20180928094355.6049-1-zyan@redhat.com>
         <0622199f309f919edd8106281330076003c1adef.camel@redhat.com>
         <81230312-9653-4BD5-A207-2D1DC14797DC@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <81230312-9653-4BD5-A207-2D1DC14797DC@redhat.com>
Sender: stable-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idryomov@redhat.com, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 2018-10-12 at 10:39 +0800, Yan, Zheng wrote:
> > On Oct 11, 2018, at 22:49, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Fri, 2018-09-28 at 17:43 +0800, Yan, Zheng wrote:
> > > This reverts commit 8b8f53af1ed9df88a4c0fbfdf3db58f62060edf3.
> > > 
> > > splice_dentry() is used by three places. For two places, req->r_dentry
> > > is passed to splice_dentry(). In the case of error, req->r_dentry does
> > > not get updated. So splice_dentry() should not drop reference.
> > > 
> > > Cc: stable@vger.kernel.org #4.18
> > > Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> > > ---
> > > fs/ceph/inode.c | 1 -
> > > 1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > index c6bbb7aa99e4..375924b2bc86 100644
> > > --- a/fs/ceph/inode.c
> > > +++ b/fs/ceph/inode.c
> > > @@ -1140,7 +1140,6 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in)
> > > 	if (IS_ERR(realdn)) {
> > > 		pr_err("splice_dentry error %ld %p inode %p ino %llx.%llx\n",
> > > 		       PTR_ERR(realdn), dn, in, ceph_vinop(in));
> > > -		dput(dn);
> > > 		dn = realdn; /* note realdn contains the error */
> > > 		goto out;
> > > 	} else if (realdn) {
> > 
> > This might be ok, buI have some real concerns about splice_dentry and
> > its callers -- particularly ceph_fill_trace:
> > 
> > We hold a reference to dn on entry to splice_dentry. We then call
> > d_splice_alias and get back an error, and now we don't put the old
> > dentry.
> > 
> > Fine -- we have to then expect the caller to do it. Unfortunately, the
> > callers in ceph_fill_trace do this:
> > 
> >                        dn = splice_dentry(dn, in);                             
> >                        if (IS_ERR(dn)) {                                       
> >                                err = PTR_ERR(dn);                              
> >                                goto done;                                      
> >                        }                                                       
> >                        req->r_dentry = dn;  /* may have spliced */
> > 
> > The old value of dn gets clobbered once that comes back with an ERR_PTR.
> > I guess we could claim that r_dentry will still be set to the old value
> > at that point and that it would get cleaned up when it gets cleaned up. 
> > 
> > But...I see this higher up in ceph_fill_trace at the end of the
> > CEPH_MFS_OP_RENAME condition block:
> > 
> >        dn = req->r_old_dentry;  /* use old_dentry */
> > 
> > So now I'm worried about the case where the splice succeeds. ISTM that
> > "dn" can represent either r_dentry or r_old_dentry at the point where
> > splice_dentry gets called, but we only ever reset the value of r_dentry
> > there.
> > 
> > If dn == r_old_dentry at the time that splice_dentry is called, and then
> > that succeeds, we'll end up leaking the reference to r_dentry and then
> > doing an overput on r_old_dentry.
> > 
> 
> Good catch
> 
> > I think it might help to establish clear "ownership" of the dentry
> > references throughout that function. Consider zeroing out r_dentry and
> > r_old_dentry at the time that you set the local variables? That might
> > make this whole thing less fragile.
> 
> Before the function return, we need to set req->r_dentry again. This will introduce duplicated code because there are several ‘goto’ in the function. How about following change.
> 
> 
> -                       dn = req->r_old_dentry;  /* use old_dentry */
> +                       /* swap r_dentry and r_old_dentry */
> +                       req->r_dentry = req->r_old_dentry;
> +                       req->r_old_dentry = dn;
> +                       dn = req->r_dentry;
> 

Why do we need to reset r_dentry? I don't see where it gets used after
ceph_fill_trace returns, so I gather we're just resetting it to clean up
the references? Your proposed fix looks like it would fix that bug. It
will mean that the values in the req will change but maybe that's ok.

Another idea might be to just keep an extra reference to "dn", and not
reset r_dentry and r_old_dentry? It's a bit more code, but it might be a
cleaner fix, long-term.
-- 
Jeff Layton <jlayton@redhat.com>
