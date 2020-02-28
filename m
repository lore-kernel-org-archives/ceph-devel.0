From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: libceph: follow redirect replies from osds
Date: Fri, 28 Feb 2020 15:13:30 +0100
Message-ID: <CAOi1vP8wYvmngMCig3nJg45J93D2Ah=m3J91YpgRZ9hhscLe6w@mail.gmail.com>
References: <6ea7e486-a3f3-7def-1f88-2e645e3b9780@canonical.com> <6567c8fa690d9f9a0682ee22e528fcd5e3b51212.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6567c8fa690d9f9a0682ee22e528fcd5e3b51212.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Colin Ian King <colin.king@canonical.com>, Sage Weil <sage@redhat.co>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Feb 28, 2020 at 3:01 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-02-28 at 12:46 +0000, Colin Ian King wrote:
> > Hi,
> >
> > Static analysis with Coverity has detected a potential issue in the
> > following commit in function ceph_redirect_decode():
> >
> > commit 205ee1187a671c3b067d7f1e974903b44036f270
> > Author: Ilya Dryomov <ilya.dryomov@inktank.com>
> > Date:   Mon Jan 27 17:40:20 2014 +0200
> >
> >     libceph: follow redirect replies from osds
> >
> > The issue is as follows:
> >
> >
> > 3486        len = ceph_decode_32(p);
> >
> > Unused value (UNUSED_VALUE)
> > assigned_pointer: Assigning value from len to *p here, but that stored
> > value is overwritten before it can be used.
> >
> > 3487        *p += len; /* skip osd_instructions */
> > 3488
> > 3489        /* skip the rest */
> >
> > value_overwrite: Overwriting previous write to *p with value from
> > struct_end.
> >
> > 3490        *p = struct_end;
> >
> > The *p assignment in line 3487 is effectively being overwritten by the
> > *p assignment in 3490.  Maybe the following is correct:
> >
> >         len = ceph_decode_32(p);
> > -       p += len; /* skip osd_instructions */
> > +       struct_end = *p + len;  /* skip osd_instructions */
> >
> >         /* skip the rest */
> >         *p = struct_end;
> >
> > I'm not familiar with the ceph structure here, so I'm not sure what the
> > correct fix would be.
> >
>
> Probably something like this? (untested, of course)
>
> ----------------------
>
> [PATCH] libceph: fix up Coverity warning in ceph_redirect_decode
>
> We're going to skip to the end of the msg after checking the
> object_name anyway, so there is no need to separately decode
> the osd instructions that follow it.
>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/ceph/osd_client.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 8ff2856e2d52..51810db4130a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -3483,9 +3483,6 @@ static int ceph_redirect_decode(void **p, void
> *end,
>                 goto e_inval;
>         }
>
> -       len = ceph_decode_32(p);
> -       *p += len; /* skip osd_instructions */
> -
>         /* skip the rest */
>         *p = struct_end;
>  out:

Yeah, I have had the same patch in a local branch here since last year:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2092861.html

I'll make sure to push it out this time ;)

Thanks,

                Ilya
