From: Bryan Wright <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Trying to build "ceph-client-standalone" under kernel 2.6.32
Date: Tue, 13 Mar 2012 18:40:07 +0000 (UTC)
Message-ID: <loom.20120313T193341-715@post.gmane.org>
References: <loom.20120313T154901-294@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37176 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab2CMSkX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 14:40:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7Wdw-0000M1-Da
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 19:40:20 +0100
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 19:40:20 +0100
Received: from bkw1a by ayesha.phys.Virginia.EDU with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 19:40:20 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Bryan Wright <bkw1a <at> ayesha.phys.virginia.edu> writes:

> I'm doing this under 32-bit CentOS 5.7 with a 2.6.32 kernel.

Sorry, let me correct that: I'm actually doing this under CentOS 6.2 with a
2.6.32 kernel.  We also have a bunch of CentOS 5.7 machines, but they'll be
upgraded before I try to make them ceph clients.

     Regarding the possibility of using a later kernel, I could do that, but
then I'd need to worry more about keeping on top of security updates.  If I can
use the stock CentOS kernel, then I can just let the CentOS maintainers worry
about that.

     Regarding the possibility of moving the 32-bit machines to 64-bit, it's an
option, but there's otherwise very little pressure to make the move, and some
trepidation about what might break.  For us, a 32-bit kernel with PAE has been a
fine configuration.

                                                Bryan
 




