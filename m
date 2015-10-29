From: Sage Weil <sage@newdream.net>
Subject: Re: Fix OP dequeuing order
Date: Wed, 28 Oct 2015 21:52:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510282152110.1004@cobra.newdream.net>
References: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45425 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbJ2Ewn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 00:52:43 -0400
In-Reply-To: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 28 Oct 2015, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> I created a pull request to fix an op dequeuing order problem. I'm not
> sure if I need to mention it here.
> 
> https://github.com/ceph/ceph/pull/6417

Wow, good catch.  Have you found that this materially impacts the behavior 
in your cluster?

sage


> 
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
> 
> wsFcBAEBCAAQBQJWMVh6CRDmVDuy+mK58QAAztQP/385BOI8AH2uEJhN8pQ4
> QnAJxRy4HceWzjfAUulqNbbiD1scHZMU7LDW1GtsXfOZzmndTnJSBrR4+aHq
> F7py9zgXcxXH4uTAoILbRzkCF3rWdmkeh1/m5aY4LqmhE2N/O/LLOmDUe2BT
> XkQgZ9sROzY9pSj6pjA2vuv7k2u1SWtF3Ky14Hll3LHjqJibXoXYy+ik7lOP
> lRUoAY08Yf+c/Ag/Yy7CLGgIk/y6mdaJZPd2PCaVsKFa55NJAlYv0PHJKX0j
> XkSAY10MednMX6N+QL8XAq+yiAd//UADfCNhxHkP84YsPPCpNeS1OcoF6WGG
> g5H8uMK84kZCk37ummW/ANg9WNnO3hN2j22r9ezA+4GfxqKibT4lEMba6h88
> i5L3rQwWmM0cdpjS9plH1yUiPP2DexJV8PaiAIVVMAkw+AC0Xb/nUXKX6u5+
> YU744kSjtscN95Caf72V6HirB/uEU4sm+4lUuUBHzTcvau/r9WUHezwvmUiH
> HHL9bSU5TJ4jXvQhDEBYKbflTzLNKjXPcp1PagN2P9ZWQvNaxrQm32iB84DW
> 6jLEArFX10kE3eZ8IqoBikw5d+y3YtnuJ1oAIkfzj1ANofm37VKcQY/Wfrjw
> eke0nR4QBuN6SibbPXqIsjjIWZdo/jCgOCylNONXCFn9Qp08/7UJMQtzHk/1
> xRRp
> =g+NJ
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
