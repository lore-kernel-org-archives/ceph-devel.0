From: Wido den Hollander <wido@42on.com>
Subject: Re: Quering since when a PG is inactive
Date: Wed, 9 Dec 2015 17:14:21 +0100
Message-ID: <5668535D.7050509@42on.com>
References: <5667DE37.4080502@42on.com>
 <alpine.DEB.2.00.1512090549400.12816@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:58285 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbLIQOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 11:14:24 -0500
In-Reply-To: <alpine.DEB.2.00.1512090549400.12816@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/09/2015 02:50 PM, Sage Weil wrote:
> Hi Wido!
> 
> On Wed, 9 Dec 2015, Wido den Hollander wrote:
>> Hi,
>>
>> I'm working on a patch in PGMonitor.cc that sets the state to HEALTH_ERR
>> if >= X PGs are stuck non-active.
>>
>> This works for me now, but I would like to add a timer that a PG has to
>> be inactive for more than Y seconds.
>>
>> The PGMap contains "last_active" and "last_clean", but these timestamps
>> are never updated. So I can't query for last_active =< (now() - 300) for
>> example.
>>
>> On a idle test cluster I have a PG for example:
>>
>> "last_active": "2015-12-09 02:32:31.540712",
>>
>> It's currently 08:53:56 here, so I can't check against last_active.
>>
>> What would a good way be to see for how long a PG has been inactive?
> 
> It sounds like maybe the current code is subtley broken:
> 
> 	https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2566
> 
> The last_active/clean etc should be fresh within 
> osd_pg_stat_report_interval_max seconds...
> 

Indeed, that seems broken. I created a issue for it:
http://tracker.ceph.com/issues/14028

I'm not sure where to start (yet).

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
