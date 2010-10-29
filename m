From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: Ceph and bonnie++
Date: Fri, 29 Oct 2010 15:37:46 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6958@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail2.alcatel.fr ([64.208.49.57]:47443 "EHLO smail2.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab0J2NiD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 09:38:03 -0400
Received: from FRMRSSXCHHUB02.dc-m.alcatel-lucent.com (FRMRSSXCHHUB02.dc-m.alcatel-lucent.com [135.120.45.62])
	by smail2.alcatel.fr (8.14.3/8.14.3/ICT) with ESMTP id o9TDbQ9P001292
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 29 Oct 2010 15:37:56 +0200
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi

ceph version 0.23~rc (commit:a869b35abdab37bd4505f435bf0f7ab1860b28cc)

client0:/mnt/ceph# bonnie -s 40 -r 10 -u root -f
Using uid:0, gid:0.
Writing intelligently...done
Rewriting...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...Expected 16384 files but only got 0
Cleaning up test directory after error.


Any suggestions? There was a thread about this some time ago: 

http://www.mail-archive.com/ceph-devel@lists.sourceforge.net/msg00170.html


Thanks!