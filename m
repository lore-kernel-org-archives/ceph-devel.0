From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: CEPHFS mount error !!!
Date: Wed, 06 Feb 2013 09:29:31 -0600
Message-ID: <511276DB.3010101@bmrb.wisc.edu>
References: <CAPhYxPzgHeuivJZDt7CGPjbxfO8r288pdQMEKnX90_UvPEqbBw@mail.gmail.com>	<5111FE64.7050909@inktank.com> <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com> <51120518.7000105@mermaidconsulting.dk> <51124467.10403@conversis.de>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:34345 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab3BFP3k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 10:29:40 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id 76D012C010F
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 09:29:39 -0600 (CST)
In-Reply-To: <51124467.10403@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2/6/2013 5:54 AM, Dennis Jacobfeuerborn wrote:
...
>> To mount cephfs like that you need to have kernel support. As the Linux
>> kernel on CentOS 6.3 is version 2.6.32 and Ceph support wasn't added until
>> 2.6.34, you need to compile your own kernel.
>>
>
> The better alternative is probably to install a kernel from
> http://elrepo.org/tiki/kernel-lt . "lt" stand for "long term" and should be
> fairly stable and "ml" is "mainline" which is even more current but because
> of that not quite as stable (currently 3.7.6).

I had problems booting ml on some/most (dep. on the version) our 
machines, plus it's a pain to track: there's a new one every day.

I do have lt running without problems and mounting cephfs, however, I 
haven't gotten around to the actual ceph testing on it yet so I can't 
say anything about ceph client's performance/stability on it. ("lt" is 
3.0, as I understand it doesn't have the latest and greatest ceph module(?))

Dimitri

