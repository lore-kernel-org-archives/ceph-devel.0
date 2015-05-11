From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu vivid
 : big difference
Date: Mon, 11 May 2015 08:45:45 -0500
Message-ID: <5550B289.8010903@redhat.com>
References: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv> <1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbbEKNqB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 09:46:01 -0400
In-Reply-To: <1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Stefan Priebe <s.priebe@profihost.ag>

On 05/11/2015 12:53 AM, Alexandre DERUMIER wrote:
> Seem that's is ok too on debian jessie (with an extra boost with rbd_cache true)
>
> Maybe is it related to old glibc on debian wheezy ?
>
>
>
>
>
> debian jessie: rbd_cache=false : iops=202985 : %Cpu(s): 21,9 us,  9,5 sy,  0,0 ni, 66,1 id,  0,0 wa,  0,0 hi,  2,6 si,  0,0 st
> debian jessie: rbd_cache=true :  iops=215290 : %Cpu(s): 27,9 us, 10,8 sy,  0,0 ni, 58,8 id,  0,0 wa,  0,0 hi,  2,6 si,  0,0 st
>
>
> ubuntu vivid : rbd_cache=false : iops=201089 %Cpu(s): 21,3 us, 12,8 sy, 0,0 ni, 61,8 id, 0,0 wa, 0,0 hi, 4,1 si, 0,0 st
> ubuntu vivid : rbd_cache=true  : iops=197549 %Cpu(s): 27,2 us, 15,3 sy, 0,0 ni, 53,2 id, 0,0 wa, 0,0 hi, 4,2 si, 0,0 st
> debian wheezy : rbd_cache=false: iops=161272 %Cpu(s): 28.4 us, 15.4 sy, 0.0 ni, 52.8 id, 0.0 wa, 0.0 hi, 3.4 si, 0.0 st
> debian wheezy : rbd_cache=true : iops=135893 %Cpu(s): 30.0 us, 15.5 sy, 0.0 ni, 51.5 id, 0.0 wa, 0.0 hi, 3.0 si, 0.0 st


Isn't Wheezy a pretty old kernel too? (like 3.2?)  There's been a ton of 
changes since then.  Originally I was thinking this might have been some 
of the new network/inode optimizations in 3.18+ for vivid, but if Jesse 
is better maybe it's some of the other kernel changes (or perhaps it's 
glibc or something else).  FWIW, we've noticed a pretty significant 
performance improvement going from CentOS 6.5 to RHEL7 on the same 
hardware.  Haven't looked very deeply into it, but there definitely 
appears to be an advantage to running modern distributions.
