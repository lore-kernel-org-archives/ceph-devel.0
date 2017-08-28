From: Florian Haas <florian@hastexo.com>
Subject: Fwd: State of play for RDMA on Luminous
Date: Mon, 28 Aug 2017 10:42:23 +0200
Message-ID: <a88cf691-5f93-a8a4-588d-b6880017d405@hastexo.com>
References: <f2071e94-2b4e-b809-b244-bf7ca62be9ba@hastexo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HmAewmDDLtvLIH08Ue90XQbmNaCcldxvc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38635 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbdH1Im2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Aug 2017 04:42:28 -0400
Received: by mail-wr0-f179.google.com with SMTP id y14so8340194wrd.5
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2017 01:42:27 -0700 (PDT)
Received: from [192.168.1.132] (91-119-119-96.dsl.dynamic.surfer.at. [91.119.119.96])
        by smtp.gmail.com with ESMTPSA id l20sm12000196wre.26.2017.08.28.01.42.24
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 01:42:24 -0700 (PDT)
In-Reply-To: <f2071e94-2b4e-b809-b244-bf7ca62be9ba@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HmAewmDDLtvLIH08Ue90XQbmNaCcldxvc
Content-Type: multipart/mixed; boundary="8KjjTVu4Ga6HmXPCma3aEUrlXcTw4fX8T";
 protected-headers="v1"
From: Florian Haas <florian@hastexo.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Message-ID: <a88cf691-5f93-a8a4-588d-b6880017d405@hastexo.com>
Subject: Fwd: State of play for RDMA on Luminous
References: <f2071e94-2b4e-b809-b244-bf7ca62be9ba@hastexo.com>
In-Reply-To: <f2071e94-2b4e-b809-b244-bf7ca62be9ba@hastexo.com>

--8KjjTVu4Ga6HmXPCma3aEUrlXcTw4fX8T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm taking the liberty to cross-post to the -devel list. I did get a
couple of off-list replies but they were of the "oh cool, I want to know
too" type. :)

Looking forward to people's thoughts.

Cheers,
Florian


-------- Forwarded Message --------
Subject: State of play for RDMA on Luminous
Date: Wed, 23 Aug 2017 10:26:45 +0200
From: Florian Haas <florian@hastexo.com>
To: ceph-users@lists.ceph.com <ceph-users@lists.ceph.com>

Hello everyone,

I'm trying to get a handle on the current state of the async messenger's
RDMA transport in Luminous, and I've noticed that the information
available is a little bit sparse (I've found
https://community.mellanox.com/docs/DOC-2693 and
https://community.mellanox.com/docs/DOC-2721, which are a great start
but don't look very complete). So I'm kicking off this thread that might
hopefully bring interested parties and developers together.

Could someone in the know please confirm that the following assumptions
of mine are accurate:

- RDMA support for the async messenger is available in Luminous.

- You enable it globally by setting ms_type to "async+rdma", and by
setting appropriate values for the various ms_async_rdma* options (most
importantly, ms_async_rdma_device_name).

- You can also set RDMA messaging just for the public or cluster
network, via ms_public_type and ms_cluster_type.

- Users have to make a global async+rdma vs. async+posix decision on
either network. For example, if either ms_type or ms_public_type is
configured to async+rdma on cluster nodes, then a client configured with
ms_type =3D async+posix can't communicate.

Based on those assumptions, I have the following questions:

- What is the current state of RDMA support in kernel libceph? In other
words, is there currently a way to map RBDs, or mount CephFS, if a Ceph
cluster uses RDMA messaging?

- In case there is no such support in the kernel yet: What's the current
status of RDMA support (and testing) with regard to
  * libcephfs?
  * the Samba Ceph VFS?
  * nfs-ganesha?
  * tcmu-runner?

- In summary, if a user wants to access their Ceph cluster via a POSIX
filesystem or via iSCSI, is enabling the RDMA-enabled async messenger in
the public network an option? Or would they have to continue running on
TCP/IP (possibly on IPoIB if they already have InfiniBand hardware)
until the client libraries catch up?

- And more broadly, if a user wants to use the performance benefits of
RDMA, but not all of their potential Ceph clients have InfiniBand HCAs,
what are their options? RoCE?

Thanks very much in advance for everyone's insight!

Cheers,
Florian


--=20
Please feel free to verify my identity:
https://keybase.io/fghaas




--8KjjTVu4Ga6HmXPCma3aEUrlXcTw4fX8T--

--HmAewmDDLtvLIH08Ue90XQbmNaCcldxvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIxBAEBCAAbBQJZo9dvFBxmbG9yaWFuQGhhc3RleG8uY29tAAoJEEqtGHdMPKEn
5aIQAKruOB1flYuKVyrB4OHnpNNwAbKC152MWfgZ9f0FgzGIKFEC622P3U2YVUF9
nUVRUK5bF+TJz/dSEY+3DD+pQ2R8GNVNfRfjDuRJyuhy1M6YpPq9JpUH8u0RV46s
js5GTw+awjDA4rvqNxe9BccNPiW6mDXzRy88YIiHCpyKyQZP8IkoANg5zF4kTQEG
Lji+oHib5mNJX5hYZKvWBVp1nPWax5A5st2CjMwEXqm/GKBien9IUmLwDmUBZtb9
8dvCz8ePZHgV8e5CHZy7zu+41/j7IA33LKOfB195Za+5jUWWLithrLEqHy+QGU7n
HRDS0tLUvH5KDCnL2a2+RDtoE+GAorMsT4nXlDReBccYKFxA4n8g5zyNGJaxwz89
Itz1qmbXIZPgoKK/1cc+q6aA/93jbo6CZqzBhoja2/uIHs7gHNFTj8cacb/l83bQ
q/w+U8HxeBuHvEDr3Hn1Y4fLEFZ5E/toe5yEZlBRs0pOyOFLmJThC/EN1j8bW/+e
eVvrGygym2KkQBOZUT3oFW+0Ank/JrRKJoSZRQAybrtxyDLjAfX3jy7Po0mT3OvF
KpCZcs2xMY90hWmgkkJbFEplgbAjnxTK47w9/qNoQavEHKgw9BJXrkZe5MyOTQec
vc14bYQiAVdwouukkH6xh7vD9np86VqVv558vruQK5Udx+CH
=79F8
-----END PGP SIGNATURE-----

--HmAewmDDLtvLIH08Ue90XQbmNaCcldxvc--
