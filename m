From: Owen Synge <osynge@suse.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Wed, 05 Aug 2015 14:43:09 +0200
Message-ID: <55C204DD.8020801@suse.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com> <55C09717.5020005@suse.com> <1723487568.1751820.1438712768626.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:38696 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752569AbbHEMpJ (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 5 Aug 2015 08:45:09 -0400
In-Reply-To: <1723487568.1751820.1438712768626.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <amaredia@redhat.com>
Cc: ceph-devel@vger.kernel.org

Dear Ali,

my point is no longer relevant, but your reassurances is still very
relevant.

Thanks

Owen

On 08/04/2015 08:26 PM, Ali Maredia wrote:
> Owen,
>=20
> I understand your concern, and don't think any transition will be mad=
e to
> CMake untill all the functionality is in it and until it has been tho=
roughly=20
> vetted by the entire community to ensure a smooth transition.
>=20
> I pushed a branch earlier today called wip-cmake=20
> (https://github.com/ceph/ceph/tree/wip-cmake) and plan to continue Or=
it's=20
> make check work, and coordinate with John on the vstart work he's don=
e
> already as my very first action items.
>=20
> -Ali
>=20
> ----- Original Message -----
> From: "Owen Synge" <osynge@suse.com>
> To: "Ali Maredia" <amaredia@redhat.com>, ceph-devel@vger.kernel.org
> Sent: Tuesday, August 4, 2015 6:42:31 AM
> Subject: Re: Transitioning Ceph from Autotools to CMake
>=20
> Dear Ali,
>=20
> I am glad you are making progress.
>=20
> Sadly I don't yet know cmake.
>=20
> Please consider the systemd wip branch. It might be wise to leave
> autotools around a little longer, until all functionality is in the c=
make.
>=20
> Best regards
>=20
> Owen
>=20
>=20
> On 07/30/2015 09:01 PM, Ali Maredia wrote:
>> After discussing with several other Ceph developers and Sage, I want=
ed
>> to start a discussion about making CMake the primary build system fo=
r Ceph.
>>
>> CMake works just fine as it is (make -j4 on master with CMake builds
>> 350% faster than autotools!), but there's more work needed to make i=
t=20
>> into a first-class build system.
>>
>> Short term (1-2 weeks):
>>  - Making sure CMake works on all supported platforms: Centos7, RHEL=
7,
>>    Ubuntu 14.04 & 12.04, Fedora 22, Debian Jessie, Debian Wheezy are=
 the
>>    target platforms I have noted to test on already.
>>  - Adding a target similar to make check
>>  - Creating CMake targets that build packages (such as for rpm or de=
bian)
>>  - Writing documentation for those who haven't used CMake before to =
smooth the
>>    transition over
>>  - Making sure no targets or dependencies are missing from the
>>    current CMake build, and that CMake supports all current=20
>>    targets, configurations and options
>>  - Replacing the integration autotools has with any automated build/=
test
>>    systems such as the gitbuilder
>>
>> Longer term (2-4 weeks):
>>  - Removing the current autotools files, to avoid doubling build sys=
tem
>>    workload
>>  - Adding more but shorter CMakeLists.txt files to a tree like struc=
ture
>>    where a CMakeLists.txt would be in every subdirectory
>> =20
>> I'm already working on a target similar to the make check target, an=
d plan
>> on working on the other short term goals over the next weeks and bey=
ond.
>>
>> I wanted to get feedback from the community any reasons why someone =
started using=20
>> CMake but stopped (ex: lack of functionality), and more broadly, on =
what other=20
>> obstacles there might be for the transition.
>>
>> -Ali
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
