From: udit agarwal <fzdudit@gmail.com>
Subject: Re: iozone test crashed on ceph
Date: Wed, 6 Jun 2012 02:31:56 +0000 (UTC)
Message-ID: <loom.20120606T041909-114@post.gmane.org>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com> <loom.20120604T235042-446@post.gmane.org> <CADvuQRFRsc24feZFbQYo7Rkg=ot4PF7j9VCEFDO2PJq3AGkzsw@mail.gmail.com> <loom.20120605T012913-573@post.gmane.org> <loom.20120605T014157-339@post.gmane.org> <CADvuQRHMxM9PxOyxmej9_MuJajGNV2=yBxL9vN7P4KEvA7US5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57749 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709Ab2FFCcO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jun 2012 22:32:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sc62d-0004AD-8m
	for ceph-devel@vger.kernel.org; Wed, 06 Jun 2012 04:32:12 +0200
Received: from en-439-0215-006.esc.auckland.ac.nz ([130.216.209.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 04:32:11 +0200
Received: from fzdudit by en-439-0215-006.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 04:32:11 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
 Thanks for your reply.
 After you hinted that this problem may have caused due to using record size of
length 4k. Then, I ran iozone test on a 5m file with record length 4k and to my
surprise, the ceph system again hanged up. Then, I tried same with record
lengths from 8k to 1m and everything worked fine for these cases with 5 MB file.
Now, I have already executed the iozone test with 5G file and with record sizes
from 8k to 16m and will see what happens!!

--Udit Agarwal

