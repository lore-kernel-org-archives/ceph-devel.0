From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Sat, 19 Jan 2013 00:48:56 +0100
Message-ID: <CAJH6TXg2TXEk2j6gcy2H_VTQu9DEJ0S-hwoyxOBmAHKHPMjLGw@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
	<CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
	<50F595FC.7020903@inktank.com>
	<CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
	<50F5CCC4.7050408@inktank.com>
	<aafw1ywcci.fsf@switch.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49826 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3ARXs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 18:48:58 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so5641142wib.12
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 15:48:57 -0800 (PST)
In-Reply-To: <aafw1ywcci.fsf@switch.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Leinen <simon.leinen@switch.ch>
Cc: ceph-devel@vger.kernel.org

2013/1/18 Simon Leinen <simon.leinen@switch.ch>:
> FWIW, we have a few Quanta S210-X22RQ[1], which are very similar - 2U,
> 12 3.5" bays in front, 2*2.5 in back.  We'll try a similar configuration
> to what you propose, though with only 8 spinning disks (3TB WD RED) and
> one SSD (256GB Samsung 840 pro).  2*10GE, 2*Xeon E5-2630, 128GB RAM.

128GB RAM?
What will you do with this ceph node?
