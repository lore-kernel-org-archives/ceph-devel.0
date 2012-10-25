From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: [ceph-commit] HEALTH_WARN 192 pgs degraded
Date: Thu, 25 Oct 2012 13:05:30 +1300
Message-ID: <5088824A.4000700@catalyst.net.nz>
References: <5087F3AE.8080601@gmail.com> <alpine.DEB.2.00.1210240839280.25958@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:48165 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab2JYAFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 20:05:17 -0400
In-Reply-To: <alpine.DEB.2.00.1210240839280.25958@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Roman Alekseev <rs.alekseev@gmail.com>, ceph-devel@vger.kernel.org

On 25/10/12 04:40, Sage Weil wrote:
> [moved to ceph-devel]
>
> On Wed, 24 Oct 2012, Roman Alekseev wrote:
>> Hi there,
>>
>>
>> I've made simple fresh installation of ceph on Debian server with the
>> following configuration:
>> ************************
>> [global]
>>      debug ms = 0
>> [osd]
>>      osd journal size = 1000
>>      filestore xattr use omap = true
>>
>> [mon.a]
>>
>>      host = serv1
>>      mon addr = 192.168.0.10:6789
>>
>> [osd.0]
>>       host = serv1
>>
>> [mds.a]
>>      host = serv1
>> ************************
>>
>> Seems everything is working fine but when I perform "ceph health" command I
>> receive the next message:
>> HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean; recovery 21/42 degraded
>> (50.000%)
> This is simply because you only have 1 osd but the default policy is 2x
> replication.  As such, all PGs are 'degraded' because they are only
> replicated once.
>
> If you add another OSD to your cluster the warning will go away.
>
> sage
>

The other alternative is to just set the pool(s) replication size to 1, 
if you are just wanting a single osd for (say) testing:

$ ceph osd pool set <your pool(s)> size 1

I find it I need to restart ceph after doing the above, it then sorts 
itself out to a nice healthy status!

Regards

Mark

