From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 14:28:44 +0100
Message-ID: <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
 <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
 <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com> <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com> <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com> <1456745435596.21796@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33528 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbcB2N32 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 08:29:28 -0500
Received: by mail-lb0-f182.google.com with SMTP id ed16so1709279lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 05:29:27 -0800 (PST)
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com. [209.85.217.181])
        by smtp.gmail.com with ESMTPSA id l10sm1872169lfb.35.2016.02.29.05.29.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 05:29:24 -0800 (PST)
Received: by mail-lb0-f181.google.com with SMTP id bc4so79774340lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 05:29:24 -0800 (PST)
In-Reply-To: <1456745435596.21796@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

On Mon, Feb 29, 2016 at 12:30 PM, Odintsov Vladislav <VlOdintsov@croc.ru> wrote:
> Can you please provide right way for building rpm packages?

It's documented here:
http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-manager

For 0.94.6 you need to change the .spec file to use .tar.gz (because
there was no .bz2 published for some reason). And then also grab
init-ceph.in-fedora.patch from here:
https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.in-fedora.patch

BTW, I've put our build here:
http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/
These are unsigned, untested and come with no warranty, no guarantees
of any sort. And IMHO, no third party build would ever to give that
warm fuzzy trust-it-with-my-data feeling like a ceph.com build would
;)

Moving forward, it would be great if the required community effort
could be put to work to get ceph.com el6 (and other) builds. For el6
in particular there is also the option to help out the Centos Storage
SIG to produce builds. I don't have a good feeling which direction is
better ... maybe both.

-- Dan
CERN IT Storage Group


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
