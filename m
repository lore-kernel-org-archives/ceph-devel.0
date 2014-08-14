From: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>
Subject: RE: Is that possible to run teuthology on local test servers
Date: Thu, 14 Aug 2014 05:26:31 +0000
Message-ID: <085BC98701B92B4C86AE7696562D284D0529FBB5@SACMBXIP01.sdcorp.global.sandisk.com>
References: <53EC2446.3020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:10513
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752506AbaHNF1D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 01:27:03 -0400
In-Reply-To: <53EC2446.3020708@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: guping <magicgup@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I had gotten teuthology to work some time back to a reasonable extent in my local setup with a few quick ugly hacks. The main set of changes were,

1. Explicitly named my test systems as "plana01" , "plana02" & "plana03". Some of the teuthology code which checks for VM instances does compare with known set/class of machine names
2. In lock_machines() routine (teuthology/task/internal.py), set ctx.config['targets'] as follows:
    mydict['myuser@plana01'] = 'ssh-rsa <my_ssh_key1>'
    mydict['myuser@plana02'] = 'ssh-rsa <my_ssh_key2>' and so on..
   ctx.config['targets'] = mydict
3. Comment out the reporting code in teuthology/report.py

There were a few other minor changes like disabling teuthology branch checkout etc.

Thanks,
Viju



-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of guping
Sent: Thursday, August 14, 2014 8:22 AM
To: ceph-devel@vger.kernel.org
Subject: Is that possible to run teuthology on local test servers

I read the doc on the github teuthology, but still can not figure out how to run teuthology on my local test servers.
Any experience? Any advice?

--
Thanks,
Gu Ping

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

