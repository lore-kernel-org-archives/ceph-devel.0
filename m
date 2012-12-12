From: Bryant Ng <bryantng@gmail.com>
Subject: Re: Crush and Monitor questions
Date: Wed, 12 Dec 2012 11:02:02 -0800
Message-ID: <kaakb9$ql5$1@ger.gmane.org>
References: <ka84oo$sa3$1@ger.gmane.org> <50C8C0E1.6060909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50347 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949Ab2LLTCP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Dec 2012 14:02:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TirZa-0003dn-7j
	for ceph-devel@vger.kernel.org; Wed, 12 Dec 2012 20:02:26 +0100
Received: from 50-76-54-11-ip-static.hfc.comcastbusiness.net ([50.76.54.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 20:02:26 +0100
Received: from bryantng by 50-76-54-11-ip-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 20:02:26 +0100
In-Reply-To: <50C8C0E1.6060909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I guess my question was where is the crushmap (and osdmap) persisted on 
the monitor node?

If the entire cluster goes down, I assume the monitor is reading the 
crushmap from some persistent file stored on disk or a db?  Is that why 
the minimum recommended storage for monitors is 10GB?  Is the crushmap 
and osdmap stored in those 10GB?

-Bryant

Joao Eduardo Luis wrote:
> Hello Bryant,
>
> On 12/11/2012 08:23 PM, Bryant Ng wrote:
>> Hi,
>>
>> I'm pretty new to Ceph and am just learning about it.
>>
>> Where are the CRUSH maps stored in Ceph? In the documentation I see you
>> use the 'crushtool' to compile and decompile the crush map.
>
> The crushmap is kept alongside with the osdmap, and shared by the monitors.
>
>> I understand that if a single monitor comes online, it can talk to the
>> other existing monitors to get the cluster map but how does it work on
>> initial startup?  Or if the entire Ceph clusters goes down b/c of power
>> failure or something.
>
> If you add a new monitor to an existing cluster, it will synchronize
> with the existing monitors and will obtain all their infos, including
> the crushmap. Updates to the crushmap will also be shared among the
> monitors in the quorum.
>
> If you are starting up fresh, you will have to either add your custom
> crushmap to the monitors (using the ceph tool), or stick with the
> default crushmap (which only defines something along the lines of a
> 'default' root, a 'defaultrack' rack and a 'localhost' host).
>
> If the entire cluster goes down... well, if the monitors are not up they
> won't be able to share the crushmap. When they are brought back up, then
> they will pick up where they left. But I'm not sure if I understand what
> your question is.
>
>    -Joao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


