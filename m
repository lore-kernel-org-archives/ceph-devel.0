From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: MDS auth caps for cephfs
Date: Thu, 28 May 2015 12:29:16 -0600
Message-ID: <CAANLjFqoZ0hBjXEHAcc4VLygCuzwzxtKpNH+nJHE3X00dvfKqQ@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net>
	<CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com>
	<alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
	<CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net>
	<CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net>
	<CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com>
	<alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net>
	<CAC6JEv8pmJ-PhMUVqoP_VNsGR-STyjiyfcPqqpEQRv8x=UTjwA@mail.gmail.com>
	<CAANLjFqA+X7WYQ6NX_-L--vZorerSCQs6YcNSfUrurjsQFOsYA@mail.gmail.com>
	<CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com>
	<alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net>
	<CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com>
	<alpine.DEB.2.00.1505281024560.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33206 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbbE1S3R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 14:29:17 -0400
Received: by wgez8 with SMTP id z8so43743707wge.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 11:29:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505281024560.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Thu, May 28, 2015 at 11:32 AM, Sage Weil  wrote:
>> If for instance a directory is shared between tenant A and B, and A
>> can write and B can't, then when B tries to write because the perms
>> are correct for the UID/GID on the client side, the MDS will prevent
>> the write because that tenant doesn't have "share" write access on
>> that directory.
>
> This feels like it's just adding some protection for an admin that
> accidentally gives tenant A access to tenant B's subtree.  Assuming the
> subtree streams aren't crossed, it doesn't add anything, right?

The example I was thinking about was that A builds and provides some
RPMS in a directory. They want to allow tenant B to access those in a
read-only fashion. Tenant B key is given share read access to the RPM
directory (A also makes sure the files are world readable).

>> If a tenant wants to allow write access to part of a directory, then
>> there has to be some level of trust that they will act responsibly. I
>> can't see getting around that without implementing Kerberos and
>> preventing the client from mapping to other UID/GIDs, but that really
>> takes the flexibility out of the system.
>
> There are three scenarios:
>
> 1) Each tentant in their own subtree, clients do enforcement.  They can do
> whatever they want but Ceph doesn't care because the tenant is confined.
>
> 2) Kerberos, as you say, allows the MDS to enforce permissions on shared
> directories.  You're right that you need that infrastructure before we can
> sanely, except when
>
> 3) untrusted clients are given access to a shared directory but restricted
> to act as a single user.  In this case, the MDS still enforces
> permissions, and kerberos isn't needed.  Imagine your workstation being
> allowed to mount the department file server.
>
> In any case, doing any enforcement on the MDS is opt-in.  It *expands*
> your options by making it possible to share the same subtrees to different
> untrusted clients and still enforce permissions.  If you have a
> multi-tenant environment where data isn't shared, you can still do what
> you're suggesting and leave it to the clients...  or even run in a
> completely trusted mode like we have now where clients all mount / and can
> do whatever they want.

I certainly would like the shared aspect of CephFS to work well, be
secure and flexible. I think this is getting into the points I really
dislike about NFS. My opinion of a Network file system is that access
should be controlled by the server. The server should only allow a
client to operate as the UID that they authenticate as (none of this
'I get to choose which UID I get to be' stuff). The server is
authoritative for UID to GID mapping and has final say over file
access.

This type of structure favors users, each user has to map the
directory. It really sucks at system mounts and you have to rely on
groups a ton. Add that you either have to tie into a User directory or
integrate one to make it really useful, it can get really complex real
fast. However the NFS model is really good at system mounts because it
is easy to twiddle the owner/perms etc, but a lot is left to the
client which makes it less secure. At the same time, it could probably
be implemented with little to no change of cephx.

I guess it boils down to which situation are we trying to target/solve?

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVZ154CRDmVDuy+mK58QAAXTcP/1bJDaE2KU1BKVk2O+o1
7VKuy7qfXhOrthVimBIH12G0F9KOmG4jWMWjW3PVXOHLRuQK8kM96W4qXG5o
7AFQnu3i7JDva3EUBK/PTvGSIxkVCmHLTmpI9FapVPE3fil6LB5VEmHLgNDt
IgPuLbkSwiRw5bjCBdfbVQMSjfhs+Q1HhrrXJy3S7Inp+AcBVetyY17JLHQm
6OX4Ae2l0sSEhqHzse3wB0WF2dgvcq/Z7IxPL80+V5Gh0yZJ9F5oCuhXKOlO
q9dOJOWdR6peEactpXBAoD9Yqr3Na2euO9TCkk+1nTx7Efas8IfzEwdh3Ge7
O9i+shOG7e0Za9wF2q1UL1rORRseJ1A8ezA9DaQxZyT+1vR8IbxJda0AUhRP
e8E+Yw553MyxKqSE33A0mPnyZ4VVXBucQtYtjCEqJV1ijF/OS7SlAi3e730X
VaxWaCYb7XshGsvndyr2F2W6CZY9naXIyjPmDoqGzxMa4DDWrmYvZb4/wtQi
lkq88ZtOJLaGZotshlwvdqh46XKmkUicQJnyUSrGFh47LVVfBm7PzuUCu1T4
8WlWS8QRHEcX0j8SY8eIvPZGgVYxsR6qm4cobv9jrdnRaHHwN/CQVBx9Xcci
W3w8yO0MSKUukdekIlsOcWgP3jqjjG/cyrOy2k+OhjDRrhbQlmnr2lzjNSKP
WHXV
=U1EU
-----END PGP SIGNATURE-----
