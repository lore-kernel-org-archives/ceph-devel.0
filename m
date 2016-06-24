From: Marcus Watts <mwatts@redhat.com>
Subject: Re: remove cryptopp support?
Date: Fri, 24 Jun 2016 05:27:02 -0400
Message-ID: <20160624092702.GC32427@degu.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1606231824050.14068@piezo.us.to>
 <CALqRxCyxRUC8cdN91rpmZjc7POazH9R8iA62=_EOhoQ+QipjnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbcFXJ1F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jun 2016 05:27:05 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29CD03F734
	for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2016 09:27:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALqRxCyxRUC8cdN91rpmZjc7POazH9R8iA62=_EOhoQ+QipjnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 23, 2016 at 02:23:33PM -0600, Ken Dreyer wrote:
> I'm biased since the RPMs are built --with-nss :) In general I'm all
> for simplifying config options and removing this.
> 
> - Ken
> 
> On Thu, Jun 23, 2016 at 12:26 PM, Sage Weil <sage@redhat.com> wrote:
> > Right now you can build against either libnss or cryptopp for crypto
> > support.  We always build packages with nss, mainly because it has some
> > certifications that governments and distros care about.  I don't think
> > anybody builds with cryptopp any more, but I may be wrong.
> >
> > Would anyone object if we just ripped out support for cryptopp?
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Are we supporting a "without-nss" build at all?
I'm not so sure I like the idea of putting all our eggs in the nss basket.

There's also gnutls/gcrypt, which debian/ubuntu seem to like.

						-Marcus Watts
