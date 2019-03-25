From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: avoid clang -Wuninitialized warning
Date: Mon, 25 Mar 2019 12:11:34 +0100
Message-ID: <CAOi1vP9GdfiT5WffcdRN=dLYpW8dwocO8sHLw_S0FphiJjPvbQ@mail.gmail.com>
References: <20190322143643.1317312-1-arnd@arndb.de> <CAOi1vP9scH+DECa1udToEvtYMRTZ1-VMuVajAh8uwpxzuMq0RA@mail.gmail.com>
 <CAK8P3a2mZ-zyAMrR2zesAUoLO0BiDcmr6VnJzuJb=PFSHj4PWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2mZ-zyAMrR2zesAUoLO0BiDcmr6VnJzuJb=PFSHj4PWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 22, 2019 at 5:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 22, 2019 at 5:33 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2019 at 3:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > > index 4ba967d65cf9..cbcc3baf3807 100644
> > > --- a/drivers/block/rbd.c
> > > +++ b/drivers/block/rbd.c
> > > @@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
> > >                                                       &obj_req->bvec_pos);
> > >                         break;
> > >                 default:
> > > -                       rbd_assert(0);
> > > +                       BUG();
> > >                 }
> > >         } else {
> > >                 ret = rbd_img_fill_from_bvecs(child_img_req,
> >
> > Hi Arnd,
> >
> > You did a couple of these last year in commit c6244b3b2377 ("rbd: avoid
> > Wreturn-type warnings").
>
> Ah, I had completely forgotten about that. Different bug and different
> compiler, but same solution ;-)
>
> >  Let's change all of those default cases to BUG
> > in one go.  Do you want to do that or should I?
>
> I've prepared another patch now and sent it out, please
> apply it on top. I'd like this one-line patch to stay separate though
> since it captures the warning message and may need to
> be backported to stable kernels later.

Applied.

Thanks,

                Ilya
