From: Robert LeBlanc <robert@leblancnet.us>
Subject: Best way to measure client and recovery I/O
Date: Fri, 18 Dec 2015 16:47:29 -0700
Message-ID: <CAANLjFo83v8m_z3MoN+8MR8awShrfuGzWgSbDroyqbHRscNN_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34031 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbLRXra (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 18:47:30 -0500
Received: by mail-vk0-f48.google.com with SMTP id j66so74189408vkg.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Dec 2015 15:47:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've been working with Sam Just today and we would like to get some
performance data around client I/O and recovery I/O to test the new Op
queue I've been working on. I know that we can just set and OSD out/in
and such, but there seems like there could be a lot of variation in
the results making it difficult to come to a good conclusion. We could
just run the test many times, but I'd love to spend my time doing
other things.

Please let me know if you have any great ideas around this problem.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWdJsOCRDmVDuy+mK58QAAKnMP/iJ1sef1wqwsWCKxFXWA
dSbrcZg8QhqLg8HCFmb8qg6RTb3x440xXkKSLiXyOTy7ZyHJlbwOtasRLakl
uVikor8/hgLkKeWRtw3p3jHj7quOVoY7zQ6i6Y9aRlgSyCSOliAl02ufdjGS
k2Zh7WRwPl2qnBfLkgghTwR7yXaKXYYhHBfW9JHniIL6/pTVd2bgNFTUxtZ4
NgnMjq56TAM/dL4Q8byaMin9TbORz726tabTFeo8iK9EpyjRgJ8VIItFuTx2
sG5WMpFVkQ8Er72IOhzKn7ukI9hyWVl6ruYV1I2lUr+qPqLPdLQ0aZVaP8Xz
hYvik58wprkwTyg6iG3Vka0yiLJpW3RrtrLk/OjM3nZ9fO3G1eFX9EE3k6wu
SsxM66B2iHYc/Q6xGmB5sY22+Y8pVsxN9ULn+c2HKQqcL83tmS2yE6NIbk5s
u0XZheZTDRAj6buL8T6PukSZomI1bQaLOz5p11IqttzqOAH9EjY3nYqN4CYi
kXKHn8c5pUb2ocrZKM3Y/ooQ6kNvGHAWBmdQCXT9t5BGHDQsSHwDX6IUjFX4
QfdzAwlEscle7Zy2CGnTdd4nz9Ny88msxbSRPt97KeJkBV93b9hSNYd0W2qk
qELgDYzurR7LuVGINOnTeCfcWiw5oW0jdDU8Z4wWsYpNBkGyiuEmtLSV7h6M
X3OO
=TXse
-----END PGP SIGNATURE-----
