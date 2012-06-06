From: udit agarwal <fzdudit@gmail.com>
Subject: Re: iozone test crashed on ceph
Date: Wed, 6 Jun 2012 04:15:31 +0000 (UTC)
Message-ID: <loom.20120606T060500-193@post.gmane.org>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com> <loom.20120604T235042-446@post.gmane.org> <CADvuQRFRsc24feZFbQYo7Rkg=ot4PF7j9VCEFDO2PJq3AGkzsw@mail.gmail.com> <loom.20120605T012913-573@post.gmane.org> <loom.20120605T014157-339@post.gmane.org> <CADvuQRHMxM9PxOyxmej9_MuJajGNV2=yBxL9vN7P4KEvA7US5A@mail.gmail.com> <loom.20120606T041909-114@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37150 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab2FFEP7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 00:15:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sc7er-00021J-0r
	for ceph-devel@vger.kernel.org; Wed, 06 Jun 2012 06:15:49 +0200
Received: from en-439-0215-006.esc.auckland.ac.nz ([130.216.209.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 06:15:45 +0200
Received: from fzdudit by en-439-0215-006.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 06:15:45 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
 Thank you all for your support in resolving the issue. As I mentioned in my
previous post that I ran my iozone test again on a 5G file excluding the 4k
record size. And now, I have successfully completed this test with record sizes
of 8k and 16k and hopefully all others will also work fine. But I am still
confused with the failure of the iozone test on 5G & 5M file with record size
4k, while it worked happily for files of sizes 10M & 10G.

 Can anyone help me with this problem with suitable reasons??
 Thanks in advance.

--Udit Agarwal



