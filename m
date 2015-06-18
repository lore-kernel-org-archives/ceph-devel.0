From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Build RPMs from git
Date: Thu, 18 Jun 2015 14:35:37 -0600
Message-ID: <CAANLjFr1owE0H7E-gFec1Xa8GsHgfJq4DkZ7azvJDJErNOxK1Q@mail.gmail.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
	<5582CB44.1060001@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36086 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbbFRUfj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 16:35:39 -0400
Received: by wicnd19 with SMTP id nd19so195159wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 13:35:38 -0700 (PDT)
In-Reply-To: <5582CB44.1060001@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Cool, I'll have to give it a shot.
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Jun 18, 2015 at 7:44 AM, Owen Synge  wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi Robert,
>
> I have a pull request open for exactly this use case.
>
>     https://github.com/ceph/ceph/pull/4911
>
> I find it particularly useful for debugging spec file issues when
> running on other operating systems than suse.
>
> The pull request gives two new "make' targets.
>
>     make srpm
>     make rpm
>
> I hope this helps.
>
> (1) merge this pull request to make it all work.
>
> (2) sh autogen.sh
>
> (3) ./configure
>
> (4) make rpm
>
> Your done :)
>
> best regards
>
> Owen
>
> On 06/09/2015 11:15 PM, Robert LeBlanc wrote:
>> OK, easy question...
>>
>> Building Debian packages from git is wonderfully easy, RPMs seem ...=
=2E
>> not so easy.
>>
>> I got it to kind of work, but I feel like I'm doing it the "Hard Way=
" (tm).
>>
>> mkdir -p ~/ceph && pushd ~/ceph
>> git clone https://github.com/ceph/ceph.git
>> ./autogen.sh
>> ./configure
>> echo "--- /root/ceph/ceph/ceph.spec   2015-06-09 13:03:08.240099443 =
-0600
>> +++ /root/rpmbuild/SPECS/ceph.spec      2015-06-09 13:12:54.14506135=
5 -0600
>> @@ -464,12 +464,14 @@
>>  # common
>>  ###################################################################=
##############
>>  %prep
>> -%setup -q
>> +#%setup -q
>> +cd %{buildroot}
>>  %if 0%{?fedora} || 0%{?rhel}
>>  %patch0 -p1 -b .init
>>  %endif
>>
>>  %build
>> +cd %{buildroot}
>>  # Find jni.h
>>  for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
>>      [ -d $i ] && java_inc=3D"$java_inc -I$i"" | patch
>> rpmbuild -ba ceph.spec --define 'buildroot `pwd/ceph`'
>>
>> It coughs at the install/RPM package part.
>>
>> Any help with preventing the whole tar/untar process which I can't
>> seem to get exactly right either would be very helpful.
>>
>> Thanks,
>>
>> ----------------
>> Robert LeBlanc
>> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> - --
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffe=
r, HRB
> 21284 (AG
> N=C3=BCrnberg)
>
> Maxfeldstra=C3=9Fe 5
>
> 90409 N=C3=BCrnberg
>
> Germany
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQEcBAEBAgAGBQJVgstEAAoJECe/2BuiZiboGrAH/jqGIE5yGAgrSIRGJ+TonzjY
> vUNTQz9wR0P1MUWPV3WeEQaX5tiUPGJZ9i7DkLq+sUiOojHDda37sePm1vx68uiO
> C1+Ea8FN7Rw4L+M2eqQbwNbOfLjLakxotudZxMWuUhm9NDKF218BLUZpyFJJfJYK
> sBm4GEWp++r3cOXtzMJck4Pet4KIrr34vhS+6SyUo5inivJzw0SApF4ro2Zz13m7
> WzfyxJDf83VbQvZ0jgucZZz44lBD5804lEGOBXVX6fzFI2Mr7UhL+jJqCIJ2rzOr
> 94zSz4vpP1Sv2dbgGXEDRJtMZZay7shPQ4hpiPwZTtdgBYPC5h6kLZUestowUfA=3D
> =3DqfrD
> -----END PGP SIGNATURE-----

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVgyuWCRDmVDuy+mK58QAAHsYP/iPPBhIYnaFcMVFQpkzB
S8yNoprV7JdDwJgAKw2UzP/s5Rhy4Cq0yCGYCg6b2CsSOAomw2kVWtZeUtYG
tQo+2d8MMAWR7Y2+2FkhLNzWIQbp6SorhLRJ7aJxzsFzmcs8tOCpK8vyoQhE
AQOvTLViO1wQCRm7iHVL8iLgaNCnCAOxW0lWd3QNgPREu9Qs1n/7NZiS//Jb
QohJI9qdEEJ46rgMBU9mqr7qjV9AgvvUa2NubZ8A+Oz5d2y1lOGOtcDimm7w
qjLhGgo4K5lVBe+Q0md0jObo4ZrGgaRJeQt35bCnESUBlH3QtZjdTKRDmB7s
1uZVD9z600ME73QmeuKfqgW/4Vqu2L5ul10omh5dR+PlIKy8fosGmkd+zt6c
v/QuRRNZy0eW9bFbNvcuDZ0vNJTW12Rw9UoR12LQllby1NVuyOztmYimuCw/
kGR4IIOCRDPc3OCQtc+NjPqntNrAZo5uCgEhbCQpLFnOXWFhVFBu+LtV7tYN
/dV5F/o2wkmikQzbSpgE4hxC1I/48oIpFrvfDqpMNB6k/WAfNfk6lMIARPYT
qvLpdOjlosEUp+kpm1lVOTdtaNEIsmEsVQa8o2WLcQ0xDZg1XPZ6588LtHZG
xP6821hmQEF6YRoduOTOzuu6MdznIKGQZ3hkv6VITngdzhTGiQaUSgDaw3ew
xvK7
=3DyvyW
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
