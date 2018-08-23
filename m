From: Lenz Grimmer <lgrimmer-IBi9RG/b67k@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Thu, 23 Aug 2018 11:22:31 +0200
Message-ID: <89b3285e-b5d7-4eba-1c34-df39354ae5f4@suse.com>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
 <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1428759844458670502=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1428759844458670502==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="o2jE95RreLAsWRC0shqkZwv5ZHRo87HRq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o2jE95RreLAsWRC0shqkZwv5ZHRo87HRq
Content-Type: multipart/mixed; boundary="QristMG7nmzLIdXRNaVl1QpecmhJOPRjo";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer-IBi9RG/b67k@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org,
 "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <89b3285e-b5d7-4eba-1c34-df39354ae5f4-IBi9RG/b67k@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to Luminous
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--QristMG7nmzLIdXRNaVl1QpecmhJOPRjo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/22/2018 08:57 PM, David Turner wrote:

> My initial reaction to this PR/backport was questioning why such a
> major update would happen on a dot release of Luminous.  Your
> reaction to keeping both dashboards viable goes to support that.
> Should we really be backporting features into a dot release that
> force people to change how they use the software?  That seems more of
> the purpose of having new releases.

This is indeed an unusual case. But considering that the Dashboard does
not really change any of the Ceph core functionality but adds a lot of
value by improving the usability and manageability of Ceph, we agreed
with Sage on making an exception here.

> I haven't really used either dashboard though.  Other than adding
> admin functionality, does it remove any functionality of the previous
> dashboard?

Like Kai wrote, our initial goal was to reach feature parity with
Dashboard v1, in order to not introduce a regression when replacing it.

In the meanwhile, Dashboard v2 is way beyond that and we have added a
lot of additional functionality, e.g. RBD and RGW management.

With backporting this to Luminous, we also hope to reach a larger
audience of users that have not updated to Mimic yet.

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--QristMG7nmzLIdXRNaVl1QpecmhJOPRjo--

--o2jE95RreLAsWRC0shqkZwv5ZHRo87HRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCW3581wAKCRBJUOEqsnKR
8ofkAJ9EetMRRIyDPSJuZ/QmOo8BNBLaKwCfVku3vS5RHJX2ApJ2Ga684XyxvDc=
=M1Zu
-----END PGP SIGNATURE-----

--o2jE95RreLAsWRC0shqkZwv5ZHRo87HRq--

--===============1428759844458670502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1428759844458670502==--
