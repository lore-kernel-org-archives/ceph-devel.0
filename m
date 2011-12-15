From: =?UTF-8?B?SmVucyBSZWhww7ZobGVy?= <jens.rehpoehler@filoo.de>
Subject: Re: ceph -w output
Date: Thu, 15 Dec 2011 10:45:15 +0100
Message-ID: <4EE9C1AB.2010403@filoo.de>
References: <4EE654A3.1040309@filoo.de> <CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com> <4EE8601F.90206@filoo.de> <CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:42253 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab1LOJpS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 04:45:18 -0500
In-Reply-To: <CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

Am 14.12.2011 17:43, schrieb Tommi Virtanen:
> On Wed, Dec 14, 2011 at 00:36, Jens Rehp=C3=B6hler <jens.rehpoehler@f=
iloo.de> wrote:
>> Attached you will find the output you asked for. Is there any limita=
tion
>> on the amount of pools ? We create
>> pools for every customer and store their VM images in that pools. So=
 we
>> will create a lot of pools over time.
> Each pool gets its own set of PGs (Placement Groups). An OSD that
> manages too many PGs will use a lot of RAM. What is "too many" is
> debatable, and really up to benchmarks, but considering we recommend
> about 100 PGs/OSD as a starting point, you probably don't want to go
> two orders of magnitude above that.
Ok .... that will serve our needs. Remains only the "creating" question=
=2E

Any answers to that ?

Thanks a lot !

Jens

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
