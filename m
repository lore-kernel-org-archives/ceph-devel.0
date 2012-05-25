From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Fri, 25 May 2012 08:47:17 +0200
Message-ID: <4FBF2AF5.5040805@profihost.ag>
References: <4FBE167A.9060505@profihost.ag>	<CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>	<4FBE40FF.1040304@profihost.ag> <CAPUexz8S+T8K4e641N34WD=8nQYgoQOSCCBrkkvJA7bcrW+K+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56367 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2EYGrC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 02:47:02 -0400
In-Reply-To: <CAPUexz8S+T8K4e641N34WD=8nQYgoQOSCCBrkkvJA7bcrW+K+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.05.2012 16:19, schrieb Florian Haas:
> On Thu, May 24, 2012 at 4:09 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>> Take a look at these to see if anything looks familiar:
>>>
>>> http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
>>> http://oss.sgi.com/archives/xfs/2011-11/msg00400.html
>>
>> These are solved by using 3.0.20.
> 
> ... or so Christoph says, but comment #4 in bug 922 seems to indicate otherwise.

I'm sorry you're absolutely right. BUT XFS had some regressions with
xlog_grabt_log_space since 2.6.28 which was fixed in 3.0.X by reverting
back to a kernel thread instead of workers. I was working with Christoph
and Dave on this problem and it tooked be nearly a whole month to track
that down (git commit c7eead1e118fb7e34ee8f5063c3c090c054c3820). In this
case (#922) it seems it is really related to a too small log. But I
don't have a too small log in my ceph case ;-)

Stefan
