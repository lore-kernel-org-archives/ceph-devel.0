From: Gregory Farnum <greg@inktank.com>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 12:38:12 -0800
Message-ID: <CAPYLRzhwhWjakVc2Ec8jP-8e+7VOB5eqDf63yCCLL2fxFHJ0-w@mail.gmail.com>
References: <511AA47B.3020309@profihost.ag>
	<CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com>
	<511B46A2.4060107@profihost.ag>
	<alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net>
	<511BE8AC.3090600@profihost.ag>
	<alpine.DEB.2.00.1302131220570.20247@cobra.newdream.net>
	<511BF726.9030606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:38204 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3BMUiN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 15:38:13 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so2341578qah.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 12:38:13 -0800 (PST)
In-Reply-To: <511BF726.9030606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 13, 2013 at 12:27 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi,
>
> Am 13.02.2013 21:21, schrieb Sage Weil:
>
>>> This results in writes up to 400Mb/s per OSD and then results in aborted
>>> /
>>> hanging task in VMs. Is it possible to give trim commands lower priority?
>>
>>
>> Is that 400Mb or MB?  Measured over the network, or on the disk itself?
>
>
> Sorry it's MB - so the SSDs get fully utilized meased via /proc/diskstats .
>
>
>> I'm wondering if this is a lack of punch support on the kernel..
>
> I'm using 3.7.7 running XFS.

Sounds like maybe the client trim is ending up issuing a truly
ridiculous number of truncate or trim operations from librbd to the
OSDs? Like one for every RADOS block that could exist, or possibly
even for each VM disk block? (Perhaps not; I'm not sure how trim got
implemented.)

FWIW a full fstrim is not generally an operation you can really do in
the background even on a real desktop...so if running it one one or
several VMs makes the cluster unusable for all of them, that's a
problem, but if it only causes IO trouble for the one which is
trimming that'd be not ideal but less of an issue.
-Greg
