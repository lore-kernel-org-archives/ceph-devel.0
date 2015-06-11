From: Robert LeBlanc <robert@leblancnet.us>
Subject: rbd top
Date: Thu, 11 Jun 2015 13:33:01 -0600
Message-ID: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34557 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbFKTdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 15:33:03 -0400
Received: by wgv5 with SMTP id 5so10686161wgv.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2015 12:33:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

One feature we would like is an "rbd top" command that would be like
top, but show usage of RBD volumes so that we can quickly identify
high demand RBDs.

Since I haven't done any programming for Ceph, I'm trying to think
through the best way to approach this. I don't know if there are
already perf counters that I can query that are at the client, RBD or
the Rados layers. If these counters don't exist would it be best to
implement them at the client layer and look for watchers on the RBD
and query them? Is it better to handle it at the Rados layer and
aggregate the I/O from all chunks? Of course this would need to scale
out very large.

It seems that if the client running rbd top requests the top 'X'
number of objects from each OSD, then it would cut down on the data
that the has to be moved around and processed. It wouldn't be an
extremely accurate view, but might be enough.

What are your thoughts?

Also, what is the best way to get into the Ceph code? I've looked at
several things and I find myself doing a lot of searching to find
connecting pieces. My primary focus is not programming so picking up a
new code base takes me a long time because I don't know many of the
tricks that help people get to speed quickly.

Thanks,
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVeeJoCRDmVDuy+mK58QAAYNUQAMQW1zB7FB7L1ahFdTU5
zt2K3AM+oJv/tl4TPtn1C8YXksHYAlzKK28r6boUszoINb+54c+RxZ8pbstL
JwS10w0H6K/vZP0UOn03MNm3IkOYqJooiL84NT6HGBjAQLUwY6QwDWQ/5Cdl
nhHuH4UDUVX8ydQYQCv7QDx4l5I8NVoUAno7dwXQ8LN6cTrNinQGYeYOXwFE
nyM1u6Fj0mpaOD4OUpHfSkCl/qx6FATv9EM99alNrgBJqgLlp/wi31cSGL7c
4///valIk5Bndt6Qk002uxzB898WD50Tvqkk3rVNDtnO7SKJ6tcMfy8JUfm0
sPy+VU9sBECNxot5zmenvIPxfUIhfmfsY7hzj1wzlw8tP6bUV2T3pdsliOmD
g7fQChmzHl6yUnugYShPCkCysrJa4V9xVQgCPfMUz6Tmacf82BpktZCU1ixX
J+lDYoHqzeReBoRO5+O8DN5kPzwNg/JbwjDW4ZQfBBdBeZxOiUvpfCKv9Y7O
43iqFsbvj6JJye4GahdpgzjgYW1m8k/hKNlw5eS0+/9qkBw4wl+WISiXchsJ
kaAf0IGWbFxskf8KxVgJR7LMin7cq+ehb+Vfxl+PL5qo8hj+j8iZWFLcHzgI
SUAL4hcGjgGTaysnck4cCOk4eWaSwzbYsKEMjtpfzLIZ1PcAgIr52Id6p8gL
YRnR
=oPko
-----END PGP SIGNATURE-----
