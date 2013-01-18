From: Simon Leinen <simon.leinen@switch.ch>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance impact
Date: Fri, 18 Jan 2013 19:54:53 +0100
Message-ID: <aafw1ywcci.fsf@switch.ch>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
	<CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
	<50F595FC.7020903@inktank.com>
	<CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
	<50F5CCC4.7050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40857 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab3ARTzF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jan 2013 14:55:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TwI1s-0000iZ-NM
	for ceph-devel@vger.kernel.org; Fri, 18 Jan 2013 20:55:08 +0100
Received: from user-23-13.vpn.switch.ch ([130.59.23.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 20:55:08 +0100
Received: from simon.leinen by user-23-13.vpn.switch.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 20:55:08 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Mark Nelson writes:
> http://www.supermicro.com/products/chassis/2U/826/SC826BA-R920LP.cfm

> That chassis has 12 3.5" bays in front, with 2 2.5" bays in back.

FWIW, we have a few Quanta S210-X22RQ[1], which are very similar - 2U,
12 3.5" bays in front, 2*2.5 in back.  We'll try a similar configuration
to what you propose, though with only 8 spinning disks (3TB WD RED) and
one SSD (256GB Samsung 840 pro).  2*10GE, 2*Xeon E5-2630, 128GB RAM.

> an interesting setup could be 12 spinning disks, with 2 very fast SSDs
> used for journals and OS.  Would need to test it first, and not sure I
> like putting the OS on the journal drives.  A more modest setup would
> be just to have the 12 spinning disks for data and journals and the
> rear drives for the OS.
-- 
Simon.

[1] http://www.quantaqct.com/en/01_product/02_detail.php?mid=27&sid=145&id=147&qs=82

