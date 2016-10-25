From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw backports
Date: Tue, 25 Oct 2016 11:52:42 +0200
Message-ID: <580F2B6A.50509@dachary.org>
References: <57FF63DD.1090806@dachary.org>
 <1276006469.22059372.1477362126674.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59416 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932843AbcJYJws (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2016 05:52:48 -0400
In-Reply-To: <1276006469.22059372.1477362126674.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 25/10/2016 04:22, Matt Benjamin wrote:
> Hi Loic,
> 
> Sorry about the late response.  Looks like you resolved the first two.  Drilling into 3, does the lack of conditional -lldap obstruct automake build?  Apparently not?

It looks like it's not a blocker indeed :-)

Cheers

> Regards,
> 
> Matt
> 
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Matt Benjamin" <mbenjamin@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Thursday, October 13, 2016 6:37:17 AM
>> Subject: rgw backports
>>
>> Hi Matt,
>>
>> The following jewel backports
>>
>> http://tracker.ceph.com/issues/17322
>> http://tracker.ceph.com/issues/17319
>> http://tracker.ceph.com/issues/17313
>>
>> conflict when trying to cherry-pick them and I would appreciate your advice
>> on how to handle them. Should they be resolved or do you think the best
>> action is to try to backport the commits that could prevent the conflict ?
>> If you don't have an opinion it's also fine, I'll figure it out ;-)
>>
>> Cheers
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
