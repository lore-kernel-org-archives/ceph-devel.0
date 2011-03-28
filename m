From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: The stability of OSD
Date: Mon, 28 Mar 2011 08:38:48 -0600
Message-ID: <4D909D78.90803@sandia.gov>
References: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
 <Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:45133 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1C1OjI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 10:39:08 -0400
In-Reply-To: <Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Sage Weil wrote:
> On Mon, 28 Mar 2011, Sylar Shen wrote:
>> Hi,
>> I set an environment of 20 servers which include 2 MDSs, 3 MONs and 18
>> OSDes(3 monitors on 18 OSDes)
>> My version is 0.24.3 and OS is Fedora 14.
>> There's a problem when I was doing the writing tests.
>> Whether I was writing the data or not, some OSDes were randomly marked
>> down and out one by one after a period of time.
>> And when that happened, the whole performance soon got worse and worse.
>> I checked the /var/log/ceph/osd.log but found nothing.
>> So I am curious that is there anyone who has the same problem with me?
>> Or maybe it's just a problem of my hardware......><
> 
> Hi Sylar,
> 
> This is/was a known problem.  There's a long thread from a couple weeks 
> back with Jim Schutt debugging the issue.  We've fixed a few different 
> things that have significantly improved the situation, but the heartbeats 
> are still failing from time to time.

I'm about ready to test the master branch again, built
against tcmalloc and libatomic_ops - I had to add those
things into my RHEL 5 environment.  I'll be reporting
results for that soon; sorry for the delay.

-- Jim

> 
> I suspect using a more recent release will be sufficient at your scale, 
> either 0.25.2 or the latest 'next' branch from git (there are autobuilt 
> debs for that too).  You can also increase the 'osd heartbeat grace' to 
> make the system less sensitive to the transient hangs that are preventing 
> the heartbeats from going out.
> 
> Please let us know what you find, either here or on #ceph.
> 
> Thanks!
> sage
> 
> 	
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


