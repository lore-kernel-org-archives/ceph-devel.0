From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4 3/3] ceph: don't NULL terminate virtual xattrs
Date: Tue, 25 Jun 2019 10:49:49 -0400
Message-ID: <611d56126960b1cc1a97e7ea81739a944edd110c.camel@kernel.org>
References: <20190624162726.17413-1-jlayton@kernel.org>
         <20190624162726.17413-4-jlayton@kernel.org>
         <CAOi1vP_G9ybNs_QEn34cPvovAa=JB7G9F3FGy33QPH4yfST-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_G9ybNs_QEn34cPvovAa=JB7G9F3FGy33QPH4yfST-iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Tue, 2019-06-25 at 16:35 +0200, Ilya Dryomov wrote:
> On Mon, Jun 24, 2019 at 6:27 PM Jeff Layton <jlayton@kernel.org> wrote:
> > The convention with xattrs is to not store the termination with string
> > data, given that it returns the length. This is how setfattr/getfattr
> > operate.
> > 
> > Most of ceph's virtual xattr routines use snprintf to plop the string
> > directly into the destination buffer, but snprintf always NULL
> > terminates the string. This means that if we send the kernel a buffer
> > that is the exact length needed to hold the string, it'll end up
> > truncated.
> > 
> > Add a ceph_fmt_xattr helper function to format the string into an
> > on-stack buffer that is should always be large enough to hold the whole
> > thing and then memcpy the result into the destination buffer. If it does
> > turn out that the formatted string won't fit in the on-stack buffer,
> > then return -E2BIG and do a WARN_ONCE().
> > 
> > Change over most of the virtual xattr routines to use the new helper. A
> > couple of the xattrs are sourced from strings however, and it's
> > difficult to know how long they'll be. Just have those memcpy the result
> > in place after verifying the length.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/xattr.c | 84 ++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 59 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 9b77dca0b786..37b458a9af3a 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -109,22 +109,49 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
> >         return ret;
> >  }
> > 
> > +/*
> > + * The convention with strings in xattrs is that they should not be NULL
> > + * terminated, since we're returning the length with them. snprintf always
> > + * NULL terminates however, so call it on a temporary buffer and then memcpy
> > + * the result into place.
> > + */
> > +static int ceph_fmt_xattr(char *val, size_t size, const char *fmt, ...)
> > +{
> > +       int ret;
> > +       va_list args;
> > +       char buf[96]; /* NB: reevaluate size if new vxattrs are added */
> > +
> > +       va_start(args, fmt);
> > +       ret = vsnprintf(buf, size ? sizeof(buf) : 0, fmt, args);
> > +       va_end(args);
> > +
> > +       /* Sanity check */
> > +       if (size && ret + 1 > sizeof(buf)) {
> > +               WARN_ONCE(true, "Returned length too big (%d)", ret);
> > +               return -E2BIG;
> > +       }
> > +
> > +       if (ret <= size)
> > +               memcpy(val, buf, ret);
> > +       return ret;
> > +}
> 
> Nit: perhaps check size at the top and bail early instead of checking
> it at every step?
> 
> Thanks,
> 
>                 Ilya

We don't know how much space we'll need until vsnprintf is called. Note
that both of these checks involve "ret", and that isn't set until
vsnprintf returns.
-- 
Jeff Layton <jlayton@kernel.org>
