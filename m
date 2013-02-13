From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 22:43:33 +0100
Message-ID: <511C0905.7070509@profihost.ag>
References: <511AA47B.3020309@profihost.ag> <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com> <511B46A2.4060107@profihost.ag> <alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net> <511BE8AC.3090600@profihost.ag> <alpine.DEB.2.00.1302131220570.20247@cobra.newdream.net> <511BF726.9030606@profihost.ag> <CAPYLRzhwhWjakVc2Ec8jP-8e+7VOB5eqDf63yCCLL2fxFHJ0-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:41569 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934131Ab3BMVng (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 16:43:36 -0500
In-Reply-To: <CAPYLRzhwhWjakVc2Ec8jP-8e+7VOB5eqDf63yCCLL2fxFHJ0-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

HI Greg,

Am 13.02.2013 21:38, schrieb Gregory Farnum:
>> Sorry it's MB - so the SSDs get fully utilized meased via /proc/diskstats .
>>
>>> I'm wondering if this is a lack of punch support on the kernel..
>>
>> I'm using 3.7.7 running XFS.
>
> Sounds like maybe the client trim is ending up issuing a truly
> ridiculous number of truncate or trim operations from librbd to the
> OSDs?
Yes for every single unused disk block ;-(

> Like one for every RADOS block that could exist, or possibly
> even for each VM disk block? (Perhaps not; I'm not sure how trim got
> implemented.)
I'm pretty sure Disk block...

> FWIW a full fstrim is not generally an operation you can really do in
> the background even on a real desktop...so if running it one one or
> several VMs makes the cluster unusable for all of them, that's a
> problem, but if it only causes IO trouble for the one which is
> trimming that'd be not ideal but less of an issue.

Yes if you can control this yes if you have no access to the client 
machines no... or you can just disable trim support - but it's a nice 
feature for provisioning...

Greets,
Stefan
