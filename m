From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Tue, 15 Jan 2013 22:58:15 +0100
Message-ID: <CAJH6TXh4XTSvQxdUVVN7-s52JU7qKAOTeLw9XAE_kzw+36wQ6w@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
	<CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
	<50F595FC.7020903@inktank.com>
	<CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
	<50F5CCC4.7050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56540 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab3AOWG3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 17:06:29 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so415691wgd.4
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 14:06:28 -0800 (PST)
In-Reply-To: <50F5CCC4.7050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

2013/1/15 Mark Nelson <mark.nelson@inktank.com>:
> http://www.supermicro.com/products/chassis/2U/826/SC826BA-R920LP.cfm
>
> That chassis has 12 3.5" bays in front, with 2 2.5" bays in back.  an
> interesting setup could be 12 spinning disks, with 2 very fast SSDs used for
> journals and OS.  Would need to test it first, and not sure I like putting
> the OS on the journal drives.  A more modest setup would be just to have the
> 12 spinning disks for data and journals and the rear drives for the OS.

Thank you. We have planned the same with a DELL R515 12+2 disks.
OS should be loaded from a RAID1 partitions from 2 spinning disks.

Or even no raid, in case of failure, the whole node is replicated by ceph.
