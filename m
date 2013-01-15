From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance
 impact
Date: Tue, 15 Jan 2013 15:40:20 -0600
Message-ID: <50F5CCC4.7050408@inktank.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com> <50F40C4B.6000301@inktank.com> <CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com> <50F595FC.7020903@inktank.com> <CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62492 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab3AOVkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 16:40:22 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so1176586iea.16
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 13:40:21 -0800 (PST)
In-Reply-To: <CAJH6TXgwhhzM+0OfLf_=rw5fMrrde_4tT8KjX0N-RecnQ_O6uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

On 01/15/2013 03:24 PM, Gandalf Corvotempesta wrote:
> 2013/1/15 Mark Nelson <mark.nelson@inktank.com>:
>> I think the 12 bay supermicro 2U "A" chassis with 12 spinning disks, 10GbE,
>> and two controllers is potentially a really nice balanced combination.
>
> Which chassis are your referring to ? I don't see any 2U with 12 front
> and rear spinning disk from supermicro. Only 3U with rear disks
>

http://www.supermicro.com/products/chassis/2U/826/SC826BA-R920LP.cfm

That chassis has 12 3.5" bays in front, with 2 2.5" bays in back.  an 
interesting setup could be 12 spinning disks, with 2 very fast SSDs used 
for journals and OS.  Would need to test it first, and not sure I like 
putting the OS on the journal drives.  A more modest setup would be just 
to have the 12 spinning disks for data and journals and the rear drives 
for the OS.

Mark
