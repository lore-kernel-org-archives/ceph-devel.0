From: Simon Leinen <simon.leinen@switch.ch>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Sat, 19 Jan 2013 09:18:06 +0100
Message-ID: <20730.22206.102358.286181@Simons-MacBook-Air-33230.local>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
	<CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
	<50F595FC.7020903@inktank.com>
	<CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
	<50F5CCC4.7050408@inktank.com>
	<aafw1ywcci.fsf@switch.ch>
	<CAJH6TXg2TXEk2j6gcy2H_VTQu9DEJ0S-hwoyxOBmAHKHPMjLGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from elenski.switch.ch ([130.59.108.140]:47962 "EHLO
	elenski.switch.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab3ASI1x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 03:27:53 -0500
In-Reply-To: <CAJH6TXg2TXEk2j6gcy2H_VTQu9DEJ0S-hwoyxOBmAHKHPMjLGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

Gandalf Corvotempesta writes:
> 2013/1/18 Simon Leinen <simon.leinen@switch.ch>:
>> FWIW, we have a few Quanta S210-X22RQ[1], which are very similar - 2U,
>> 12 3.5" bays in front, 2*2.5 in back.  We'll try a similar configuration
>> to what you propose, though with only 8 spinning disks (3TB WD RED) and
>> one SSD (256GB Samsung 840 pro).  2*10GE, 2*Xeon E5-2630, 128GB RAM.

> 128GB RAM?
> What will you do with this ceph node?

The idea is to also run OpenStack (Nova) on them.
(I know this is contentious. :-)
-- 
Simon.
