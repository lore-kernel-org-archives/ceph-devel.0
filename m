From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: Merging hammer in master: conflict on gmock
Date: Tue, 10 Mar 2015 12:07:46 +0100
Message-ID: <54FED082.2080803@bisect.de>
References: <54FDABC0.4080803@dachary.org> <54FDD8D8.6090709@bisect.de> <54FE2775.8010608@dachary.org> <54FE8836.6040308@bisect.de> <54FEA51A.30003@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:46570 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbbCJLHu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Mar 2015 07:07:50 -0400
In-Reply-To: <54FEA51A.30003@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Am 10.03.2015 um 09:02 schrieb Loic Dachary:
> Hi Danny,
> 
> On 10/03/2015 06:59, Danny Al-Gaaf wrote:
>> Am 10.03.2015 um 00:06 schrieb Loic Dachary:
[...]
>>> 
>>> Do you know what changes have been done in hammer in src/gmock
>>> ?
>> 
>> It seems as if there was no change to src/gmock in hammer that
>> is not already in master.
> 
> After the set of commands you suggest, how could we make sure
> nothing was trashed or unintentionally included ? I can't think of
> a sure method from the top of my head.

Since these commands only trash/ignore the changes to src/gmock from
the hammer branch. And I guess there will be nothing for this
directory we need to merge back to master.

In fact the merge conflict is not about commits AFAICS but about the
change in master from inline to submodule code.

One possibility would always be to extract the patches from hammer
(git checkout hammer && git format-patch master), and check after the
merge if one is missing (e.g. run 'git am' until you have a patch that
can be applied).

I know this is not ideal ... IMO git is missing an automated way to
handle these kind of merge conflict.

Danny
