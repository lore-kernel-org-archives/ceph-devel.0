From: Loic Dachary <loic@dachary.org>
Subject: Re: Storing cls and erasure code plugins in a pool
Date: Sun, 07 Sep 2014 22:27:53 +0200
Message-ID: <540CBFC9.7000400@dachary.org>
References: <540C169C.9030603@dachary.org> <CABBk=J9UZRUfp+Mj7gU_6O0cCP4Pg+W42HiC+7o4TZ_YWpBapg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nwIExqL2TcIEH3FcBPJt0aoh2V0qnes1T"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46879 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752082AbaIGU17 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 16:27:59 -0400
In-Reply-To: <CABBk=J9UZRUfp+Mj7gU_6O0cCP4Pg+W42HiC+7o4TZ_YWpBapg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwIExqL2TcIEH3FcBPJt0aoh2V0qnes1T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

You are right : erasure code plugins must obey the same constraints as ob=
jclass plugins, only worse because once a plugin starts being used it mus=
t remain available for as long as the pool needs it to read/write chunks.=
=20

Maintaining a repository of binary plugins is indeed not trivial. I just =
meant to write that it is not much different from apt-get installing shar=
ed libraries from architecture dependant repositories. We do not have to =
invent something, we can mimic and adapt existing best practices.

Maybe this idea is over engineering and there is a better / simpler solut=
ion to deal with erasure code plugin upgrades ? Or objclass upgrades for =
that matter.

Cheers

On 07/09/2014 21:42, Yehuda Sadeh wrote:
> On Sun, Sep 7, 2014 at 1:26 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ceph,
>>
>> There is a need for a cluster to share code such as cls https://github=
=2Ecom/ceph/ceph/tree/master/src/cls or erasure code plugins https://gith=
ub.com/ceph/ceph/tree/master/src/erasure-code/.
>>
>> These plugins could have a life cycle independent of Ceph, as long as =
they comply to the supported API ( https://github.com/ceph/ceph/blob/mast=
er/src/erasure-code/ErasureCodeInterface.h ). For erasure code plugins it=
 currently works this way (or it will as soon as https://github.com/ceph/=
ceph/pull/2397 is merged):
>>
>> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new e=
rasure code plugins
>> b) the MON will refuse to create an erasure coded pool using the new I=
* plugins, otherwise the Hammer nodes will find themselves unable to part=
icipate in the pool
>>
>> Instead it could work this way:
>>
>> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new e=
rasure code plugins
>> b) the new erasure code plugins are uploaded to a "plugins" pool
>> c) an erasure coded pool is created using a new plugin from I*
>> d) the Hammer OSD downloads the plugin from the pool and can participa=
te in the pool
>>
>> It is easier said than done and there are a lot of details to consider=
=2E However it not different from maintaining an Operating System that in=
cludes shared libraries and the path to do so properly is well known.
>>
>> Thoughts ?
>=20
> And here we go (almost) full circle. Originally the objclass (cls)
> mechanism worked somewhat similar. The code would be injected to the
> monitors, and it was then distributed to the osds. When uploading the
> objects we'd also specify the architecture, and there's an embedded
> version in each so that it was possible to disable one version and
> enable another.
> The problem is that this specific method is very problematic when
> dealing with heterogeneous environments, where each osd can run on a
> different architecture, or different distribution. Also need to
> maintain a very well contained api for the objclasses to use (which we
> don't have), and be very careful about versioning. In other words, it
> doesn't work, and the trouble doesn't worth the benefits.
> I'm not too familiar with the erasure code plugins, but it seems to me
> that they need to be versioned. Then you could have multiple plugins
> with different versions installed, and then you could specify which
> version to use. You could have a tool that would make sure that all
> the osds have access to the appropriate plugin version. But the actual
> installation of the plugin wouldn't be part of ceph's internal task.
> It might be that the erasure code plugins are more contained than the
> objclasses, and something like you suggested might actually work.
> Though I'm having trouble seeing that happening having a compiled
> shared object as the resource that needs to be distributed. The first
> objclass implementation actually pushed python code to the nodes (it
> really did!), maybe having something like that for erasure code could
> work, given the appropriate environment and tools.
>=20
> Yehuda
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nwIExqL2TcIEH3FcBPJt0aoh2V0qnes1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQMv8kACgkQ8dLMyEl6F23vRACgxX+OBLPsLi7EifRE0XlEHfFd
6XsAoJ2ogWxB1eMK2ayyIlcHjDEkGFk7
=iEgI
-----END PGP SIGNATURE-----

--nwIExqL2TcIEH3FcBPJt0aoh2V0qnes1T--
