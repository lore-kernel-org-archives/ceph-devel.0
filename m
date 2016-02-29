From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 16:49:29 +0100
Message-ID: <56D46889.3000406@suse.cz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36911 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbcB2Pth (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Feb 2016 10:49:37 -0500
In-Reply-To: <56D45CCC.8010608@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Dan van der Ster <dan@vanderster.com>, Odintsov Vladislav <VlOdintsov@croc.ru>, Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

> The basic idea is to copy the packages that are build by gitbuilders or by the buildpackage teuthology task in a central place. Because these packages are built, for development versions as well as stable versions[2]. And they are tested via teuthology. The packages that are published on http://ceph.com/ are rebuilt from scratch, using the process that Alfredo described. This is fine for the supported platforms and for the stable releases. But for the development releases and the platforms that are no longer supported but still built by gibuilders, we could just copy the packages over.
>
> Does that sound sensible ?

Hi Loic:

Community packages for "deprecated" platforms ("deprecated" in the sense 
that the Ceph developers are no longer testing on them) would be 
welcomed by many, I imagine. And the additional workload for the Stable 
Releases team is not large. The question is, where will the packages be 
copied *to*?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
