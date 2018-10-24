From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 1/4] Revert "ceph: fix dentry leak in splice_dentry()"
Date: Wed, 24 Oct 2018 11:47:25 +0800
Message-ID: <CAAM7YA=wNqoZbGhHG-Dhb+m9md+haveRXBvpXz2eWcdWBLfOaQ@mail.gmail.com>
References: <20180928094355.6049-1-zyan@redhat.com> <0622199f309f919edd8106281330076003c1adef.camel@redhat.com>
 <81230312-9653-4BD5-A207-2D1DC14797DC@redhat.com> <c43b550e85a3139a9b75be2551ab1b1b870ac7a0.camel@redhat.com>
 <52E534BE-7431-41FC-BEC9-C687E09697B8@redhat.com> <7a464618d92a1f588dace811977910e75809c581.camel@redhat.com>
 <EB2EBE7E-92A8-4683-8976-6C5A726B1541@redhat.com> <3b39857038179aa348d0a32e65c796fa9fa04dbe.camel@redhat.com>
 <CAOi1vP9XDHB3YEmoFMAHM7kOhbc9cFPAYcoT2qRsOqP38ojwVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9XDHB3YEmoFMAHM7kOhbc9cFPAYcoT2qRsOqP38ojwVg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>, Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, idryomov@redhat.com, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 23, 2018 at 10:36 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 3:04 PM Jeff Layton <jlayton@redhat.com> wrote:
> >
> > On Mon, 2018-10-15 at 20:37 +0800, Yan, Zheng wrote:
> > > > On Oct 15, 2018, at 19:29, Jeff Layton <jlayton@redhat.com> wrote:
> > > >
> > > > On Mon, 2018-10-15 at 09:58 +0800, Yan, Zheng wrote:
> > > > > > On Oct 12, 2018, at 18:56, Jeff Layton <jlayton@redhat.com> wro=
te:
> > > > > >
> > > > > > On Fri, 2018-10-12 at 10:39 +0800, Yan, Zheng wrote:
> > > > > > > > On Oct 11, 2018, at 22:49, Jeff Layton <jlayton@redhat.com>=
 wrote:
