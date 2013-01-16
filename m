From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance impact
Date: Wed, 16 Jan 2013 08:41:38 +0100
Message-ID: <5C92D618-3B0A-472B-99B8-988161B9B16F@profihost.ag>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com> <50F40C4B.6000301@inktank.com> <CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com> <50F595FC.7020903@inktank.com> <CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com> <50F5CCC4.7050408@inktank.com> <CAJH6TXh4XTSvQxdUVVN7-s52JU7qKAOTeLw9XAE_kzw+36wQ6w@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52893 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577Ab3APHln convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 02:41:43 -0500
In-Reply-To: <CAJH6TXh4XTSvQxdUVVN7-s52JU7qKAOTeLw9XAE_kzw+36wQ6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Why do you use 3,5' at all instead of 2,5?

Am 15.01.2013 um 22:58 schrieb Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:

> 2013/1/15 Mark Nelson <mark.nelson@inktank.com>:
>> http://www.supermicro.com/products/chassis/2U/826/SC826BA-R920LP.cfm
>> 
>> That chassis has 12 3.5" bays in front, with 2 2.5" bays in back.  an
>> interesting setup could be 12 spinning disks, with 2 very fast SSDs used for
>> journals and OS.  Would need to test it first, and not sure I like putting
>> the OS on the journal drives.  A more modest setup would be just to have the
>> 12 spinning disks for data and journals and the rear drives for the OS.
> 
> Thank you. We have planned the same with a DELL R515 12+2 disks.
> OS should be loaded from a RAID1 partitions from 2 spinning disks.
> 
> Or even no raid, in case of failure, the whole node is replicated by ceph.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
