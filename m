From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 14:35:49 +0200
Message-ID: <CAF6-1L4sVnMsx79APO5X0zEEUyDoBD2PUvjTZw6Gzb7rgfpKkg@mail.gmail.com>
References: <503D0A00.2080905@inktank.com>
	<CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
	<503DE69B.70804@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43141 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2H2Mft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 08:35:49 -0400
Received: by vcbfk26 with SMTP id fk26so511088vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 05:35:49 -0700 (PDT)
In-Reply-To: <503DE69B.70804@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Correct me if I'm wrong, but when I was at Citrix in May this year somebody
> there told me that Xen was going 100% Qemu?

Huh ... I've never heard this. Also the guys in ##xen haven't either.
I'm not really involved in xen dev and don't follow it closely but
that seems unlikely. The few slides I looked at from the Xen Summit a
couple days ago show that they really like their PV model.

AFAIK QEMU is only used for HVM guests to emulate the hw. And even for
those HVM guest, it's recommended to use PV drivers for performance
which bypass the qemu layer all together.

Cheers,

    Sylvain
