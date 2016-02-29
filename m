From: Odintsov Vladislav <VlOdintsov@croc.ru>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 11:30:48 +0000
Message-ID: <1456745435596.21796@croc.ru>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
 <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
 <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
 <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
 <1456736629334.47610@croc.ru>,<191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ironport1.croc.ru ([195.38.23.101]:29488 "EHLO
	ironport1.croc.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbcB2Laj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 06:30:39 -0500
In-Reply-To: <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: "Franklin M. Siler" <me@franksiler.com>, Xiaoxi Chen <superdebuger@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, Sage Weil <sage@redhat.com>

Can you please provide right way for building rpm packages?

________________________________
Regards,

Vladislav Odintsov

________________________________________
From: Shinobu Kinjo <skinjo@redhat.com>
Sent: Monday, February 29, 2016 14:11
To: Odintsov Vladislav
Cc: Franklin M. Siler; Xiaoxi Chen; ceph-devel@vger.kernel.org; ceph-users; Sage Weil
Subject: Re: [ceph-users] v0.94.6 Hammer released

Can we make any kind of general procedure to make packages so that almost everyone in community build packages by themselves and reduce developers work load caused by too much requirement -;

Cheers,
Shinobu

----- Original Message -----
From: "Odintsov Vladislav" <VlOdintsov@croc.ru>
To: "Franklin M. Siler" <me@franksiler.com>, "Xiaoxi Chen" <superdebuger@gmail.com>
Cc: ceph-devel@vger.kernel.org, "ceph-users" <ceph-users@ceph.com>, "Sage Weil" <sage@redhat.com>
Sent: Monday, February 29, 2016 6:04:02 PM
Subject: Re: [ceph-users] v0.94.6 Hammer released

Hi all,

should we build el6 packages ourself or, it's hoped that these packages would be built officially by community?

________________________________
Regards,

Vladislav Odintsov

________________________________________
From: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel.org> on behalf of Franklin M. Siler <me@franksiler.com>
Sent: Friday, February 26, 2016 05:03
To: Xiaoxi Chen
Cc: Alfredo Deza; Dan van der Ster; Sage Weil; ceph-devel@vger.kernel.org; ceph-users
Subject: Re: [ceph-users] v0.94.6 Hammer released

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
314.799.9405--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
