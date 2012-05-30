From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 06:51:41 -0500
Message-ID: <4FC609CD.7070207@inktank.com>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51749 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2E3Lvs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 07:51:48 -0400
Received: by gglu4 with SMTP id u4so3357204ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 04:51:47 -0700 (PDT)
In-Reply-To: <4FC5BF27.5060704@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/30/2012 01:33 AM, Stefan Priebe - Profihost AG wrote:
>> I setup some tests today to try to replicate your findings (and also
>> check results against some previous ones I've done).  I don't think I'm
>> seeing exactly the same results as you, but I definitely see xfs
>> performing worse in this specific test than btrfs.  I've included the
>> results here.
>>
>> Full results are available here:
>> http://nhm.ceph.com/results/mailinglist-tests/
> But these tests shows exactly he same bad behaviour i'm seeing. Instead
> of having a constant sequential write ratio you've heavily jumping
> values. Are you able to test with XFS and 3.0.32? You'll then probably
> see an absolutely constant write ratio.
>
> Greets,
> Stefan

The jumping around is due to the writes to the underlying OSD disk not 
being able to keep up with the journal.  I think it's more a symptom of 
the problem rather than the problem itself.  Presumably the OSD data 
disk is performing slowly because of the number of seeks that are 
happening (In my tests almost always between 40-60 on XFS, and growing 
over time on btrfs).  It's entirely possible that something changed 
going from 3.0 to 3.4 that is causing the seek behavior to be worse.  
I'll try the test again on a 3.0 kernel and record seekwatcher results 
to see if the write patterns look any different.

Btw, I apologize if you mentioned this already, but are you running MONs 
on the OSD nodes?  Also, what version of glibc do you have?

Thanks,
Mark