> > > > > > > >
> > > > > > > > On Fri, 2018-09-28 at 17:43 +0800, Yan, Zheng wrote:
> > > > > > > > > This reverts commit 8b8f53af1ed9df88a4c0fbfdf3db58f62060e=
df3.
> > > > > > > > >
> > > > > > > > > splice_dentry() is used by three places. For two places, =
req->r_dentry
> > > > > > > > > is passed to splice_dentry(). In the case of error, req->=
r_dentry does
> > > > > > > > > not get updated. So splice_dentry() should not drop refer=
ence.
> > > > > > > > >
> > > > > > > > > Cc: stable@vger.kernel.org #4.18
> > > > > > > > > Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> > > > > > > > > ---
> > > > > > > > > fs/ceph/inode.c | 1 -
> > > > > > > > > 1 file changed, 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > > > > > > index c6bbb7aa99e4..375924b2bc86 100644
> > > > > > > > > --- a/fs/ceph/inode.c
> > > > > > > > > +++ b/fs/ceph/inode.c
> > > > > > > > > @@ -1140,7 +1140,6 @@ static struct dentry *splice_dentry=
(struct dentry *dn, struct inode *in)
> > > > > > > > >   if (IS_ERR(realdn)) {
> > > > > > > > >           pr_err("splice_dentry error %ld %p inode %p ino=
 %llx.%llx\n",
> > > > > > > > >                  PTR_ERR(realdn), dn, in, ceph_vinop(in))=
;
> > > > > > > > > -         dput(dn);
> > > > > > > > >           dn =3D realdn; /* note realdn contains the erro=
r */
> > > > > > > > >           goto out;
> > > > > > > > >   } else if (realdn) {
> > > > > > > >
> > > > > > > > This might be ok, buI have some real concerns about splice_=
dentry and
> > > > > > > > its callers -- particularly ceph_fill_trace:
> > > > > > > >
> > > > > > > > We hold a reference to dn on entry to splice_dentry. We the=
n call
> > > > > > > > d_splice_alias and get back an error, and now we don't put =
the old
> > > > > > > > dentry.
> > > > > > > >
> > > > > > > > Fine -- we have to then expect the caller to do it. Unfortu=
nately, the
> > > > > > > > callers in ceph_fill_trace do this:
> > > > > > > >
> > > > > > > >                      dn =3D splice_dentry(dn, in);
> > > > > > > >                      if (IS_ERR(dn)) {
> > > > > > > >                              err =3D PTR_ERR(dn);
> > > > > > > >                              goto done;
> > > > > > > >                      }
> > > > > > > >                      req->r_dentry =3D dn;  /* may have spl=
iced */
> > > > > > > >
> > > > > > > > The old value of dn gets clobbered once that comes back wit=
h an ERR_PTR.
> > > > > > > > I guess we could claim that r_dentry will still be set to t=
he old value
> > > > > > > > at that point and that it would get cleaned up when it gets=
 cleaned up.
> > > > > > > >
> > > > > > > > But...I see this higher up in ceph_fill_trace at the end of=
 the
> > > > > > > > CEPH_MFS_OP_RENAME condition block:
> > > > > > > >
> > > > > > > >      dn =3D req->r_old_dentry;  /* use old_dentry */
> > > > > > > >
> > > > > > > > So now I'm worried about the case where the splice succeeds=
. ISTM that
> > > > > > > > "dn" can represent either r_dentry or r_old_dentry at the p=
oint where
> > > > > > > > splice_dentry gets called, but we only ever reset the value=
 of r_dentry
> > > > > > > > there.
> > > > > > > >
> > > > > > > > If dn =3D=3D r_old_dentry at the time that splice_dentry is=
 called, and then
> > > > > > > > that succeeds, we'll end up leaking the reference to r_dent=
ry and then
> > > > > > > > doing an overput on r_old_dentry.
> > > > > > > >
> > > > > > >
> > > > > > > Good catch
> > > > > > >
> > > > > > > > I think it might help to establish clear "ownership" of the=
 dentry
> > > > > > > > references throughout that function. Consider zeroing out r=
_dentry and
> > > > > > > > r_old_dentry at the time that you set the local variables? =
That might
> > > > > > > > make this whole thing less fragile.
> > > > > > >
> > > > > > > Before the function return, we need to set req->r_dentry agai=
n. This will introduce duplicated code because there are several =E2=80=98g=
oto=E2=80=99 in the function. How about following change.
> > > > > > >
> > > > > > >
> > > > > > > -                       dn =3D req->r_old_dentry;  /* use old=
_dentry */
> > > > > > > +                       /* swap r_dentry and r_old_dentry */
> > > > > > > +                       req->r_dentry =3D req->r_old_dentry;
> > > > > > > +                       req->r_old_dentry =3D dn;
> > > > > > > +                       dn =3D req->r_dentry;
> > > > > > >
> > > > > >
> > > > > > Why do we need to reset r_dentry? I don't see where it gets use=
d after
> > > > > > ceph_fill_trace returns, so I gather we're just resetting it to=
 clean up
> > > > > > the references? Your proposed fix looks like it would fix that =
bug. It
> > > > > > will mean that the values in the req will change but maybe that=
's ok.
> > > > > >
> > > > >
> > > > > It=E2=80=99s used by ceph_finish_lookup
> > > > >
> > > >
> > > > In that case, it might be bad idea to overwrite the value of r_dent=
ry
> > > > with the r_old_dentry pointer?
> > >
> > > ceph_finish_lookup() is not used in the rename case ;)
> > >
> > >
> >
> > Ok, but still...I worry about this sort of special-casing, as it can
> > lead to people making incorrect assumptions later. I think it would be
> > best to just take a dentry ref for "dn" and just put it before it goes
> > out of scope.
> >
> > At the very least, if you are going to override r_dentry like this,
> > please add a comment explaining why it's safe to do this in the rename =
case.
>
> Hi Zheng,
>
> What is the status here?  This patch has missed 4.19, do you have a new
> version pending somewhere?
>
> Thanks,

I'd like to get this patch and patch "ceph: fix dentry leak in
ceph_readdir_prepopulate" upstreamed. (use other patch to do cleanup)

Regards
Yan, Zheng

>
>                 Ilya
