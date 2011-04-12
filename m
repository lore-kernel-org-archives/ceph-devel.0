From: Christoph Raible <c.raible@science-computing.de>
Subject: Re: Searching for right tcmalloc Packages on CentOS 5.5
Date: Tue, 12 Apr 2011 13:36:54 +0000 (UTC)
Message-ID: <loom.20110412T153347-688@post.gmane.org>
References: <4DA40BAF.2070404@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59004 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503Ab1DLNuI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2011 09:50:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q9dyn-0003BB-8E
	for ceph-devel@vger.kernel.org; Tue, 12 Apr 2011 15:50:07 +0200
Received: from HSI-KBW-095-208-113-104.hsi5.kabel-badenwuerttemberg.de ([95.208.113.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 15:50:05 +0200
Received: from c.raible by HSI-KBW-095-208-113-104.hsi5.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 15:50:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Christoph Raible <c.raible <at> science-computing.de> writes:

> I'm searching for the right tcmalloc package to configure Ceph on
> CentOS 5.5 x86_64.
> 
> I tried the following packages described in Mailinglist and other Howto's:
> 
>      google-perftools-1.3-3.el5.kb.x86_64,
>      google-perftools-1.7-1.el5.i386.rpm,
>      google-perftools-devel-1.7-1.el5.i386.rpm
> 
> But none of them works...  I always get the following error:
> 
>      checking for malloc in -ltcmalloc... no
> 
>      configure: error: no tcmalloc found (use --without-tcmallo to 
>     disable)
> 
>      See `config.log' for more details.
> 
> Can anyone help me with my problem?


I got the solution, i forgot in version 1.3.3  to install the devel-package.

google-perftools-devel-1.3-3.el5.kb.x86_64,

After that configuring an compiling Ceph works fine.

Regards,

Christoph Raible


