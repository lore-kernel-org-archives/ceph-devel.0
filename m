From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: Merging hammer in master: conflict on gmock
Date: Tue, 10 Mar 2015 06:59:18 +0100
Message-ID: <54FE8836.6040308@bisect.de>
References: <54FDABC0.4080803@dachary.org> <54FDD8D8.6090709@bisect.de> <54FE2775.8010608@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:40181 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769AbbCJF7W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Mar 2015 01:59:22 -0400
In-Reply-To: <54FE2775.8010608@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Am 10.03.2015 um 00:06 schrieb Loic Dachary:
> 
> 
> On 09/03/2015 18:31, Danny Al-Gaaf wrote:
>> Hi Loic,
>> 
>> this one is a tricky one. I didn't find a smooth/automatic
>> solution yet.
>> 
>> This seems to work:
>> 
>> git checkout master git merge --no-ff origin/hammer git
>> mergetool -> for the conflict: select 'local' for src/gmock (this
>> should keep the changes im master and ignore changes from
>> hammer)
> 
> Do you know what changes have been done in hammer in src/gmock ?

It seems as if there was no change to src/gmock in hammer that is not
already in master.

Danny

