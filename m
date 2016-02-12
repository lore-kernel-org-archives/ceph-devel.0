From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] cls_rbd ops on rbd_id.$name objects in EC pool
Date: Thu, 11 Feb 2016 20:56:56 -0700
Message-ID: <CAANLjFovUm6Lpb6WKQXoKg9WX_pjc_-hOsL12NnrsJB__y0weQ@mail.gmail.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com>
	<1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com>
	<CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com>
	<alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
	<0bc701d1604f$8f21e0a0$ad65a1e0$@fisk.me.uk>
	<5848cd48.9Ro.9Gf.h0.1onaHAyHUe@mailjet.com>
	<549809462.21912115.1455221387486.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.11.1602111557000.28396@cpach.fuggernut.com>
	<dbf6eb9a.9Ro.9Gf.cs.1lNjEIPmE9@mailjet.com>
	<alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34545 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcBLD45 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 22:56:57 -0500
Received: by mail-vk0-f53.google.com with SMTP id e185so52428521vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Feb 2016 19:56:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nick Fisk <nick@fisk.me.uk>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Is this only a problem with EC base tiers or would replicated base
tiers see this too?
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Feb 11, 2016 at 6:09 PM, Sage Weil  wrote:
> On Thu, 11 Feb 2016, Nick Fisk wrote:
>> That=E2=80=99s a relief, I was sensing a major case of face palm occ=
uring when I
>> read Jason's email!!!
>
> https://github.com/ceph/ceph/pull/7617
>
> The tangled logic in maybe_handle_cache wasn't respecting the force
> promotion bool.
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWvVgFCRDmVDuy+mK58QAAepwQAIYDDy9BKOqCN6AYg6QK
XOipjXIAwU+lwJA9dV6GOLSeztyg03i1h0Nvibww9JuRYoWWDfPmRCqWWCyl
qHoa1q3RgByUTlrxQwl2j0oqVdj2Gn238yyZLqqkhvJS4icc1Xl42710xQa8
OZCMmrJZQ6ZF4n9rU4tUZy6+4l+FjhmqGCu4PHw6SK2TiA6SJR4pcMsbFb6Y
h5yWHLNJaCNxe3JVI4sd/tDFxU+pnalz4u2/QkUg2I22C1rYOelbvQ8qeVsR
TFy3wc62GGqjaZ9+cjvY3VwrsScFh9skz/cBg7ANRs20rdwX74xfdsIUeAdW
f1zfNaobOBt0ZbrYcrp28BhjpIik7GriBiFSUaJ/xIWc8wDNSYhAApGUMNhc
oLcsl11zpHzAce8z/Jv5uVRH7VG0jqJKQg8t2l09V/LryxcTktrEQctq+6LS
zqh46uToc2jpvTvhIwUiT5fhg9NA2j2cOo1lhMgWJBpT41qambgBWAeIXliE
oHMexkdpN80Fqv+yXjEyDocDH1c1bTlyXI71btHptQNvC2VtTqoviz96CtEt
jOAFV3nfYz36XkAeayH22ExAwwvF8d9FWpnzEnI3cf63QChN3LAk1C52T5Lw
T5rp/4kNF3UnTlJ/ejf3twGaR+FSUWMeum4pKpakfpntRH/ZxpU1VSKSL0TM
BdYi
=3DgvlV
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
