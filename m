From: Gregory Farnum <greg@inktank.com>
Subject: Re: Windows port
Date: Tue, 8 Jan 2013 09:08:49 -0800
Message-ID: <CAPYLRziODEGsrvs4hFJ0SfnYPafRhE_SFTAyjJgCqWt-0t9Hdw@mail.gmail.com>
References: <CAJVE5RWjv9ZVpTX5rxB1dL7bDSCtqkfr-Ac5m0hEnprANpwu0Q@mail.gmail.com>
	<CAJVE5RV-JZzK7Ofe9q2whcxp1eHquE_A2YELof8TAzBVjcsfgQ@mail.gmail.com>
	<CA+GnOzR29oKSXWpuS8dffsXJWChzMvTCFQ+dutmAm+zsuVkBgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:55301 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231Ab3AHRIv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 12:08:51 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so867906qcp.12
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 09:08:51 -0800 (PST)
In-Reply-To: <CA+GnOzR29oKSXWpuS8dffsXJWChzMvTCFQ+dutmAm+zsuVkBgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dino Yancey <dino2gnt@gmail.com>
Cc: Cesar Mello <cmello@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 7, 2013 at 9:36 PM, Cesar Mello <cmello@gmail.com> wrote:
> Hi,
>
> I have been playing with ceph and reading the docs/thesis the last
> couple of nights just to learn something during my vacation. I was no=
t
> expecting to find such an awesome and state of the art project.
> Congratulations for the great work!
>
> Please I would like to know if a Windows port is imagined for the
> future or if that is a dead-end. By Windows port I mean an abstractio=
n
> layer for hardware/sockets/threading/etc and building with Visual C++
> 2012 Express. And then have this state of the art object storage
> cluster running on Windows nodes too.

This is not super-likely (although it's not impossible either).
Inktank is a long way from doing the necessary development for this =97
we don't have any Windows developers on staff. External contributors
who are interested in doing the work themselves would certainly get
some support in doing so, but I can't even begin to estimate the size
of the project that would be required. Would a simple abstraction
layer be able to provide the right interface with anything approaching
acceptable performance? I really don't know.


On Tue, Jan 8, 2013 at 6:00 AM, Dino Yancey <dino2gnt@gmail.com> wrote:
> Hi,
>
> I am also curious if a Windows port, specifically the client-side, is
> on the roadmap.

This is somewhat more likely than porting the servers, but again we at
Inktank don't currently have the expertise necessary. It'd be a lot
easier if there were a FUSE for Windows; that's how we'll be getting
an OS X client.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
