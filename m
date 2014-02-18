From: bernhard glomm <bernhard.glomm@ecologic.eu>
Subject: Re: [Ceph-maintainers] disabling updatedb
Date: Tue, 18 Feb 2014 23:07:18 +0100
Message-ID: <A58163BA-D050-4A33-9B52-4DFDA664F65D@ecologic.eu>
References: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net> <8738jg2trm.fsf@meteor.durcheinandertal.bofh> <CABZ+qqkfe_WA36vH0vf+6HNy1qR-hsy8PLTbEUJKvLC1GeTbWQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DA21A38E-446D-43CE-88B0-386284E55CA4"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ecologic.eu ([85.214.42.230]:45858 "EHLO mx01.ecologic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaBRWPL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Feb 2014 17:15:11 -0500
In-Reply-To: <CABZ+qqkfe_WA36vH0vf+6HNy1qR-hsy8PLTbEUJKvLC1GeTbWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, Sage Weil <sage@inktank.com>, ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_DA21A38E-446D-43CE-88B0-386284E55CA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Well IMO the cleanest solution would be to convince the=20
mlocate devels to introduce an /etc/updatedb.d/ directory
so every package could drop their snippet there.
Since that might be a rather long shot
I agree that it is a a job for general management=20

In cfengine it would just read something like:
...
edit_line	=3D>	=
regex_replace("(^\s*PRUNEFS=3D\")(?!ceph)(.*$)","$(match.1)ceph =
$(match.2)");
...
With a  proper  self containing bundle once called from postinst that =
would survive any=20
upgrade of mlocate with minimal impact.

Regards,
Bernhard

> On Feb 18, 2014, at 7:20 PM, Dan van der Ster =
<daniel.vanderster@cern.ch> wrote:
>=20
> Hi,
>=20
> On Tue, Feb 18, 2014 at 6:52 PM, Gaudenz Steinlin <gaudenz@debian.org> =
wrote:
>>=20
>> Hi
>>=20
>> Sage Weil <sage@inktank.com> writes:
>>=20
>>> Dan at CERN noticed that his performance was tanking because =
updatedb was
>>> running against /var/lib/ceph.  updatedb has a PRUNE line in
>>> /etc/updatedb.conf that we should presumably be adding ourselves to. =
 One
>>> user pointed out a package that uses sed to rewrite this line in the =
init
>>> script on start.
>>>=20
>>> I have two questions:
>>>=20
>>> - is there no better way than sed to add ourselves to this list?
>>> - should we do it in the init script, or postinst, or both?
>>>=20
>>> Presumably this is a problem others have solved with other packages.
>>=20
>> At least for Debian neither solution is appropriate. Changing other
>> packages conffiles in postinst scripts is forbidden by policy. There =
is
>> also no way to preserve this reliably over upgrades without user
>> interaction. I'm not sure if there is an explicit policy for init
>> scripts, but this seems equally wrong. Also it's unclear how one =
would
>> handle the case were an administrator does NOT want to exclude this
>> directory.
>>=20
>> The only solution I see if you really want to completely exclude the
>> directory is to convince the mlocate maintainers to either add the
>> directory to the default configuration or to add something like an
>> /etc/updatedb.d directory where packages can drop configuration file
>> snippets. But the latter seems like overkill to me.
>>=20
>> The real question to me is why an updatedb run can drastically impact
>> ceph performance. At least in Debian updatedb is run with ionice
>> -c3 in the "Idle" scheduling class. According to the man page this
>> means: "A program running with idle I/O priority will only get disk =
time
>> when no other program has asked for disk I/O for a defined grace =
period.
>> The impact of an idle I/O process on normal system activity should be
>> zero. This scheduling class does not take a priority argument.
>> Presently, this scheduling class is permitted for an ordinary user
>> (since kernel 2.6.25)." So it should not have any negative effect.
>>=20
>> Maybe CERN (or the distribution they use) should also run updatedb =
under
>> ionice.
>=20
> updatedb _is_ run under ionice on our systems (RHEL), but IO
> scheduling classes are only implemented by the cfq scheduler.
> We use deadline, which is recommended for an enterprise disk server,
> and indeed measured more stable IO latencies with deadline than with
> cfq. And when you run updatedb on a deadline scheduled drive, there
> are so many reads queued up that writes can be starved for many 10s of
> seconds.
>=20
> In our case, we've already added /var/lib/ceph to the PRUNEPATHS via
> their puppet configuration. Though an upstream solution is probably a
> good idea since I would assume that most ceph deployments use deadline
> and this would hit most of them eventually once they have enough
> files. In addition, as someone else mentioned, you'd better add ceph
> to the pruned fs types as well, just like /afs is pruned at the
> moment, lest every client spend all day stat'ing their big cephfs
> namespace.
>=20
> Cheers, Dan
>=20
> -- Dan van der Ster || Data & Storage Services || CERN IT Department =
--
>=20
>>=20
>> Gaudenz
>>=20
>> --
>> Ever tried. Ever failed. No matter.
>> Try again. Fail again. Fail better.
>> ~ Samuel Beckett ~
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--Apple-Mail=_DA21A38E-446D-43CE-88B0-386284E55CA4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJTA9mWAAoJEHt+VBZXpX4EPd8H/14K7TY/w5JIkjP9AQxLRXGM
mISGujwAcYmAZnMIny1UYREBL+NQDscHYCYWWq0ZDYT09S8PEokAdkHOyIReNq20
2+5ENVA6svpi/q7AuIWftlhVxeHL+ZDI7nfA+CHbqmVml2SlyhSGpnvXddTzbi03
DKRoxmS/IqStcBQ0BRmpNFtvNEIrXXA6/WsMi93XYN5iMCrWXm+PlOC8+DE8jjr7
HIpiPgWs9kbmOHjQTxsexsy+ddbw3bYi6rwVWkHTQn2gUYZbU9fEPnTtJJx/yZHC
OlFUsEkNqpg4k4t7EpKS9uefrP4IXdQl1Cn5+YX2BLTNuefv8Xk1ZTlNSfPYXQQ=
=dNTA
-----END PGP SIGNATURE-----

--Apple-Mail=_DA21A38E-446D-43CE-88B0-386284E55CA4--
