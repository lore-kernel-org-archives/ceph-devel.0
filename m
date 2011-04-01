From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: The installation: When we start Ceph, the system stops running.
Date: Fri, 1 Apr 2011 09:42:11 -0700
Message-ID: <20110401164211.GA12619@dreamer>
References: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38748 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164Ab1DAQmN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2011 12:42:13 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?6Zmz5puJ6JaH?= <doki74216@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 01, 2011 at 02:53:55PM +0800, =E9=99=B3=E6=9B=89=E8=96=87 w=
rote:
> Hi,
> I set an environment of 20 servers which include 2 MDSs, 3 MONs and 1=
5
> OSDes.
> My version is 0.25.2 and OS is Fedora 14.
> There's a problem when I was installing the Ceph.
> When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
> -k keyring.bin" .
> I start the whole Ceph system.
> But here is the problem I met:
> The system stops running and it shows the error messages as shown bel=
ow:

Hi. I see Henry already replied, with good ideas. If that was not
enough to get you going -- especially the part about making sure no
ceph daemons are left running from a previous attempt -- please share
your config file. You might e.g. have two cmon daemons trying to bind
to the same port.

--=20
:(){ :|:&};:
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
