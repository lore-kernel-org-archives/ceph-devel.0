From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 22 Dec 2011 14:59:57 +0100
Message-ID: <4EF337DD.30509@tuxadero.com>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <4EEA2174.2060002@widodh.nl> <4EEA2299.6070601@tuxadero.com> <4EEA23F8.10209@tuxadero.com> <4EEB6F31.2050109@widodh.nl> <CACLRD_3pvKUmS+qtEPvQLi1hL71+4jUDMTT8mUaHpB8pYn09kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:32792 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1LVOAC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 09:00:02 -0500
In-Reply-To: <CACLRD_3pvKUmS+qtEPvQLi1hL71+4jUDMTT8mUaHpB8pYn09kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Samuel
I think I am seeing it now.

root@s-brick-003:~# ceph pg dump|grep -i scrub
pg_stat objects mip     degr    unf     kb      bytes   log     disklog 
state   v       reported        up      acting  last_scrub
0.6     0       0       0       0       0       0       0       0 
active+clean+scrubbing  0'0     60'156  [6,2]   [6,2]   0'0 
2011-12-20 14:44:55.787529
root@s-brick-003:~# ceph -v
ceph version 0.39-171-gdcedda8 
(commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
root@s-brick-003:~#


I also had an osd crash and hit this (Assertion: 
./messages/MOSDRepScrub.h: 64: FAILED assert(v == 0)), see my other 
email for more information.

-martin



Am 16.12.2011 22:17, schrieb Samuel Just:
> In master, 061e7619aacf60a828e0ce84a108d5a0bea247c6 may fix the
> problem.  If not, 5274e88d2cb8c0449a4ecd1ff0cf8bb0af2cfc97 includes
> some asserts that may give us a clue as to how this is happening.
> -Sam

