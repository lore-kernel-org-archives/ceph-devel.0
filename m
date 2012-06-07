From: udit agarwal <fzdudit@gmail.com>
Subject: setting up virtual machines with ceph
Date: Thu, 7 Jun 2012 06:56:58 +0000 (UTC)
Message-ID: <loom.20120607T085432-245@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51652 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab2FGG5M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 02:57:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ScWeb-0005Wj-4D
	for ceph-devel@vger.kernel.org; Thu, 07 Jun 2012 08:57:10 +0200
Received: from en-439-0215-006.esc.auckland.ac.nz ([130.216.209.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 08:57:09 +0200
Received: from fzdudit by en-439-0215-006.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 08:57:09 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
 I have set up ceph system with a client, mon and mds on one system whi=
ch is
connected to 2 osds. . The ceph setup worked fine and I did some tests =
on it and
they too worked fine. Now, I want to set up virtual machines on my syst=
em and
want to run multiple virtual machine instances in parallel . But I don=E2=
=80=99t know
about what are the exact installation steps that are needed to be done =
after the
ceph installation. I guess I need to install rdb and kvm to achieve the=
 same.
Please correct me if I am wrong.



  Can anyone help me in this matter.

  Thanks in advance.

--Udit Agarwal


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
