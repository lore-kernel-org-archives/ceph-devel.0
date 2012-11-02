From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: RBD trim / unmap support?
Date: Fri, 02 Nov 2012 21:13:23 +0100
Message-ID: <50942963.1020700@profihost.ag>
References: <509306CC.5080307@profihost.ag> <5093078C.4020404@inktank.com> <50938233.9090902@profihost.ag> <50938DA0.6090205@profihost.ag> <5093F1F6.5040502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43940 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2KBUNV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 16:13:21 -0400
In-Reply-To: <5093F1F6.5040502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


>> [   75.480358] end_request: I/O error, dev sdc, sector 50331642
>> [   75.496374] sd 2:0:0:4: [sdc]
>> [   75.497202] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>> [   75.498077] sd 2:0:0:4: [sdc]
>> [   75.498948] Sense Key : Aborted Command [current]
>> [   75.499818] sd 2:0:0:4: [sdc]
>> [   75.500374] Add. Sense: I/O process terminated
>> [   75.500374] sd 2:0:0:4: [sdc] CDB:
>> [   75.500374] Write same(16): 93 08 00 00 00 00 03 7f ff f9 00 7f ff ff
>> 00 00
>> [   75.500374] end_request: I/O error, dev sdc, sector 58720249
>
> Could you add 'debug ms = 1', 'debug rbd = 20', and 'log file =
> /tmp/librbd.log' to the [client] section of your ceph.conf?
>
> That log should tell us where the error is happening.

Thanks - here it comes:
https://www.dropbox.com/s/blegk8u14n30ntq/librbd.log.gz

Hope that helps and we can fix it before 0.54.

Greets
Stefan
