From: Naveen <Naveen.Chandrasekaran@radisys.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Thu, 12 May 2016 08:52:31 +0000 (UTC)
Message-ID: <loom.20160512T103919-180@post.gmane.org>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org> <20160511052732.GA15789@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33260 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234AbcELIwk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2016 04:52:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1b0mMH-0006fQ-Ux
	for ceph-devel@vger.kernel.org; Thu, 12 May 2016 10:52:38 +0200
Received: from 14.141.44.130.Static-Bangalore.tcl.net.in ([14.141.44.130.Static-Bangalore.tcl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 10:52:37 +0200
Received: from Naveen.Chandrasekaran by 14.141.44.130.Static-Bangalore.tcl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 10:52:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Christoph Hellwig <hch <at> infradead.org> writes:

> 
> Short answer is: don't do it.  Use the SES interface for your example,
> or ensure a proper API exists if the example was just made up.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Thanks Christoph. Power cycling of drive was an example of how some of the 
management IOCTLs provided by the SCSI LLD driver could be used. So your 
suggestion is dont' use ceph for this purpose(though its possible) but 
write or use an existing utility(if HBA vendor provides one) that issues 
IOCTLs to the SCSI/SAS LLD HBA driver directly? 

Related question is if a device like /dev/sda[1..n] is assigned a OSD and 
is being used by ceph can another user application continue to open and 
read/write to the /dev/sda1 device directly. How ceph prevents such 
scenarios?

thanks,
Naveen




