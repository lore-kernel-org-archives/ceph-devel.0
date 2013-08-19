From: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Subject: RE: [ceph-users] Flapping osd / continuously reported as failed
Date: Tue, 20 Aug 2013 00:09:31 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9F0@MXMBON06.grupa.onet>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
	<CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet>
	<CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
	<CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet>
 <CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from onsmg02.portal.onet.pl ([213.180.131.212]:52986 "EHLO
	onsmg02.portal.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3HSWJj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 18:09:39 -0400
In-Reply-To: <CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com>
Content-Language: pl-PL
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?iso-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>, Sydor Bohdan <Bohdan.Sydor@grupaonet.pl>

Hi,
> Yes, it definitely can as scrubbing takes locks on the PG, which will prevent reads or writes while the message is being processed (which will involve the rgw index being scanned).
It is possible to tune scrubbing config for eliminate slow requests and marking osd down when large rgw bucket index is scrubbing?

--
Regards
Dominik

