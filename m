From: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Subject: start-stop-daemon radosgw
Date: Mon, 20 Jul 2015 09:58:57 +0000
Message-ID: <68A06213B74F1742A2C48216AE1BB6B8088009A6@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0074.outbound.protection.outlook.com ([157.56.110.74]:7751
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751612AbbGTKOp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 06:14:45 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Srinivasula Maram <Srinivasula.Maram@sandisk.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>

[Resending in plain text format, apologies for the spam]

Hi,

This is with reference to the commit https://github.com/ceph/ceph/commit/f30fa4a364602fb9412babf7319140eca4c64995 and tracker http://tracker.ceph.com/issues/11453

On Hammer binaries, we are finding this fix has regressed to have multiple RGW instances to be run on a single machine. Meaning, with no user specified under 'client.radosgw.gateway' sections, and by having the default user to be assumed as 'root', we are unable to get multiple RGW daemons run on a client machine.

The start-stop-daemon complains than an instance of 'radosgw' is already running, by starting the first daemon in the configuration and bails out from starting further instances:

<snip>

+ start-stop-daemon --start -u root -x /usr/bin/radosgw -- -n client.radosgw.gateway-3
/usr/bin/radosgw already running.

<\snip>

However, by having a user specified in the relevant 'client.radosgw.gateway' sections, one can get around this issue. Wanted to confirm if this is indeed a regression or was it expected to behave so from the fix.

Thanks,
-Pavan.


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

