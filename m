From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance
 impact
Date: Tue, 15 Jan 2013 11:46:36 -0600
Message-ID: <50F595FC.7020903@inktank.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com> <50F40C4B.6000301@inktank.com> <CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:51765 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab3AORqf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 12:46:35 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so683670ieb.17
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 09:46:35 -0800 (PST)
In-Reply-To: <CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

On 01/15/2013 03:31 AM, Gandalf Corvotempesta wrote:
> 2013/1/14 Mark Nelson <mark.nelson@inktank.com>:
>> The advice that I usually give people is that if performance is a big
>> concern, try to match filestore disk and journal performance is nearly
>> matched.  In my test setup, I use 1 intel 520 SSD to host 3 journals for
>> 7200rpm enterprise SATA disks.  A 1:4 ratio or even 1:6 ratio may also work
>> fine depending on various factors.  So far the limits I've hit with very
>> minimal tuning seem to be around 15 spinning disks and 5 SSDs for around
>> 1.4GB/s (2.8GB/s including journal writes) to one node.
>
> Is this a ratio based on OSDs/SSDs or on OSDs/Server ?
> For example, a server with 12 spinning disks plus 2 internal SSD should be used
> for 12 OSDs. The first 6 will have journal on SSD1, the latest 6 will use SSD2.
>
> In this case, ratio is 1:6, right?
> Or are you referring to the whole server?
>

OSDS/SSD I think if I understand you correctly. Basically you just want 
to match OSD and Journal (and network) throughput to be relatively 
similar.  That's not always easy given budgets and whether you are more 
interested in sequential throughput or IOPs.

I think the 12 bay supermicro 2U "A" chassis with 12 spinning disks, 
10GbE, and two controllers is potentially a really nice balanced 
combination.  You could go cheap controllers plus 2 fast SSDs (like 
400-500MB/s seq) or more expensive controllers with WB cache and just 
use the 12 spinning disks for data and journals (and keep the rear 
drives for OS/logs/etc).  Either could potentially be good solutions 
with slightly different performance characteristics.

Of course if you are going all out for IOPs, you probably would be 
looking at a somewhat different kind of solution anyway.

Mark
