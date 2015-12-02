From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Suggestions on tracker 13578
Date: Wed, 02 Dec 2015 13:04:11 -0600
Message-ID: <565F40AB.5060804@redhat.com>
References: <565D9F61.6070108@redhat.com> <CAJ4mKGbg159aO7S1soYnR+uhR9uV=t3EjYW2Q=2fbh+PPeEAeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48416 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758992AbbLBTEO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Dec 2015 14:04:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id AC14FC0CC645
	for <ceph-devel@vger.kernel.org>; Wed,  2 Dec 2015 19:04:14 +0000 (UTC)
In-Reply-To: <CAJ4mKGbg159aO7S1soYnR+uhR9uV=t3EjYW2Q=2fbh+PPeEAeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Vimal <vikumar@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 12/02/2015 12:23 PM, Gregory Farnum wrote:
> On Tue, Dec 1, 2015 at 5:23 AM, Vimal <vikumar@redhat.com> wrote:
>> Hello,
>>
>> This mail is to discuss the feature request at
>> http://tracker.ceph.com/issues/13578.
>>
>> If done, such a tool should help point out several mis-configurations that
>> may cause problems in a cluster later.
>>
>> Some of the suggestions are:
>>
>> a) A check to understand if the MONs and OSD nodes are on the same machines.
>>
>> b) If /var is a separate partition or not, to prevent the root filesystem
>> from being filled up.
>>
>> c) If monitors are deployed in different failure domains or not.
>>
>> d) If the OSDs are deployed in different failure domains.
>>
>> e) If a journal disk is used for more than six OSDs. Right now, the
>> documentation suggests upto 6 OSD journals to exist on a single journal
>> disk.
>>
>> f) Failure domains depending on the power source.
>>
>> There can be several more checks, and it can be a useful tool to test the
>> problems an existing cluster or a new installation.
>>
>> But I'd like to know how the engineering community sees this, if its seems
>> to be worth pursuing, and what suggestions do you have for improving/adding
>> to this.
>
> This is a user experience and support tool; I don't think the
> engineering community can really judge its value. ;)
>
> So sure, sounds good to me. It'll need to get into the hands of users
> before we find out if it's a good plan or not. I was at the SDI Summit
> yesterday and was hearing about how some of our choices (like
> HEALTH_WARN on pg counts) are *really* scary for users who think
> they're in danger of losing data. I suspect the difficulty of a tool
> like this will be more in the communication of issues and severity,
> more than in what exactly we choose to check.

Frankly I've never been a big fan of how we report warnings like this 
through the health check.  It's important to let users know if they've 
set up things sub-optimally, but I don't think ceph health is the way to 
do it.  The difference between your doctor telling you you should 
exercise more and lose a few pounds vs you have Ebola and are going to 
suffer an incredibly gruesome and painful death in the next 48 hours. :)

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
