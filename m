From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] rbd: work around -Wuninitialized warning
Date: Wed, 8 Jan 2020 17:05:25 +0100
Message-ID: <CAK8P3a0qb3fE1D4o1wYMVVets8CtbTpMRg1hUJF1wW+oC1GJjg@mail.gmail.com>
References: <20200107210256.2426176-1-arnd@arndb.de> <CAOi1vP_j1Mhdev5yGqxWVyfCvFMtmFzGw+34TdsJiQ53vWOQpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_j1Mhdev5yGqxWVyfCvFMtmFzGw+34TdsJiQ53vWOQpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>, Oleksandr Natalenko <oleksandr@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jason Dillaman <dillaman@redhat.com>, David Howells <dhowells@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 8, 2020 at 4:31 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Tue, Jan 7, 2020 at 10:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > gcc -O3 warns about a dummy variable that is passed
> > down into rbd_img_fill_nodata without being initialized:
> >
> > drivers/block/rbd.c: In function 'rbd_img_fill_nodata':
> > drivers/block/rbd.c:2573:13: error: 'dummy' is used uninitialized in this function [-Werror=uninitialized]
> >   fctx->iter = *fctx->pos;
> >
> > Since this is a dummy, I assume the warning is harmless, but
> > it's better to initialize it anyway and avoid the warning.
> >
> > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/block/rbd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 29be02838b67..070edc5983df 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -2664,7 +2664,7 @@ static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
> >                                u64 off, u64 len)
> >  {
> >         struct ceph_file_extent ex = { off, len };
> > -       union rbd_img_fill_iter dummy;
> > +       union rbd_img_fill_iter dummy = {};
> >         struct rbd_img_fill_ctx fctx = {
> >                 .pos_type = OBJ_REQUEST_NODATA,
> >                 .pos = &dummy,
>
> Applied, but slightly confused.  Wasn't selecting -O3/s/etc supposed to
> automatically disable -Wmaybe-uninitialized via Kconfig?

Oh, that's right. I have a couple of patches in my randconfig tree that
completely rework the way that the warning options are handled and
that accidentally ignored CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED,
so it's won't actually happen on linux-next right now, just on my kernel.

However, given that -O3 did not actually introduce too many false
positives here but did find some actual uninitialized variables, we should
probably have it turned on anyway.

A lot of these false positives seem to happen whenever gcc can partially
understand how a variable is used, but not enough to see that it's ok.
With higher optimization levels, this happens less often than with the
lower levels as it inlines more aggressively and correctly determines
uses to be safe that were false-positives earlier.

I'm fairly sure that the output at -Os still won't be helpful as that would
mostly show up cases that -O2 has found to be safe rather than those
that -O2 decided not to warn about because of lack of information.

      Arnd
