From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 21:59:24 +0700
Message-ID: <56D45CCC.8010608@dachary.org>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
 <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
 <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
 <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
 <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
 <1456745435596.21796@croc.ru>
 <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37757 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538AbcB2O7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 09:59:36 -0500
In-Reply-To: <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

Hi Dan & al,

I think it would be relatively simple to have these binaries published =
as part of the current "Stable release" team effort[1]. Essentially doi=
ng what you did and electing a central place to store these binaries. T=
he trick is to find a sustainable way to do this which means having a p=
rocess that is simple to maintain and understand as well as enough of u=
s to maintain that in the long run.

The basic idea is to copy the packages that are build by gitbuilders or=
 by the buildpackage teuthology task in a central place. Because these =
packages are built, for development versions as well as stable versions=
[2]. And they are tested via teuthology. The packages that are publishe=
d on http://ceph.com/ are rebuilt from scratch, using the process that =
Alfredo described. This is fine for the supported platforms and for the=
 stable releases. But for the development releases and the platforms th=
at are no longer supported but still built by gibuilders, we could just=
 copy the packages over.

Does that sound sensible ?

[1] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO
[2] http://gitbuilder.ceph.com/


On 29/02/2016 20:28, Dan van der Ster wrote:
> On Mon, Feb 29, 2016 at 12:30 PM, Odintsov Vladislav <VlOdintsov@croc=
=2Eru> wrote:
>> Can you please provide right way for building rpm packages?
>=20
> It's documented here:
> http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-mana=
ger
>=20
> For 0.94.6 you need to change the .spec file to use .tar.gz (because
> there was no .bz2 published for some reason). And then also grab
> init-ceph.in-fedora.patch from here:
> https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.in-f=
edora.patch
>=20
> BTW, I've put our build here:
> http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/
> These are unsigned, untested and come with no warranty, no guarantees
> of any sort. And IMHO, no third party build would ever to give that
> warm fuzzy trust-it-with-my-data feeling like a ceph.com build would
> ;)
>=20
> Moving forward, it would be great if the required community effort
> could be put to work to get ceph.com el6 (and other) builds. For el6
> in particular there is also the option to help out the Centos Storage
> SIG to produce builds. I don't have a good feeling which direction is
> better ... maybe both.
>=20
> -- Dan
> CERN IT Storage Group
>=20
>=20
>> ________________________________
>> Regards,
>>
>> Vladislav Odintsov
>>
>> ________________________________________
>> From: Shinobu Kinjo <skinjo@redhat.com>
>> Sent: Monday, February 29, 2016 14:11
>> To: Odintsov Vladislav
>> Cc: Franklin M. Siler; Xiaoxi Chen; ceph-devel@vger.kernel.org; ceph=
-users; Sage Weil
>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>
>> Can we make any kind of general procedure to make packages so that a=
lmost everyone in community build packages by themselves and reduce dev=
elopers work load caused by too much requirement -;
>>
>> Cheers,
>> Shinobu
>>
>> ----- Original Message -----
>> From: "Odintsov Vladislav" <VlOdintsov@croc.ru>
>> To: "Franklin M. Siler" <me@franksiler.com>, "Xiaoxi Chen" <superdeb=
uger@gmail.com>
>> Cc: ceph-devel@vger.kernel.org, "ceph-users" <ceph-users@ceph.com>, =
"Sage Weil" <sage@redhat.com>
>> Sent: Monday, February 29, 2016 6:04:02 PM
>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>
>> Hi all,
>>
>> should we build el6 packages ourself or, it's hoped that these packa=
ges would be built officially by community?
>>
>> ________________________________
>> Regards,
>>
>> Vladislav Odintsov
>>
>> ________________________________________
>> From: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel=
=2Eorg> on behalf of Franklin M. Siler <me@franksiler.com>
>> Sent: Friday, February 26, 2016 05:03
>> To: Xiaoxi Chen
>> Cc: Alfredo Deza; Dan van der Ster; Sage Weil; ceph-devel@vger.kerne=
l.org; ceph-users
>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>
>> On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger@gmail.com> wrote=
:
>>
>>> Will we build package for ubuntu 12.04 (Precise)?
>>> Seems it also doesnt show in the repo
>>
>> The Ceph packages provided by Ubuntu are old.  However, the Ceph pro=
ject publishes its own packages.
>>
>> http://download.ceph.com/debian-hammer/dists/precise/
>>
>> so repo lines for sources.list would be, I think:
>>
>> deb http://download.ceph.com/debian-hammer/ precise main
>> deb-src http://download.ceph.com/debian-hammer/ precise main
>>
>>
>> Cheers,
>>
>> Frank Siler
>> Siler Industrial Analytics
>> 314.799.9405--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
