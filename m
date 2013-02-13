From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 21:27:18 +0100
Message-ID: <511BF726.9030606@profihost.ag>
References: <511AA47B.3020309@profihost.ag> <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com> <511B46A2.4060107@profihost.ag> <alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net> <511BE8AC.3090600@profihost.ag> <alpine.DEB.2.00.1302131220570.20247@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:56370 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab3BMU1U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 15:27:20 -0500
In-Reply-To: <alpine.DEB.2.00.1302131220570.20247@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 13.02.2013 21:21, schrieb Sage Weil:
>> This results in writes up to 400Mb/s per OSD and then results in aborted /
>> hanging task in VMs. Is it possible to give trim commands lower priority?
>
> Is that 400Mb or MB?  Measured over the network, or on the disk itself?

Sorry it's MB - so the SSDs get fully utilized meased via /proc/diskstats .

> I'm wondering if this is a lack of punch support on the kernel..
I'm using 3.7.7 running XFS.

Greets,
Stefan
