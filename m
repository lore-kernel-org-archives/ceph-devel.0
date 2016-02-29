From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 18:31:21 +0100
Message-ID: <CABZ+qqm+5Gi9QxCmD0mEdhFC5ndexTtXLV8pt0om6aLXVSn_CA@mail.gmail.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
 <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
 <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com> <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com> <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
 <1456745435596.21796@croc.ru> <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
 <56D45CCC.8010608@dachary.org> <56D46889.3000406@suse.cz> <56D46D64.1060909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35749 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbcB2RcI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 12:32:08 -0500
Received: by mail-lb0-f178.google.com with SMTP id bc4so84243597lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 09:32:06 -0800 (PST)
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com. [209.85.215.54])
        by smtp.gmail.com with ESMTPSA id g5sm4228379lfe.42.2016.02.29.09.32.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 09:32:02 -0800 (PST)
Received: by mail-lf0-f54.google.com with SMTP id j78so96270634lfb.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 09:32:02 -0800 (PST)
In-Reply-To: <56D46D64.1060909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Odintsov Vladislav <VlOdintsov@croc.ru>, Shinobu Kinjo <skinjo@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Franklin M. Siler" <me@franksiler.com>, Sage Weil <sage@redhat.com>, Xiaoxi Chen <superdebuger@gmail.com>, ceph-users <ceph-users@ceph.com>

If it can help, it's really very little work for me to send the hammer
SRPM to our Koji build system.

I think the real work will come if people starting asking for jewel
builds on el6 and other old platforms. In that case, if a reputable
organisation offers to maintain the builds (+ deps), then IMHO
ceph.com should just link to them. Copying to ceph.com might give a
false sense of security in this case.

-- Dan


On Mon, Feb 29, 2016 at 5:10 PM, Loic Dachary <loic@dachary.org> wrote:
> I've created a pad at http://pad.ceph.com/p/development-releases for =
the next CDM ( see http://tracker.ceph.com/projects/ceph/wiki/Planning =
for details).
>
> On 29/02/2016 22:49, Nathan Cutler wrote:
>> The basic idea is to copy the packages that are build by gitbuilders=
 or by the buildpackage teuthology task in a central place. Because the=
se packages are built, for development versions as well as stable versi=
ons[2]. And they are tested via teuthology. The packages that are publi=
shed on http://ceph.com/ are rebuilt from scratch, using the process th=
at Alfredo described. This is fine for the supported platforms and for =
the stable releases. But for the development releases and the platforms=
 that are no longer supported but still built by gibuilders, we could j=
ust copy the packages over.
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
