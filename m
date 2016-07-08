From: Srikar <srikar.kumar@gmail.com>
Subject: Re: DIF/DIX support
Date: Fri, 8 Jul 2016 14:17:55 +0000 (UTC)
Message-ID: <loom.20160708T155643-717@post.gmane.org>
References: <loom.20160707T153606-596@post.gmane.org> <alpine.DEB.2.11.1607071515540.11303@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59354 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbcGHOSE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jul 2016 10:18:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1bLWbR-0007sq-Dn
	for ceph-devel@vger.kernel.org; Fri, 08 Jul 2016 16:18:02 +0200
Received: from 115.119.152.66.static-hyderabad.vsnl.net.in ([115.119.152.66.static-hyderabad.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 16:18:01 +0200
Received: from srikar.kumar by 115.119.152.66.static-hyderabad.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 16:18:01 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

 On Thu, 7 Jul 2016, Srikar wrote:
Hi all,
          I am new to  CEPH environment.For the past two weeks I have been
 going through CEPH related documents as well as code(Jewel)  and have some
 queries. Can anyone tell me whether there is support for  
DIF/DIX(Protection Information) in CEPH.

 There is no DIF/DIX support.  I'm not sure it's worth adding. We want 
 checksums on all devices (not just enterprise SAS drives) so we have to 
 implement in anyway, and once we do I'm not sure there is much value in 
 using DIF/DIX too.
 
 Also I believe FDE is not present in CEPH . Is FDE compatible on CEPH 
 environment?
 
 Currently we do encryption with dm-crypt.  Using the FDE feature on the 
 drives themselves would be great since there is no performance cost, 
 although many users will choose not to use it for lack of trust in the 
 disk firmware.  I'm not sure what the path forward there is in order to 
 get it turned on and configured on the device.  Probably some magic in 
 ceph-disk, but I'm not sure.  Do you have more information?
 
 sage
 --
 To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
 the body of a message to majordomo <at> vger.kernel.org
 More majordomo info at  http://vger.kernel.org/majordomo-info.html
 
Hi Sage,
       Thanks for the reply. Currently as a beginner, I don't have much
information related to the path where we can add FDE to CEPH. I will get
back to you when I have enough information.
Regards,
Srikar.


