From: Sage Weil <sweil@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 08:04:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240803460.13265@cobra.newdream.net>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net> <CAANLjFo7J44QbGRRY0oKTWRy3HPUKvvxPpKz8rYcr4a24riUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756531AbbIXPEV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Sep 2015 11:04:21 -0400
In-Reply-To: <CAANLjFo7J44QbGRRY0oKTWRy3HPUKvvxPpKz8rYcr4a24riUtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 24 Sep 2015, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> 
> On Thu, Sep 24, 2015 at 6:30 AM, Sage Weil  wrote:
> > Xuan Liu recently pointed out that there is a problem with our handling
> > for full clusters/pools: we don't allow any writes when full,
> > including delete operations.
> >
> > While fixing a separate full issue I ended up making several fixes and
> > cleanups in the full handling code in
> >
> >         https://github.com/ceph/ceph/pull/6052
> >
> > The interesting part of that is that we will allow a write as long as it
> > doesn't increase the overall utilizate of bytes or objects (according to
> > the pg stats we're maintaining).  That will include remove ops, of cours,
> > but will also allow overwrites while full, which seems fair.
> 
> What about overwrites on a COW FS, won't that still increase used
> space? Maybe if it is a COW FS, don't allow overwrites?

Yeah, we could strengthen (optionally?) the check so that only operations 
that result in a net decrease are allowed..

sage

> 
> > However, that's not quite the full story: the client side currently
> > does not send any requests while the full flag is set--it waits until the
> > full flags are cleared before resending things.
> >
> > We can modify things on the client so that it allows ops it knows will
> > succeed (e.g., a simple remove op).  However, if there is another op also
> > queued on that object *before* it, we should either block the remove op
> > (to preserve ordering) or discard it when the remove succeeds (on the
> > assumption that any effect it had is now moot).
> >
> > Is the latter option safe?
> >
> > Or, should we do something more clever?  Ideally it would be good if other
> > allowed operations are let through, but unfortunately the client doesn't
> > really know enough to tell whether it will/can succeed.  e.g., a class
> > "refcount.put" call might result in a deletion (and in fact there is a
> > class that does just that).  We could also send all such requests and, if
> > we get ENOSPC, keep them queued and retry when the full flag is cleared.
> > That would require a bit more complexity on the OSD side to preserve
> > ordering, but it's doable...
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.1.0
> Comment: https://www.mailvelope.com
> 
> wsFcBAEBCAAQBQJWBA6qCRDmVDuy+mK58QAAzL0QAK9tU0oPhPU5isoYpeoO
> tnA/C4dZ1XzMC9gRcPRXUEWbhCZYJ/1lL8H1QygXW/niYBkn8ReCJ5SX+Ucy
> Vli7hJtS0WUQEp9UdYhBUxjbtOxl7ad1EjQVZjRSjzFyDqWLuHvP2RT8fdwA
> CW1x4ICTZZ4wHNqfMy/kj4Cb3OZ2N8owKG20KgGoSbuoT+2l+/KWs9/6viHv
> 8HY+IhejMBncKQl2cDnRY3DroLLW6bW6aHMQwzkINqmbyMaYDoYAPOiMS4NK
> S3XBWvYxNNl8EWsSJo1apGfdmICWqzzuiVbjY8NjOD/cwFiIis31rY0GI7Zs
> Zn4QzFYMbMNcRvFgYh3xezs0gog0vthinjsCeUjUCMbyhE65DFZ9wBgxTeun
> lfYrhGdrbpL2vBTSaNrPUhFlKtPWoscfYFM/APMfUFCWMvZ3dT+iZ18/tTcD
> 4ueG7KSn0veq5QWLBV9QEChfAfCcGAt8abPORCIftHNm9E5m1ZwtxIwGK5pE
> zDgZPMhwZvrS6wy+5uWJFSW/qdUcicEb16FDr5e2GSYY3GfI/hOiNs4EFK42
> l0xdK4cdwJ1aDB1mUXvd5qbkad8wPNb0IZlGcygx88Zm7V8ryjtsuTJZb7EC
> 7jo/M6kub5Fnp0YF2FOYEhvy12SivjkMeCcsL6EWZpPlpHVnFzMaJSoRmmgv
> vtp2
> =g/5x
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
