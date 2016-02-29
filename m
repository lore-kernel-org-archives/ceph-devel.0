From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 07:50:53 -0500
Message-ID: <CAC-Np1we_V4McV=9UdD--5QvGyRzaC3uZLp7q2DSjeF8DKtb4g@mail.gmail.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
	<CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
	<CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
	<EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
	<CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
	<FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
	<1456736629334.47610@croc.ru>
	<191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
	<1456745435596.21796@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33254 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcB2Muz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 07:50:55 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so35287792wml.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 04:50:54 -0800 (PST)
In-Reply-To: <1456745435596.21796@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

On Mon, Feb 29, 2016 at 6:30 AM, Odintsov Vladislav <VlOdintsov@croc.ru> wrote:
> Can you please provide right way for building rpm packages?

Building binaries is tricky. CI has a few steps to be able to get
binaries at the end of the process. The actual RPM building is mainly
this portion: https://github.com/ceph/ceph-build/blob/master/ceph-build/build/build_rpm#L87-L110

But before doing that you need to install dependencies and run
autogen.sh and configure, etc... as this script does:

https://github.com/ceph/ceph-build/blob/master/ceph-setup/build/build
>
> ________________________________
> Regards,
>
> Vladislav Odintsov
>
> ________________________________________
> From: Shinobu Kinjo <skinjo@redhat.com>
> Sent: Monday, February 29, 2016 14:11
> To: Odintsov Vladislav
> Cc: Franklin M. Siler; Xiaoxi Chen; ceph-devel@vger.kernel.org; ceph-users; Sage Weil
> Subject: Re: [ceph-users] v0.94.6 Hammer released
>
> Can we make any kind of general procedure to make packages so that almost everyone in community build packages by themselves and reduce developers work load caused by too much requirement -;

This is also very tricky to do. All I can offer is to point you (and
others) to the tools that we have and use to create binaries in hopes
that they
can be generalized a bit. For building Ceph we have 3 main steps:

tagging: done with ansible ->
https://github.com/ceph/ceph-build/blob/master/ansible/roles/ceph-release/tasks/main.yml
setup: https://github.com/ceph/ceph-build/blob/master/ceph-setup/build/build
building: depending on the binary type to build, broken up into a few
scripts: https://github.com/ceph/ceph-build/tree/master/ceph-build/build

Once these are built, they are pushed to an HTTP binary API where they
can be consumed later https://chacra.ceph.com/

If a community/generalized effort would be in place I would think a
separate instance of this API should exist so that binary-building
chores
could be split (e.g. by release/distro) and be pushed independently to
this community-owned service.

The service is configured to create the repositories when a new binary
is POSTed so once new ones exist, consuming the repos is trivial.

Everything related to the service is very well documented here:
https://github.com/ceph/chacra#chacra

The most important thing on that service would be the need for space
as repos can get quite large. I wouldn't mind helping out setting up
an instance.

>
> Cheers,
> Shinobu
>
> ----- Original Message -----
> From: "Odintsov Vladislav" <VlOdintsov@croc.ru>
> To: "Franklin M. Siler" <me@franksiler.com>, "Xiaoxi Chen" <superdebuger@gmail.com>
> Cc: ceph-devel@vger.kernel.org, "ceph-users" <ceph-users@ceph.com>, "Sage Weil" <sage@redhat.com>
> Sent: Monday, February 29, 2016 6:04:02 PM
> Subject: Re: [ceph-users] v0.94.6 Hammer released
>
> Hi all,
>
> should we build el6 packages ourself or, it's hoped that these packages would be built officially by community?
>
> ________________________________
> Regards,
>
> Vladislav Odintsov
>
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel.org> on behalf of Franklin M. Siler <me@franksiler.com>
> Sent: Friday, February 26, 2016 05:03
> To: Xiaoxi Chen
> Cc: Alfredo Deza; Dan van der Ster; Sage Weil; ceph-devel@vger.kernel.org; ceph-users
> Subject: Re: [ceph-users] v0.94.6 Hammer released
>
> On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>
>> Will we build package for ubuntu 12.04 (Precise)?
>> Seems it also doesnt show in the repo
>
> The Ceph packages provided by Ubuntu are old.  However, the Ceph project publishes its own packages.
>
> http://download.ceph.com/debian-hammer/dists/precise/
>
> so repo lines for sources.list would be, I think:
>
> deb http://download.ceph.com/debian-hammer/ precise main
> deb-src http://download.ceph.com/debian-hammer/ precise main
>
>
> Cheers,
>
> Frank Siler
> Siler Industrial Analytics
> 314.799.9405--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
