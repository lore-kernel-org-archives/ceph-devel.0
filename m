From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 04/16] libceph: define ceph_extract_encoded_string()
Date: Wed, 11 Jul 2012 10:45:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207111044050.693@cobra.newdream.net>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com> <CAC-hyiFrftSudtCUHaGwWyrzMBoAcm-uzRK4Bz7f-crO+dbfBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38731 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984Ab2GKRpl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 13:45:41 -0400
In-Reply-To: <CAC-hyiFrftSudtCUHaGwWyrzMBoAcm-uzRK4Bz7f-crO+dbfBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 11 Jul 2012, Yehuda Sadeh wrote:
> On Wed, Jul 11, 2012 at 7:01 AM, Alex Elder <elder@inktank.com> wrote:
> > This adds a new utility routine which will return a dynamically-
> > allocated buffer containing a string that has been decoded from ceph
> > over-the-wire format.  It also returns the length of the string
> > if the address of a size variable is supplied to receive it.
> >
> > For now, no gfp_flags parameter is defined (GFP_KERNEL is used) but
> > it could be easily be added if needed.
> >
> 
> I'd rather have it upfront, will help avoiding future errors.
> 
> > Signed-off-by: Alex Elder <elder@inktank.com>
> > ---
> >  include/linux/ceph/decode.h |   29 +++++++++++++++++++++++++++++
> >  1 files changed, 29 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> > index 7ead11fc..7759164 100644
> > --- a/include/linux/ceph/decode.h
> > +++ b/include/linux/ceph/decode.h
> > @@ -80,6 +80,35 @@ static inline size_t ceph_decode_string(void **p,
> > char *s, size_t size)
> >  }
> >
> >  /*
> > + * Allocate a buffer big enough to hold the wire-encoded string, and
> > + * decode the string into it.  The resulting string will always be
> > + * terminated with '\0'.  If successful, *p will be advanced
> > + * past the decoded data.  Also, if lenp is not a null pointer, the
> > + * length (not including the terminating '\0') will be recorded in
> > + * it.  Note that a zero-length string is a valid return value.
> > + *
> > + * Returns a pointer to the newly-allocated string buffer, or a
> > + * null pointer if memory could not be allocated for the result.
> > + * Neither of the arguments is updated if NULL is returned.
> > + */
> > +static inline char *ceph_extract_encoded_string(void **p, size_t *lenp)
> > +{
> > +       size_t len;
> > +       char *buf;
> > +
> > +       len = ceph_decode_string(p, NULL, 0);
> > +       buf = kmalloc(len + 1, GFP_KERNEL);
> > +       if (!buf)
> > +               return NULL;
> > +
> > +       (void) ceph_decode_string(p, buf, len + 1);
> > +       if (lenp)
> > +               *lenp = len;
> > +
> > +       return buf;
> > +}
> > +
> > +/*
> 
> We don't make an effort here to check whether encoded string buffer is
> valid. While we may be checking it somewhere up the stack, this seem
> like a generic enough function that could be naively used. Either make
> it clear that it's an internal function, or make it check p bounds.

Ditto.  The caller doesn't see the length, so it can't check that it 
doesn't walk past the end of the buffer.  We either need to pass down the 
bounds so that it can return an error, or just open code the callers (as 
we have been doing).



> 
> >   * bounds check input.
> >   */
> >  static inline int ceph_has_room(void **p, void *end, size_t n)
> > --
> > 1.7.5.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
