From: "Franklin M. Siler" <me@franksiler.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Thu, 25 Feb 2016 20:03:38 -0600
Message-ID: <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com> <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com> <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com> <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com> <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33272 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcBZCDm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 21:03:42 -0500
Received: by mail-ig0-f176.google.com with SMTP id y8so28329353igp.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 18:03:42 -0800 (PST)
In-Reply-To: <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Alfredo Deza <adeza@redhat.com>, Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>


On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger@gmail.com> wrote:

> Will we build package for ubuntu 12.04 (Precise)?
> Seems it also doesnt show in the repo

The Ceph packages provided by Ubuntu are old.  However, the Ceph project publishes its own packages.  

http://download.ceph.com/debian-hammer/dists/precise/

so repo lines for sources.list would be, I think:

deb http://download.ceph.com/debian-hammer/ precise main
deb-src http://download.ceph.com/debian-hammer/ precise main


Cheers,

Frank Siler
Siler Industrial Analytics
314.799.9405