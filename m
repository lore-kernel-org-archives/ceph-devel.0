From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] cls_rbd ops on rbd_id.$name objects in EC pool
Date: Fri, 12 Feb 2016 07:19:37 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602120702080.4107@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com> <1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com> <CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com> <alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
 <0bc701d1604f$8f21e0a0$ad65a1e0$@fisk.me.uk> <5848cd48.9Ro.9Gf.h0.1onaHAyHUe@mailjet.com> <549809462.21912115.1455221387486.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1602111557000.28396@cpach.fuggernut.com> <dbf6eb9a.9Ro.9Gf.cs.1lNjEIPmE9@mailjet.com>
 <alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com> <CAANLjFovUm6Lpb6WKQXoKg9WX_pjc_-hOsL12NnrsJB__y0weQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-835748111-1455279580=:4107"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38536 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcBLMTS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Feb 2016 07:19:18 -0500
In-Reply-To: <CAANLjFovUm6Lpb6WKQXoKg9WX_pjc_-hOsL12NnrsJB__y0weQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Nick Fisk <nick@fisk.me.uk>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-835748111-1455279580=:4107
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Feb 2016, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Is this only a problem with EC base tiers or would replicated base
> tiers see this too?

In general proxying to the base tier will work just fine if its 
replicated, so this is mostly an EC-only issue.  The exception to that is 
Jason's commit I mentioned earlier that ensures the locking happens in the 
cache tier.

This was broken while fixing an op reordering issue a few months back, and 
I believe that fix was backported, so we'll need to do this one as well 
once it's reviewed and tested.

Thanks, Nick, for figuring out how to reproduce it!

sage


> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> 
> 
> On Thu, Feb 11, 2016 at 6:09 PM, Sage Weil  wrote:
> > On Thu, 11 Feb 2016, Nick Fisk wrote:
> >> That’s a relief, I was sensing a major case of face palm occuring when I
> >> read Jason's email!!!
> >
> > https://github.com/ceph/ceph/pull/7617
> >
> > The tangled logic in maybe_handle_cache wasn't respecting the force
> > promotion bool.
> >
> > sage
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> 
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.4
> Comment: https://www.mailvelope.com
> 
> wsFcBAEBCAAQBQJWvVgFCRDmVDuy+mK58QAAepwQAIYDDy9BKOqCN6AYg6QK
> XOipjXIAwU+lwJA9dV6GOLSeztyg03i1h0Nvibww9JuRYoWWDfPmRCqWWCyl
> qHoa1q3RgByUTlrxQwl2j0oqVdj2Gn238yyZLqqkhvJS4icc1Xl42710xQa8
> OZCMmrJZQ6ZF4n9rU4tUZy6+4l+FjhmqGCu4PHw6SK2TiA6SJR4pcMsbFb6Y
> h5yWHLNJaCNxe3JVI4sd/tDFxU+pnalz4u2/QkUg2I22C1rYOelbvQ8qeVsR
> TFy3wc62GGqjaZ9+cjvY3VwrsScFh9skz/cBg7ANRs20rdwX74xfdsIUeAdW
> f1zfNaobOBt0ZbrYcrp28BhjpIik7GriBiFSUaJ/xIWc8wDNSYhAApGUMNhc
> oLcsl11zpHzAce8z/Jv5uVRH7VG0jqJKQg8t2l09V/LryxcTktrEQctq+6LS
> zqh46uToc2jpvTvhIwUiT5fhg9NA2j2cOo1lhMgWJBpT41qambgBWAeIXliE
> oHMexkdpN80Fqv+yXjEyDocDH1c1bTlyXI71btHptQNvC2VtTqoviz96CtEt
> jOAFV3nfYz36XkAeayH22ExAwwvF8d9FWpnzEnI3cf63QChN3LAk1C52T5Lw
> T5rp/4kNF3UnTlJ/ejf3twGaR+FSUWMeum4pKpakfpntRH/ZxpU1VSKSL0TM
> BdYi
> =gvlV
> -----END PGP SIGNATURE-----
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
--8323329-835748111-1455279580=:4107--
