From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: remove cryptopp support?
Date: Fri, 24 Jun 2016 11:11:54 -0400 (EDT)
Message-ID: <1400773952.5700918.1466781114675.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1606231824050.14068@piezo.us.to> <CALqRxCyxRUC8cdN91rpmZjc7POazH9R8iA62=_EOhoQ+QipjnQ@mail.gmail.com> <20160624092702.GC32427@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:43727 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbcFXPTy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 11:19:54 -0400
In-Reply-To: <20160624092702.GC32427@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I don't think I would prefer to remove the cryptopp (or libssl) build options, either.

so, -- from me.

Matt

----- Original Message -----
> From: "Marcus Watts" <mwatts@redhat.com>
> To: "Ken Dreyer" <kdreyer@redhat.com>
> Cc: "Sage Weil" <sage@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, June 24, 2016 5:27:02 AM
> Subject: Re: remove cryptopp support?
> 
> On Thu, Jun 23, 2016 at 02:23:33PM -0600, Ken Dreyer wrote:
> > I'm biased since the RPMs are built --with-nss :) In general I'm all
> > for simplifying config options and removing this.
> > 
> > - Ken
> > 
> > On Thu, Jun 23, 2016 at 12:26 PM, Sage Weil <sage@redhat.com> wrote:
> > > Right now you can build against either libnss or cryptopp for crypto
> > > support.  We always build packages with nss, mainly because it has some
> > > certifications that governments and distros care about.  I don't think
> > > anybody builds with cryptopp any more, but I may be wrong.
> > >
> > > Would anyone object if we just ripped out support for cryptopp?
> > >
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Are we supporting a "without-nss" build at all?
> I'm not so sure I like the idea of putting all our eggs in the nss basket.
> 
> There's also gnutls/gcrypt, which debian/ubuntu seem to like.
> 
> 						-Marcus Watts
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
