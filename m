From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 13:46:31 -0700
Message-ID: <CANLRBoyP6TmjA8BPgXR4DE1O6ux_U+AAoU3i2jFW6yjU415KyA@mail.gmail.com>
References: <503D0A00.2080905@inktank.com>
	<20120828185116.GC9872@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43740 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2H1Uqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 16:46:32 -0400
Received: by vcbfk26 with SMTP id fk26so6412534vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 13:46:31 -0700 (PDT)
In-Reply-To: <20120828185116.GC9872@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 28, 2012 at 11:51 AM, Dieter Kasper <d.kasper@kabelmail.de> wrote:
> Hi Ross,
>
> focusing on core stability and feature expansion for RBD was the right appoach
> in the past and I feel you have reached an adequate maturity level here.
>
> Performance enhancements - especially to reduce the latency of a single IO / increase IOPS -
> and a stronger engagement on the CephFS client would be very much appreciated.
> A stable and fast CephFS client would allow an efficient integration with
> - (clustered) NFS (v3 and v4)
> - (clustered) Samba v4

+1 to CephFS being worked on. Things like the multi-mds being improved
upon would be amazing.

Regards,

Tren
