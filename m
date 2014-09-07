From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Storing cls and erasure code plugins in a pool
Date: Sun, 7 Sep 2014 09:38:50 -0400
Message-ID: <CANP1eJG=5bDx3JeFNfUgfq7TCS7QvKnAsXD+=XzcJK2vm-Uyxg@mail.gmail.com>
References: <540C169C.9030603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:55570 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbaIGNiw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 09:38:52 -0400
Received: by mail-la0-f48.google.com with SMTP id ty20so4172347lab.35
        for <ceph-devel@vger.kernel.org>; Sun, 07 Sep 2014 06:38:51 -0700 (PDT)
In-Reply-To: <540C169C.9030603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

If you're planning on having plugins that are not shipped with the
host software you have to worry about both API and ABI stability.
Traditionally (and in my personal experience) keeping a C++ ABI
compatible is hard. For those reasons, I would strongly campaign for
having the plugins interface be in C (or et least their interface
would be C linkage).

Otherwise here's some things you can read read about C++ ABI stability
(from the KDE people):
https://techbase.kde.org/Policies/Binary_Compatibility_Issues_With_C++

This are my 2 cents based on my past experience.

On Sun, Sep 7, 2014 at 4:26 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> There is a need for a cluster to share code such as cls https://githu=
b.com/ceph/ceph/tree/master/src/cls or erasure code plugins https://git=
hub.com/ceph/ceph/tree/master/src/erasure-code/.
>
> These plugins could have a life cycle independent of Ceph, as long as=
 they comply to the supported API ( https://github.com/ceph/ceph/blob/m=
aster/src/erasure-code/ErasureCodeInterface.h ). For erasure code plugi=
ns it currently works this way (or it will as soon as https://github.co=
m/ceph/ceph/pull/2397 is merged):
>
> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new =
erasure code plugins
> b) the MON will refuse to create an erasure coded pool using the new =
I* plugins, otherwise the Hammer nodes will find themselves unable to p=
articipate in the pool
>
> Instead it could work this way:
>
> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new =
erasure code plugins
> b) the new erasure code plugins are uploaded to a "plugins" pool
> c) an erasure coded pool is created using a new plugin from I*
> d) the Hammer OSD downloads the plugin from the pool and can particip=
ate in the pool
>
> It is easier said than done and there are a lot of details to conside=
r. However it not different from maintaining an Operating System that i=
ncludes shared libraries and the path to do so properly is well known.
>
> Thoughts ?
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
