From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: Merging hammer in master: conflict on gmock
Date: Mon, 09 Mar 2015 18:31:04 +0100
Message-ID: <54FDD8D8.6090709@bisect.de>
References: <54FDABC0.4080803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:55682 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666AbbCIRbR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 13:31:17 -0400
In-Reply-To: <54FDABC0.4080803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

this one is a tricky one. I didn't find a smooth/automatic solution yet.

This seems to work:

git checkout master
git merge --no-ff origin/hammer
git mergetool
 -> for the conflict: select 'local' for src/gmock (this should keep
    the changes im master and ignore changes from hammer)
git commit

You may have to check if the result is what's intended.

Danny

Am 09.03.2015 um 15:18 schrieb Loic Dachary:
> Hi Danny,
> 
> As of now, git checkout master ; git merge origin/hammer gets a 
> conflict on gmock
> 
> When we last discussed it you found that git merge -m 1 was a 
> solution. But I'm not sure I fully understand the consequences.
> 
> Cheers
> 

