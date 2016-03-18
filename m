From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Fri, 18 Mar 2016 17:58:33 +0300
Message-ID: <56EC1799.30905@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
 <CY1PR0201MB189711567AFF846A96D46C80E88B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33405 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcCRO6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2016 10:58:38 -0400
Received: by mail-lf0-f45.google.com with SMTP id h198so67238033lfh.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2016 07:58:38 -0700 (PDT)
In-Reply-To: <CY1PR0201MB189711567AFF846A96D46C80E88B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 17.03.2016 21:53, Allen Samuels wrote:
>> I'd say "maybe". It's easy to say we should focus on read performance 
>> now, but as soon as we have "support for compression" everybody is 
>> going to want to turn it on on all of their clusters to spend less 
>> money on hard disks. That will definitely include RBD users, where 
>> write latency is very important. I'm hesitant to take an 
>> architectural direction that locks us in. With something layered over 
>> BlueStore I think we're forced to do it all in the initial phase; 
>> with the monolithic approach that integrates it into BlueStore's 
>> write path we have the option to do either one--perhaps based on the 
>> particular request or hints or whatever. 
> I completely agree with Sage. I think it's useful to separate mechanism from policy here. Specifically, I would push to have an onode/extent mechanism representation that supports a wide range of physical representation options (overlays in KV store, overlays in block store, overlapping extents, lazy space recovery, etc.) and allow the policy (i.e., RMW compression before ack, lazy space recovery later, etc...) evolve. It may turn out that the best policies aren't apparent right now or that they may vary based on device and resource characteristics and constraints. Over time there are likely to be many places in the code that become aware of the specifics of the mechanism (integrity checkers, compactors, inspectors, etc.) but could remain ignorant of the policy (i.e., adopt whatever poli
 cy was chosen).
This sounds good but I have some concerns about the complexity of the 
task. I'm afraid it's not doable without total (and very complex) 
bluestore refactoring.
Will try to address more or less in the next proposal though.

Thanks,
Igor
