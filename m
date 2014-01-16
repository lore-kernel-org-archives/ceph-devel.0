From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: v0.75 released
Date: Thu, 16 Jan 2014 15:51:17 +0200
Message-ID: <CALFYKtAz5G4y1RUoqJmyr5psuh1NvD=E_7qSPm7WL+8Ra_bJ5A@mail.gmail.com>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:51876 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaAPNvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jan 2014 08:51:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id d13so3685064wiw.13
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jan 2014 05:51:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

On Wed, Jan 15, 2014 at 5:42 AM, Sage Weil <sage@inktank.com> wrote:
>
> [...]
>
> * rbd: support for 4096 mapped devices, up from ~250 (Ilya Dryomov)

Just a note, v0.75 simply adds some of the infrastructure, the actual
support for this will arrive with kernel 3.14.  The theoretical limit
is 65536 mapped devices, although I admit I haven't tried mapping more
than ~4000 at once.

Thanks,

                Ilya
