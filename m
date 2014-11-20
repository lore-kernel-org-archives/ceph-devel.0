From: Dmitry Smirnov <onlyjob-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: OSD systemd unit files makes it look failed
Date: Fri, 21 Nov 2014 09:46:02 +1100
Message-ID: <1451350.rcDJb3ndID@debstor>
References: <CADkWibfOvOEr7cFcKNFmKBi+0-GhtXGVZrj3RQFqryC68Stcfg@mail.gmail.com>
	<alpine.DEB.2.00.1411200652250.2374@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0438851487=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1411200652250.2374-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clint-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0438851487==
Content-Type: multipart/signed; boundary="nextPart11345444.BWvO0buMph"; micalg="pgp-sha256"; protocol="application/pgp-signature"


--nextPart11345444.BWvO0buMph
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu, 20 Nov 2014 06:56:43 Sage Weil wrote:
> Moving this thread to ceph-devel.  I don't have time to work on this =
at
> the moment but would be very happy to hear feedback on Dmitry's lates=
t
> (and review pull requests :).

Hi guys, please do not expect pull requests from me -- I'm leaving syst=
emd=20
support as is and unlikely to introduce any changes. I'm done with Ceph=
 (very=20
disappointed) and probably will leave ceph-maintainers after decommissi=
oning=20
remains of my cluster.=20

Gaudenz Steinlin added some valuable bits in our relevant feature reque=
st bug=20
where we discussed systemd support:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D769593

Gaudenz helps to maintain Ceph in Debian so it would be worth contactin=
g him =20
if you have any questions.

=2D-=20
All the best,
 Dmitry Smirnov.

=2D--

A wise man proportions his belief to the evidence.
        -- David Hume, "An Inquiry Concerning Human Understanding"

--nextPart11345444.BWvO0buMph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJUbm8tAAoJEFK2u9lTlo0bFQIQAKmUcPHVXAjPmRWt3z3Kwvqz
QNL50H7MwmfVW3c6qZQNIXIJ4ORUlk2m6GUoQnzv/avd14RO0r9JHJqwq5+4PO8v
/nXPgcMkjEJoONpD8tznfxpr4HPtWJ6Q/yOXqkLaWNKnqmIn1m88HClhEohqwBSS
jvlxH3nfCbCqN3k9qDugOuACf1+hdSkZwl++BZSfueon8mgBNFM4CCKFYZ4DE0J0
ps6lxetsENKJ8iF8M6zOKKsjptSe6ncCRjDmAJlfoBhwCfGnJWz5umPnCT5HWYvp
vupqwpWboGnLKMSGnINQyMSfsT8AafmZFfzgY0M6V5MJJeSXCGtW2wiNPQDwI6T0
jSdN6hW6HOcJmNooe0H6TQIez8zWDlPl3UH3DqqJFNCnMJI/yi1D0DFXChlMdvXu
0Hqgao8ZfLxg5GMlFFllXvt4eUFZoF4Tvku1DzIvtHZdYwH3ctJ7j/9Y82reX1dB
s8pxbzeQ6HXVywQeplricA/HRvY0KS7ck6nqwvjsrCQ6tybxIG93kI1KorwI/hBz
Vj8vNFLp7CCZZKH3OYvrHvBeLfSv0WvL+kr6sAQF+FMrDilrPtO9J2yktRnv+UzZ
kPy7AbBxzjmehVDyAAG4X78bx5VCo2JGZ1iZzMklnK/iDMBogDqtiAi4yt5uJg3S
OjZii+AXoaET3aybTLcX
=n6UG
-----END PGP SIGNATURE-----

--nextPart11345444.BWvO0buMph--


--===============0438851487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0438851487==--
