From: Ali Maredia <amaredia@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Tue, 4 Aug 2015 14:26:08 -0400 (EDT)
Message-ID: <1723487568.1751820.1438712768626.JavaMail.zimbra@redhat.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com> <55C09717.5020005@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:39401 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbHDS0L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 14:26:11 -0400
In-Reply-To: <55C09717.5020005@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

Owen,

I understand your concern, and don't think any transition will be made =
to
CMake untill all the functionality is in it and until it has been thoro=
ughly=20
vetted by the entire community to ensure a smooth transition.

I pushed a branch earlier today called wip-cmake=20
(https://github.com/ceph/ceph/tree/wip-cmake) and plan to continue Orit=
's=20
make check work, and coordinate with John on the vstart work he's done
already as my very first action items.

-Ali

----- Original Message -----
=46rom: "Owen Synge" <osynge@suse.com>
To: "Ali Maredia" <amaredia@redhat.com>, ceph-devel@vger.kernel.org
Sent: Tuesday, August 4, 2015 6:42:31 AM
Subject: Re: Transitioning Ceph from Autotools to CMake

Dear Ali,

I am glad you are making progress.

Sadly I don't yet know cmake.

Please consider the systemd wip branch. It might be wise to leave
autotools around a little longer, until all functionality is in the cma=
ke.

Best regards

Owen


On 07/30/2015 09:01 PM, Ali Maredia wrote:
> After discussing with several other Ceph developers and Sage, I wante=
d
> to start a discussion about making CMake the primary build system for=
 Ceph.
>=20
> CMake works just fine as it is (make -j4 on master with CMake builds
> 350% faster than autotools!), but there's more work needed to make it=
=20
> into a first-class build system.
>=20
> Short term (1-2 weeks):
>  - Making sure CMake works on all supported platforms: Centos7, RHEL7=
,
>    Ubuntu 14.04 & 12.04, Fedora 22, Debian Jessie, Debian Wheezy are =
the
>    target platforms I have noted to test on already.
>  - Adding a target similar to make check
>  - Creating CMake targets that build packages (such as for rpm or deb=
ian)
>  - Writing documentation for those who haven't used CMake before to s=
mooth the
>    transition over
>  - Making sure no targets or dependencies are missing from the
>    current CMake build, and that CMake supports all current=20
>    targets, configurations and options
>  - Replacing the integration autotools has with any automated build/t=
est
>    systems such as the gitbuilder
>=20
> Longer term (2-4 weeks):
>  - Removing the current autotools files, to avoid doubling build syst=
em
>    workload
>  - Adding more but shorter CMakeLists.txt files to a tree like struct=
ure
>    where a CMakeLists.txt would be in every subdirectory
> =20
> I'm already working on a target similar to the make check target, and=
 plan
> on working on the other short term goals over the next weeks and beyo=
nd.
>=20
> I wanted to get feedback from the community any reasons why someone s=
tarted using=20
> CMake but stopped (ex: lack of functionality), and more broadly, on w=
hat other=20
> obstacles there might be for the transition.
>=20
> -Ali
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
