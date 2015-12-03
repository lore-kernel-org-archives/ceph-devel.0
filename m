From: Casey Bodley <cbodley@redhat.com>
Subject: Re: ObjectStore interface and std::list
Date: Thu, 3 Dec 2015 13:57:33 -0500 (EST)
Message-ID: <280021236.28383673.1449169053804.JavaMail.zimbra@redhat.com>
References: <1147769245.28299019.1449164516705.JavaMail.zimbra@redhat.com> <1412841180.28305561.1449164765461.JavaMail.zimbra@redhat.com> <CAANLjFrxzC96TppzjrN23QxEJ7RZp_jrU8FayB+isDnSRYqBdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:46587 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbLCS5f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 13:57:35 -0500
In-Reply-To: <CAANLjFrxzC96TppzjrN23QxEJ7RZp_jrU8FayB+isDnSRYqBdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


----- Original Message -----
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Template functions can be virtual in c++11 and can avoid the VTL. I'm
> using them in https://github.com/ceph/ceph/pull/6781 .Hi Robert,

Hi Robert,

Virtual functions are allowed in a templated class, but templated member
functions are a separate case. My suggestion to use iterators would require
the function itself to be templated on the iterator type. This isn't allowed,
because the virtual function table would have to contain an entry for every
template instantiation of that function.

Casey

> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> 
> 
> On Thu, Dec 3, 2015 at 10:46 AM, Casey Bodley  wrote:
> > Hi,
> >
> > I missed out on the context leading up to the discussion about
> > queue_transactions and the use of raw vs. smart pointers, but I'm curious
> > whether the use of std::list in the ObjectStore interface has come up as
> > well. That's another source of allocations that could be avoided.
> >
> > A naive approach could just replace the list with vector, which could at
> > least reduce the number of allocations to one if you reserve() space for
> > all of your elements up front.
> >
> > An interface based on iterators could also help, by allowing the caller to
> > put an array on the stack and pass that in. Iterators are tricky because
> > the generic form requires templates, and template functions can't be
> > virtual. But if we require the elements to be sequential in memory (i.e.
> > raw array, std::array or std::vector), the
> > interface could take (Transaction** begin, Transaction** end) without
> > requiring templates. This interface can also be made compatible with
> > unique_ptrs.
> >
> > Casey
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.0
> Comment: https://www.mailvelope.com
> 
> wsFcBAEBCAAQBQJWYIp9CRDmVDuy+mK58QAAKVEP/jFe1Vv/1ZJbz30FCM6a
> DB85aIvbnw2qjNHBbFeaJSAd2oJyVxC1bqfVKTxcms0pnQPYL8/GcAzUImrt
> n986VgBJAIeaH0qRSGYcITS4rlSikUcSUcPAdjL6Fv9yPleGLCqmCEIWUj/q
> jKTndoEb4E20I6XHJpG2dAXdxk/knMJJGwHtS7KdsgR2nDos5evjncGrE8I7
> nvSO/4zshuQPoglOC86SP17tviQUew3e/a9cZ6jPy6Adz0u3XeV+eKyhf2SB
> 3hm2sfRVOPT6rdfRvjBBLR7QFz7kJxedyWB2y5c4j2x7GtdWgiZn2YePuNti
> yRPad+Jq04DpXX0IUFY9+FXQeOIdEQq40bhfvVOgus04xHXgcjUdyR0AYh0M
> YfXoqvBg7L5C68duPP2wjn2w58CLCDqCp+4JQVVRZ9au8YQK4vt53BefuFnH
> QX2XePnXNnlkqjgXmq9TqQafETodZYi0VQ110ADGQA/TsPGEqzUn2mudUjM7
> ixbJdbcwUd4JHwb55zK5xxBaat9EBj+5pI9Xfjz4Fg8+ZcgKRkWG7EsFVlTn
> bcZb8TV9/3FSrGFbV4UqTf5IT1/wVuWeG/AKOs540yNFr9My/DtKlNxx+/8O
> VhSliJ2qbymw0/JpsTacGMqWjYH5bADfYiCmBcyPm8EHYXOnfxNmpC9FYkpO
> 4LUj
> =9kKf
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
