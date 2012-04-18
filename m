From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/3] ceph: fix bounds check macros ceph_decode_need and
 ceph_encode_need
Date: Wed, 18 Apr 2012 10:53:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204181052530.15730@cobra.newdream.net>
References: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
 <1323894273-13904-3-git-send-email-xi.wang@gmail.com> <4F8ECBF7.7060509@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53910 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2DRRx1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 13:53:27 -0400
In-Reply-To: <4F8ECBF7.7060509@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: Xi Wang <xi.wang@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 18 Apr 2012, Alex Elder wrote:
> On 12/14/2011 02:24 PM, Xi Wang wrote:
> > Given a large n, the bounds check (*p + n>  end) can be bypassed due to
> > pointer wraparound.  A safer check is (n>  end - *p).
> > 
> > Signed-off-by: Xi Wang<xi.wang@gmail.com>
> 
> I noticed this proposed change never got committed.
> 
> It looks good, but I don't like the name "ceph_need()".
> 
> I am planning to pull this in soon, modified like this:
> 
> static inline int ceph_need_ok(void **p, void *end, size_t n)

Would something like ceph_has_room() make more sense?

> {
>        return end >= *p && n <= end - *p;
> }
> 
> And then used like this:
> 
>                if (!likely(ceph_need_ok(p, end, n)))
> 
> If you have an objection to that, please say so soon
> (and if you have no objection, please ACK).
> 
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> 
> > ---
> >   include/linux/ceph/decode.h |    9 +++++++--
> >   1 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> > index c5b6939..ea6db7b 100644
> > --- a/include/linux/ceph/decode.h
> > +++ b/include/linux/ceph/decode.h
> > @@ -12,6 +12,11 @@
> >    *   void *end    pointer to end of buffer (last byte + 1)
> >    */
> > 
> > +static inline int ceph_need(void **p, void *end, size_t n)
> > +{
> > +	return ((end<  *p) || (n>  end - *p));
> > +}
> > +
> >   static inline u64 ceph_decode_64(void **p)
> >   {
> >   	u64 v = get_unaligned_le64(*p);
> > @@ -47,7 +52,7 @@ static inline void ceph_decode_copy(void **p, void *pv,
> > size_t n)
> >    */
> >   #define ceph_decode_need(p, end, n, bad)		\
> >   	do {						\
> > -		if (unlikely(*(p) + (n)>  (end))) 	\
> > +		if (unlikely(ceph_need(p, end, n)))	\
> >   			goto bad;			\
> >   	} while (0)
> > 
> > @@ -166,7 +171,7 @@ static inline void ceph_encode_string(void **p, void
> > *end,
> > 
> >   #define ceph_encode_need(p, end, n, bad)		\
> >   	do {						\
> > -		if (unlikely(*(p) + (n)>  (end))) 	\
> > +		if (unlikely(ceph_need(p, end, n)))	\
> >   			goto bad;			\
> >   	} while (0)
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
