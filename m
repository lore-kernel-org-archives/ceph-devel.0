From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Some findings on 0.48, qemu-1.0.1 eating up RDB-write-cache memory
Date: Mon, 09 Jul 2012 20:16:17 +0200
Message-ID: <4FFB1FF1.4050308@profihost.ag>
References: <4FFAC001.4020503@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35301 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab2GISQV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 14:16:21 -0400
In-Reply-To: <4FFAC001.4020503@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

Am 09.07.2012 13:26, schrieb Oliver Francke:
> After doing some normal IOps testing with:
>      spew -v --raw -P -t -i 5 -b 4k -p random -B 4k 2G /tmp/doof.dat
>
> so a 2G file, tested for IOps-performance with 4k blocks I get a pretty
> good value for 5x write/read-after-write:

Just be interested as i'm still trying to get good IOps values. Have you 
tried with a 200GB File / whole block device?

Stefan
