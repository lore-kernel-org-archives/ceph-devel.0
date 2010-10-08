From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Fri, 08 Oct 2010 11:05:14 -0500
Message-ID: <4CAF413A.1000407@codemonkey.ws>
References: <20100802194631.GA4923@chb-desktop>	<alpine.LNX.2.00.1008030033550.2664@linmac>	<20100803201407.GD1475@chb-desktop>	<4CADD567.9010606@codemonkey.ws>	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>	<4CAE13BA.70707@codemonkey.ws>	<AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>	<4CAE24C5.8030007@codemonkey.ws>	<AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>	<4CAE35C5.2010809@codemonkey.ws>	<AANLkTinzdiJZFxacD1BDCPWt44ChokNaNVU6_E=GtcTD@mail.gmail.com>	<4CAE41BD.2070508@codemonkey.ws>	<Pine.LNX.4.64.1010071518120.11342@cobra.newdream.net>	<4CAF255A.1030103@codemonkey.ws> <AANLkTinim=+MebUgSkpn2d2C2vY2bREwBor4xCf27s6n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47471 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0JHQFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 12:05:17 -0400
In-Reply-To: <AANLkTinim=+MebUgSkpn2d2C2vY2bREwBor4xCf27s6n@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

On 10/08/2010 10:50 AM, Yehuda Sadeh Weinraub wrote:
> Oh, that makes it more clean. Considering that we did it for kvm, and
> looking at the kvm qemu_bh_schedule() implementation, it does look
> thread safe (there might be an issue though with canceling the bh
> though, haven't looked at it, not really relevant).

It's definitely not thread safe.  Even though you can set the flag 
atomically (not guaranteed, but assume you can), we rely on the fact 
that we can check for pending BHs before entering sleep without having 
to worry about new BHs being scheduled in between the sleep and the 
check.  If you schedule a BH in a thread then you open yourself up to 
the race.

Regards,

Anthony Liguori

