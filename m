From: Florian Haas <florian@hastexo.com>
Subject: Re: ceph-resource-agents
Date: Fri, 17 Feb 2012 13:45:01 +0100
Message-ID: <4F3E4BCD.7040608@hastexo.com>
References: <989BA3D6-5844-4566-AA9B-69A0472C0228@cs.ucsc.edu> <Pine.LNX.4.64.1202161506340.20265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41923 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2BQMpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 07:45:07 -0500
Received: by werb13 with SMTP id b13so1810392wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 04:45:04 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1202161506340.20265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 02/17/12 00:09, Sage Weil wrote:
> On Thu, 16 Feb 2012, Noah Watkins wrote:
>> On Ubuntu LTS 10.04, ceph-resource-agents package depends on resource-agents that seems to have not shown up until 11.10 so there is a dependency problem:
>>
>> nwatkins@piha:~/Projects/ceph$ sudo apt-get install ceph-resource-agents
>> Reading package lists... Done
>> Building dependency tree       
>> Reading state information... Done
>> ceph-resource-agents is already the newest version.
>> You might want to run 'apt-get -f install' to correct these:
>> The following packages have unmet dependencies:
>>  ceph-resource-agents : Depends: resource-agents but it is not installable
>>                         Recommends: pacemaker but it is not going to be installed
>> E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).
>>
>>
>> Aside from that dependency problem, is it safe to completely omit the 
>> ceph-resource-agents package for a Ceph install?
> 
> Yeah.  It just has the ocf resource agent hooks, which you probably don't 
> need.
> 
> That package is a recommends, right?  This doesn't break the ceph package 
> itself?

It's not even a recommends. Noah asked apt-get explicitly to install
ceph-resource-agents, and _that_ has a (correct) dependency on
resource-agents.

resource-agents is available even for 10.04 from the
ubuntu-ha-maintainers PPA for those who need them, btw.

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
