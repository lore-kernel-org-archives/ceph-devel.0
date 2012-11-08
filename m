From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: problems creating new ceph cluster when using journal on block device
Date: Thu, 8 Nov 2012 10:08:46 -0500
Message-ID: <CACkq2mqtRq_s6=UxrF1ADaFuf2tETDB2GSdXCPdi4mG7Ei9wow@mail.gmail.com>
References: <CACkq2mozdJackj__AB_ZJnN5KR9mdqN_LRG8RPu0hN1qh_8e_g@mail.gmail.com>
 <509B6883.4010406@widodh.nl> <509B6C2E.2050708@catalyst.net.nz> <CACkq2mr=dmHX+Z6fTMUvct78pa9RWeGid5vHK1vNw1_S-NWgDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64355 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2KHPJI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:09:08 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so2782171vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 07:09:07 -0800 (PST)
In-Reply-To: <CACkq2mr=dmHX+Z6fTMUvct78pa9RWeGid5vHK1vNw1_S-NWgDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

One more thing -- Google search says this is harmless -- I see quite a
few of these in syslog:

hdparm: sending ioctl 2285 to a partition!
