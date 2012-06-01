From: udit agarwal <fzdudit@gmail.com>
Subject: iozone test crashed on ceph
Date: Fri, 1 Jun 2012 00:58:11 +0000 (UTC)
Message-ID: <loom.20120601T025228-787@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49082 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932954Ab2FABFR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 May 2012 21:05:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SaGIZ-0001gP-QY
	for ceph-devel@vger.kernel.org; Fri, 01 Jun 2012 03:05:09 +0200
Received: from mike-alien.esc.auckland.ac.nz ([130.216.209.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 03:05:03 +0200
Received: from fzdudit by mike-alien.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 03:05:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
 I have set up ceph system with a client, mon and mds on one system which is
connected to 2 osds. I ran iozone test with a 10G file and it ran fine. But when
I ran iozone test with a 5G file, the process got killed and our ceph system
hanged. Can anyone please help me with this.

 Thanks in advance.

--Udit

