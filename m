From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Rack Awareness
Date: Tue, 15 Jan 2013 11:24:12 +0100
Message-ID: <50F52E4C.4000704@widodh.nl>
References: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:53912 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab3AOKYO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:24:14 -0500
In-Reply-To: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/15/2013 11:17 AM, Gandalf Corvotempesta wrote:
> Hi all,
> is ceph able to distribute datas across multiple racks like MooseFS
> does with Rack Awareness features?
>
> For example, let's imagine a ceph cluster made with multiple OSDs
> distributed in multiple server on multiple racks.
> Is possible to tell ceph to distribute replicas across multiple racks
> avoiding to have 3 copies of the same chunk on a single rack?
>
> For example:
>
> rack1.server1.osd1
> rack2.server5.osd9
> rack3.server9.osd11

Yes, no problem at all! That's where the crushmap is for. This way you 
can tell Ceph exactly how to distribute your data.

You might want to take a look at these docs: 
http://ceph.com/docs/master/rados/operations/crush-map/

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

