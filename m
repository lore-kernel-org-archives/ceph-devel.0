From: Loic Dachary <loic@dachary.org>
Subject: Fwd: Re: Erasure Coding and Homomorphism
Date: Fri, 25 Oct 2013 14:53:46 +0200
Message-ID: <526A69DA.40805@dachary.org>
References: <CAKt0SKFm6Rpz4CXE0YQD2mEL-wDfRWfeHj01ZWtMvh57PViOVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2F5uG34DmmSPWOviChHHqS6vUhm4nlSGq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46226 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab3JYMxs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 08:53:48 -0400
In-Reply-To: <CAKt0SKFm6Rpz4CXE0YQD2mEL-wDfRWfeHj01ZWtMvh57PViOVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Francois Helt <francois.helt@h-t-solutions.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2F5uG34DmmSPWOviChHHqS6vUhm4nlSGq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Forwarded on behalf of Francois Helt who is temporarily experiencing trou=
bles with the mailing list subscription system.

-------- Original Message --------
Subject: 	Re: Erasure Coding and Homomorphism
Date: 	Fri, 25 Oct 2013 10:43:57 +0200
From: 	Francois Helt <francois.helt@h-t-solutions.com>
To: 	James Plank <plank@cs.utk.edu>
CC: 	Loic Dachary <loic@dachary.org>



Hello
a quick reaction.
The papers are interesting indeed.

Let me do a rough summary of what I understand and the application requir=
ements I foresee
A Client C is entrusting precious and large data to a Server S (or a Serv=
ice company provinding long-term preservation in our case)
The Client is able to generate Keys in such a way that, it is possible to=
 Challenge the Server to verify the presence of the whole data
1) without having to retain the original data on the Client side,
2) the Server being unable to forge a plausible answer
3) with limited network traffic and with efficient data browsing
Therefore it is a secure Verifiable Possession of the data by the Server
It seems that there is also the possibility that the data is encrypted.

This is the first important point for our application:
The Service provided for preserving data must be such that data is encryp=
ted and (we) the Server is allways managing data blindly
without the possibility to see it clearly - i.e. without the possibility =
to make illegal copies of the content.

The second point is also easy to foresee:
The Server must also be able to check the integrity of data it is preserv=
ing in order to fight data corruption.
Erasure coding might be used in such a way that as soon as recovery of th=
e data is becoming too difficult,
there must be an action to regenerate the original data (always encrypted=
) and redo the erasure coding.

If data can be kept encrypted and secured in the described way there is t=
he possibility for the Client
to recover its data even if the Service company is going under.
The Keys by the Client may serve as indictors for the data that the clien=
t owns really.

A third point is essential for our application:
The erasure coding (and/or encryption if erasure coding is not enough to =
prevent piracy) must be managed
in such a way that it is progressive, the order of chunks of data is pres=
erved..
The data must be arranged keeping the original partition, at boudaries of=
 indicidual images or small group of images.
It may be necessary (for the sake of preservation management) that indivi=
dual images or group of images have to be replaced.
It is    essential to avoid replacing a whole film if only a small portio=
n is corrupted.
Also it may happen that large file should be split in order to fit with b=
ackups system sizes.

I hope that I am clear enough
Francois


2013/10/18 James Plank <plank@cs.utk.edu <mailto:plank@cs.utk.edu>>

    Hi Francois and Loic -- sorry to be so long in responding.  I'm swamp=
ed as always.  Is the following paper something like what you're envision=
ing?

    http://web.njit.edu/~crix/publications/acm-tissec11a.pdf

    I think the combination is a powerful one which has seen some applica=
