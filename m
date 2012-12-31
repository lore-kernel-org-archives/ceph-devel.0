From: Wido den Hollander <wido@widodh.nl>
Subject: Re: what could go wrong with two clusters on the same network?
Date: Mon, 31 Dec 2012 19:27:48 +0100
Message-ID: <50E1D924.3060505@widodh.nl>
References: <50E1662D.6000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:34399 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2LaS1t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 13:27:49 -0500
In-Reply-To: <50E1662D.6000607@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 12/31/2012 11:17 AM, Xiaopong Tran wrote:
> Hi,
>
> If I run two clusters on the same network, each with its own set of
> monitors and config files (assuming that we didn't make any error
> in the config files), would there be anything wrong with that?
>
> Ceph seems to be quite chatty, so would they mess up their
> messages?
>

Ceph is chatty, but it doesn't "pollute" your network.

OSDs only talk to other OSDs they learn from the monitors.

Ceph doesn't use broadcast or multicast in your local network, so it's 
safe to run multiple Ceph clusters in one subnet/VLAN.

Just make sure you use cephx (enabled by default in 0.55) so that you 
don't accidentally connect to the wrong cluster.

Wido

> Just want to make sure, and just want to know if anyone is
> doing that.
>
> Thanks
>
> Xiaopong
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
