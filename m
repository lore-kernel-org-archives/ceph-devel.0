From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph -w output
Date: Wed, 14 Dec 2011 08:43:05 -0800
Message-ID: <CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com>
References: <4EE654A3.1040309@filoo.de> <CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com>
 <4EE8601F.90206@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49655 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab1LNQn1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 11:43:27 -0500
Received: by faar15 with SMTP id r15so1362145faa.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 08:43:26 -0800 (PST)
In-Reply-To: <4EE8601F.90206@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Rehp=C3=B6hler?= <jens.rehpoehler@filoo.de>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, Dec 14, 2011 at 00:36, Jens Rehp=C3=B6hler <jens.rehpoehler@fil=
oo.de> wrote:
> Attached you will find the output you asked for. Is there any limitat=
ion
> on the amount of pools ? We create
> pools for every customer and store their VM images in that pools. So =
we
> will create a lot of pools over time.

Each pool gets its own set of PGs (Placement Groups). An OSD that
manages too many PGs will use a lot of RAM. What is "too many" is
debatable, and really up to benchmarks, but considering we recommend
about 100 PGs/OSD as a starting point, you probably don't want to go
two orders of magnitude above that.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
