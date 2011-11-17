From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: v0.38 released
Date: Thu, 17 Nov 2011 10:01:21 -0800
Message-ID: <CAORUGqA2HJQFXM01mq29TcSTK9p7OxLDGa9s85OfkbgWALnu7w@mail.gmail.com>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
 <20111115164254.GJ13394@systemlinux.org> <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
 <20111116095614.GK13394@systemlinux.org> <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
 <20111117103524.GL13394@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56869 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1KQSBn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Nov 2011 13:01:43 -0500
Received: by wwe3 with SMTP id 3so3755038wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Nov 2011 10:01:42 -0800 (PST)
In-Reply-To: <20111117103524.GL13394@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Nov 17, 2011 at 02:35, Andre Noll <maan@systemlinux.org> wrote:
> I was under the impression that equal weights on all osds means to
> fill up all file systems by the same percentage, i.e. that file syste=
m
> sizes are already taken care of.
>
> But apparently this is not the case. =C2=A0So one has to set the weig=
hts
> manually according to the available disk space.

The weight is actually a combination of all the factors that would go
in: storage size, disk IO speed, network link bandwidth, heat in that
part of the data center, future expansion plans, .. We could automate
more of it, but it really is a fundamentally holistic number, and
setting it based on just one aspect of reality will lead to someone
else being unhappy. So it goes something like this:

Step 1: improve documentation
Step 2: have a monitoring system be able to feed back information to
use as osd weights, with admin customazability
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
