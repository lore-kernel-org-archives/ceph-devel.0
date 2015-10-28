From: Robert LeBlanc <robert@leblancnet.us>
Subject: Fix OP dequeuing order
Date: Wed, 28 Oct 2015 17:21:38 -0600
Message-ID: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33833 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbbJ1XVj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 19:21:39 -0400
Received: by vkgs66 with SMTP id s66so15944727vkg.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 16:21:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I created a pull request to fix an op dequeuing order problem. I'm not
sure if I need to mention it here.

https://github.com/ceph/ceph/pull/6417

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWMVh6CRDmVDuy+mK58QAAztQP/385BOI8AH2uEJhN8pQ4
QnAJxRy4HceWzjfAUulqNbbiD1scHZMU7LDW1GtsXfOZzmndTnJSBrR4+aHq
F7py9zgXcxXH4uTAoILbRzkCF3rWdmkeh1/m5aY4LqmhE2N/O/LLOmDUe2BT
XkQgZ9sROzY9pSj6pjA2vuv7k2u1SWtF3Ky14Hll3LHjqJibXoXYy+ik7lOP
lRUoAY08Yf+c/Ag/Yy7CLGgIk/y6mdaJZPd2PCaVsKFa55NJAlYv0PHJKX0j
XkSAY10MednMX6N+QL8XAq+yiAd//UADfCNhxHkP84YsPPCpNeS1OcoF6WGG
g5H8uMK84kZCk37ummW/ANg9WNnO3hN2j22r9ezA+4GfxqKibT4lEMba6h88
i5L3rQwWmM0cdpjS9plH1yUiPP2DexJV8PaiAIVVMAkw+AC0Xb/nUXKX6u5+
YU744kSjtscN95Caf72V6HirB/uEU4sm+4lUuUBHzTcvau/r9WUHezwvmUiH
HHL9bSU5TJ4jXvQhDEBYKbflTzLNKjXPcp1PagN2P9ZWQvNaxrQm32iB84DW
6jLEArFX10kE3eZ8IqoBikw5d+y3YtnuJ1oAIkfzj1ANofm37VKcQY/Wfrjw
eke0nR4QBuN6SibbPXqIsjjIWZdo/jCgOCylNONXCFn9Qp08/7UJMQtzHk/1
xRRp
=g+NJ
-----END PGP SIGNATURE-----
