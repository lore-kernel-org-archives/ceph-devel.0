From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Luminous "upgrade"
Date: Thu, 29 Jun 2017 10:38:30 +0200
Message-ID: <a59baf60-394c-46f1-9445-80ef81fb56f8@digiware.nl>
References: <ac2ebcde-f3d1-7706-86bc-8123956314a8@digiware.nl>
 <alpine.DEB.2.11.1706290229230.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:19348 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbdF2Iie (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Jun 2017 04:38:34 -0400
In-Reply-To: <alpine.DEB.2.11.1706290229230.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 29-6-2017 04:30, Sage Weil wrote:
> On Thu, 29 Jun 2017, Willem Jan Withagen wrote:
>> Hi,
>>
>> I installed the FreeBSD package i build for v12.1.0 but now my cluster
>> reports:
>>
>>   cluster:
>>     id:     6436b2a5-59a5-11e7-b746-0025903744dc
>>     health: HEALTH_ERR
>>             mds rank 0 has failed
>>             mds cluster is degraded
>>             all OSDs are running luminous or later but
>> require_osd_release < luminous
>>
>> However `ceph osd set` only has:
>> 	require_jewel_osds|require_kraken_osds
>>
>> So I cannot set something luminous....
> 
> Do
> 
>  ceph osd require-osd-release luminous

The upgrading link from the release page did not work for me.
So I missed the upgrading page.

And I tried the command, but with the wrong incantation. I tried:
	require_osd_release
Note the underscores.

Thanx for setting me straight.

--WjW

