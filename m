From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: RBD trim / unmap support?
Date: Sun, 11 Nov 2012 13:08:24 +0100
Message-ID: <509F9538.8090803@profihost.ag>
References: <509306CC.5080307@profihost.ag> <5093078C.4020404@inktank.com> <50938233.9090902@profihost.ag> <50938DA0.6090205@profihost.ag> <5093F1F6.5040502@inktank.com> <50999301.3040108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58397 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKMIZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Nov 2012 07:08:25 -0500
In-Reply-To: <50999301.3040108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Still nobody who can help with the broken unmap support of rbd?

Greets,
Stefan

Am 06.11.2012 23:45, schrieb Stefan Priebe:
> Am 02.11.2012 17:16, schrieb Josh Durgin:
>> On 11/02/2012 02:08 AM, Stefan Priebe - Profihost AG wrote:
>>> Hi Jost,
>>>
>>> i tried scsi-hd with discard_granularity=512 the UNMAP / Trim itself
>>> works fine the space is freed at ceph but at the VM i'm getting:
>>> [   75.076895] sd 2:0:0:4: [sdc]
>>> [   75.078353] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.079377] sd 2:0:0:4: [sdc]
>>> [   75.080410] Sense Key : Aborted Command [current]
>>> [   75.081446] sd 2:0:0:4: [sdc]
>>> [   75.082459] Add. Sense: I/O process terminated
>>> [   75.083466] sd 2:0:0:4: [sdc] CDB:
>>> [   75.084473] Write same(16): 93 08 00 00 00 00 00 00 00 00 00 7f ff ff
>>> 00 00
>>> [   75.085535] end_request: I/O error, dev sdc, sector 0
>>> [   75.086567] sd 2:0:0:4: [sdc]
>>> [   75.087569] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.088605] sd 2:0:0:4: [sdc]
>>> [   75.089610] Sense Key : Aborted Command [current]
>>> [   75.090630] sd 2:0:0:4: [sdc]
>>> [   75.091631] Add. Sense: I/O process terminated
>>> [   75.092621] sd 2:0:0:4: [sdc] CDB:
>>> [   75.093579] Write same(16): 93 08 00 00 00 00 00 7f ff ff 00 7f ff ff
>>> 00 00
>>> [   75.094581] end_request: I/O error, dev sdc, sector 8388607
>>> [   75.095558] sd 2:0:0:4: [sdc]
>>> [   75.096561] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.097553] sd 2:0:0:4: [sdc]
>>> [   75.098520] Sense Key : Aborted Command [current]
>>> [   75.099484] sd 2:0:0:4: [sdc]
>>> [   75.100471] Add. Sense: I/O process terminated
>>> [   75.101439] sd 2:0:0:4: [sdc] CDB:
>>> [   75.102432] Write same(16): 93 08 00 00 00 00 00 ff ff fe 00 7f ff ff
>>> 00 00
>>> [   75.103464] end_request: I/O error, dev sdc, sector 16777214
>>> [   75.104503] sd 2:0:0:4: [sdc]
>>> [   75.105507] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.106514] sd 2:0:0:4: [sdc]
>>> [   75.107525] Sense Key : Aborted Command [current]
>>> [   75.108545] sd 2:0:0:4: [sdc]
>>> [   75.109525] Add. Sense: I/O process terminated
>>> [   75.110487] sd 2:0:0:4: [sdc] CDB:
>>> [   75.111418] Write same(16): 93 08 00 00 00 00 01 7f ff fd 00 7f ff ff
>>> 00 00
>>> [   75.112419] end_request: I/O error, dev sdc, sector 25165821
>>> [   75.238627] sd 2:0:0:4: [sdc]
>>> [   75.239946] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.241197] sd 2:0:0:4: [sdc]
>>> [   75.242097] Sense Key : Aborted Command [current]
>>> [   75.242627] sd 2:0:0:4: [sdc]
>>> [   75.242627] Add. Sense: I/O process terminated
>>> [   75.242627] sd 2:0:0:4: [sdc] CDB:
>>> [   75.242627] Write same(16): 93 08 00 00 00 00 01 ff ff fc 00 7f ff ff
>>> 00 00
>>> [   75.242627] end_request: I/O error, dev sdc, sector 33554428
>>> [   75.447311] sd 2:0:0:4: [sdc]
>>> [   75.448505] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.449392] sd 2:0:0:4: [sdc]
>>> [   75.450262] Sense Key : Aborted Command [current]
>>> [   75.451134] sd 2:0:0:4: [sdc]
>>> [   75.451312] Add. Sense: I/O process terminated
>>> [   75.451312] sd 2:0:0:4: [sdc] CDB:
>>> [   75.451312] Write same(16): 93 08 00 00 00 00 02 7f ff fb 00 7f ff ff
>>> 00 00
>>> [   75.451312] end_request: I/O error, dev sdc, sector 41943035
>>> [   75.476364] sd 2:0:0:4: [sdc]
>>> [   75.477252] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.478135] sd 2:0:0:4: [sdc]
>>> [   75.479004] Sense Key : Aborted Command [current]
>>> [   75.479891] sd 2:0:0:4: [sdc]
>>> [   75.480358] Add. Sense: I/O process terminated
>>> [   75.480358] sd 2:0:0:4: [sdc] CDB:
>>> [   75.480358] Write same(16): 93 08 00 00 00 00 02 ff ff fa 00 7f ff ff
>>> 00 00
>>> [   75.480358] end_request: I/O error, dev sdc, sector 50331642
>>> [   75.496374] sd 2:0:0:4: [sdc]
>>> [   75.497202] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [   75.498077] sd 2:0:0:4: [sdc]
>>> [   75.498948] Sense Key : Aborted Command [current]
>>> [   75.499818] sd 2:0:0:4: [sdc]
>>> [   75.500374] Add. Sense: I/O process terminated
>>> [   75.500374] sd 2:0:0:4: [sdc] CDB:
>>> [   75.500374] Write same(16): 93 08 00 00 00 00 03 7f ff f9 00 7f ff ff
>>> 00 00
>>> [   75.500374] end_request: I/O error, dev sdc, sector 58720249
>>
>> Could you add 'debug ms = 1', 'debug rbd = 20', and 'log file =
>> /tmp/librbd.log' to the [client] section of your ceph.conf?
>>
>> That log should tell us where the error is happening.
>
> Paolo from Redhat / qemu means:
>
> "
> The discard request is failing.  Please check why with a breakpoint on
> rbd_aio_discard_wrapper or scsi_handle_rw_error for example.
> "
>
> Greets,
> Stefan
