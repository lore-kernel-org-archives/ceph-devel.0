From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: account for alignment in pages cursor
Date: Sun, 31 Mar 2013 20:35:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303312034480.12367@cobra.newdream.net>
References: <5157C2C3.8070801@inktank.com> <5157C2E9.5080807@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54345 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab3DADfj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Mar 2013 23:35:39 -0400
In-Reply-To: <5157C2E9.5080807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 31 Mar 2013, Alex Elder wrote:
> On 03/30/2013 11:59 PM, Alex Elder wrote:
> > When a cursor for a page array data message is initialized it needs
> > to determine the initial value for cursor->last_piece.  Currently it
> > just checks if length is less than a page, but that's not correct.
> > The data in the first page in the array will be offset by a page
> > offset based on the alignment recorded for the data.  (All pages
> > thereafter will be aligned at the base of the page, so there's
> > no need to account for this except for the first page.)
> > 
> > Because this was wrong, there was a case where the length of a piece
> > would be calculated as all of the residual bytes in the message and
> > that plus the page offset could exceed the length of a page.
> > 
> > So fix this case.  Make sure the sum won't wrap.
> > 
> > This resolves a third issue described in:
> >     http://tracker.ceph.com/issues/4598
> > 
> > Signed-off-by: Alex Elder <elder@inktank.com>
> 
> Whoops.  Sage has NOT reviewed this (yet).  Sorry for
> the confusion.

I have now!  Looks good.  :)

> 					-Alex
> 
> > Reviewed-by: Sage Weil <sage@inktank.com>
> > ---
> >  net/ceph/messenger.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 198b902..ee16086 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -839,9 +839,10 @@ static void ceph_msg_data_pages_cursor_init(struct
> > ceph_msg_data *data,
> >  	page_count = calc_pages_for(data->alignment, (u64)data->length);
> >  	cursor->page_offset = data->alignment & ~PAGE_MASK;
> >  	cursor->page_index = 0;
> > -	BUG_ON(page_count > (int) USHRT_MAX);
> > -	cursor->page_count = (unsigned short) page_count;
> > -	cursor->last_piece = length <= PAGE_SIZE;
> > +	BUG_ON(page_count > (int)USHRT_MAX);
> > +	cursor->page_count = (unsigned short)page_count;
> > +	BUG_ON(length > SIZE_MAX - cursor->page_offset);
> > +	cursor->last_piece = (size_t)cursor->page_offset + length <= PAGE_SIZE;
> >  }
> > 
> >  static struct page *ceph_msg_data_pages_next(struct ceph_msg_data *data,
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
