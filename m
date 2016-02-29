From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 11:21:11 -0700
Message-ID: <CALqRxCxa1nA_FoJm_v=xQw62jakj_0sHySw=UyR-EqX4qrukdA@mail.gmail.com>
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
	<56D45CCC.8010608@dachary.org>
	<56D46889.3000406@suse.cz>
	<56D46D64.1060909@dachary.org>
	<CABZ+qqm+5Gi9QxCmD0mEdhFC5ndexTtXLV8pt0om6aLXVSn_CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34756 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbcB2SVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 13:21:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id p65so2996696wmp.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 10:21:12 -0800 (PST)
In-Reply-To: <CABZ+qqm+5Gi9QxCmD0mEdhFC5ndexTtXLV8pt0om6aLXVSn_CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Loic Dachary <loic@dachary.org>, Nathan Cutler <ncutler@suse.cz>, Odintsov Vladislav <VlOdintsov@croc.ru>, Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

On Mon, Feb 29, 2016 at 10:31 AM, Dan van der Ster <dan@vanderster.com> wrote:
> I think the real work will come if people starting asking for jewel
> builds on el6 and other old platforms.

Note that the GCC on EL6 does not support the newer C++ constructs in
Jewel (which is why we dropped el6 in the first place). There would be
some non-trivial work to make a Jewel version run on el6. Some ideas
that have been proposed in the past include using an el6 SCL that
contains a newer GCC, or maybe stripping out the client bits to see if
they would build alone via the el6 GCC.

- Ken