tion (I know about this one because I was on Osama Khan's phd committee).=
  Perhaps the Store, Forget and Check paper by Ethan Miller does the same=
 thing -- it has been a few years since I have read it: http://www.ssrc.u=
csc.edu/pub/schwarz06-icdcs.html

    Are these having the flavor of what you are proposing?

    Thanks and best wishes -- Jim
    ----------

    On Oct 11, 2013, at 11:36 AM, Francois Helt wrote:

>     Hello
>
>     to be a bit more precise and to show the interest of the combinatio=
n of technologies, the idea is the following
>
>     Combining "Erasure coding" and "Homomorphic encryption" in order to=
:
>     - Allow the preservation of cinematographic content with huge size =
requirements
>     - Offer a fully secure service as the service provider will never s=
ee the decrypted content
>     - use "homomorphic" coding allowing to work on, recover and manage =
encrypted content
>
>     =20
>
>
>     2013/10/11 Loic Dachary <loic@dachary.org <mailto:loic@dachary.org>=
>
>
>         Hi James,
>
>         Please meet Fran=E7ois Helt who is best know for his work on im=
age processing in the movie industry. It has been suggested that there ma=
y be interesting intersections between "Homomorphism" and Erasure Coding.=
 Do you have an opinion on this topic ? It is entirely possible that my q=
uestion does not make any sense :-) Hopefully Fran=E7ois will be able to =
expand in a sensible way.
>
>         Cheers
>
>         P.S. I cc' the public mailing list ceph-devel in the hope that =
people are willing to participate in this thread.
>
>         --
>         Lo=EFc Dachary, Artisan Logiciel Libre
>         All that is necessary for the triumph of evil is that good peop=
le do nothing.
>
>
>
>
>     --=20
>     *Fran=E7ois Helt*
>     Chief Scientific Officer  | Highlands Technologies Solutions
>
>     francois.helt@h-t-solutions.com <mailto:nicolas.chiovini@h-t-soluti=
ons.com>
>     www.h-t-solutions.com <http://www.h-t-solutions.com/>
>
>     <image002.jpg>
>
>     1900 route des Cr=EAtes - BP 298
>     06905 Sophia Antipolis Cedex, France
>
>     --------------------
>     P /!! Please consider the environment before printing this email !!=
/
>
>     Disclaimer
>     Our company accepts no liability for the content of this email, or =
for the consequences of any actions taken on the basis of the information=
 provided, unless that information is subsequently confirmed in writing. =
If you are not the intended recipient you are notified that disclosing, c=
opying, distributing or taking any action in reliance on the contents of =
this information is strictly prohibited. Please notify the sender immedia=
tely by e-mail if you have received this e-mail by mistake and delete thi=
s e-mail from your system. E-mail transmission cannot be guaranteed to be=
 secure or error-free as information could be intercepted, corrupted, los=
t, destroyed, arrive late or incomplete, or contain viruses. The sender t=
herefore does not accept liability for any errors or omissions in the con=
tents of this message, which arise as a result of e-mail transmission._ _=
Sender immediately by e-mail if you have received this e-mail by mistake =
and delete this e-mail from your system.
>     E-mail transmission cannot be guaranteed to be secure or error-free=
 as information could be intercepted, corrupted, lost, destroyed, arrive =
late or incomplete, or contain viruses. The sender therefore does not acc=
ept liability for any errors or omissions in the contents of this message=
, which arise as a result of e-mail transmission.
>
>




--=20
*Fran=E7ois Helt*
Chief Scientific Officer  | Highlands Technologies Solutions

francois.helt@h-t-solutions.com <mailto:nicolas.chiovini@h-t-solutions.co=
m>
www.h-t-solutions.com <http://www.h-t-solutions.com/>

cid:part6.06030403.08020703@h-t-solutions.com

1900 route des Cr=EAtes - BP 298
06905 Sophia Antipolis Cedex, France

--------------------
P /!! Please consider the environment before printing this email !!/

Disclaimer
Our company accepts no liability for the content of this email, or for th=
e consequences of any actions taken on the basis of the information provi=
ded, unless that information is subsequently confirmed in writing. If you=
 are not the intended recipient you are notified that disclosing, copying=
, distributing or taking any action in reliance on the contents of this i=
nformation is strictly prohibited. Please notify the sender immediately b=
y e-mail if you have received this e-mail by mistake and delete this e-ma=
il from your system. E-mail transmission cannot be guaranteed to be secur=
e or error-free as information could be intercepted, corrupted, lost, des=
troyed, arrive late or incomplete, or contain viruses. The sender therefo=
re does not accept liability for any errors or omissions in the contents =
of this message, which arise as a result of e-mail transmission._ _Sender=
 immediately by e-mail if you have received this e-mail by mistake and de=
lete this e-mail from your system. E-mail
transmission cannot be guaranteed to be secure or error-free as informati=
on could be intercepted, corrupted, lost, destroyed, arrive late or incom=
plete, or contain viruses. The sender therefore does not accept liability=
 for any errors or omissions in the contents of this message, which arise=
 as a result of e-mail transmission.






--2F5uG34DmmSPWOviChHHqS6vUhm4nlSGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJqadoACgkQ8dLMyEl6F20LnQCgusOoKnhGIEMBn3P1HC95Ez6m
CqAAn1r5sm+yMcL26/CJKa3caWC6JQ/i
=TLEv
-----END PGP SIGNATURE-----

--2F5uG34DmmSPWOviChHHqS6vUhm4nlSGq--
