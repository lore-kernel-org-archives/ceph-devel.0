From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] librados: Bump the version to 0.48
Date: Thu, 05 Jul 2012 09:26:26 +0200
Message-ID: <4FF541A2.4000003@widodh.nl>
References: <1341409564-26660-1-git-send-email-wido@widodh.nl> <6ED535BAF3394911BDF4F16441761D6A@inktank.com> <Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38194 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2GEH02 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 03:26:28 -0400
In-Reply-To: <Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org



On 07/04/2012 06:33 PM, Sage Weil wrote:
> On Wed, 4 Jul 2012, Gregory Farnum wrote:
>> Hmmm =FF=FF we generally try to modify these versions when the API c=
hanges,
>> not on every sprint. It looks to me like Sage added one function in =
0.45
>> where we maybe should have bumped it, but that was a long time ago a=
nd
>> at this point we should maybe just eat it?
>
> Yeah, I went ahead and applied this to stable (argonaut) since it's a=
s
> good a reference point as any.  Moving forward, we should try to sync
> this up with API changes as they happen.  Hmm, like that assert
> ObjectOperation that just went into master...

That was my reasoning. I compiled phprados against 0.48 and saw that=20
librados was reporting 0.44 as version.

That could confuse users and they might think they still have an old=20
library in place.

Imho the version numbering should be totally different from Ceph if you=
=20
only want to bump the version on an API change.

Wido

>
> sage
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
