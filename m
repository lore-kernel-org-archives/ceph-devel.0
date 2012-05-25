From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Fri, 25 May 2012 09:35:14 +0200
Message-ID: <4FBF3632.6090903@profihost.ag>
References: <4FBE167A.9060505@profihost.ag>	<CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>	<4FBE40FF.1040304@profihost.ag>	<CAPUexz8S+T8K4e641N34WD=8nQYgoQOSCCBrkkvJA7bcrW+K+w@mail.gmail.com>	<4FBF2AF5.5040805@profihost.ag> <CAPUexz_s=ePEiod9H_nXroBnTLOknbYww+8z2qvW=NEPF0TayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36194 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab2EYHe6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 03:34:58 -0400
In-Reply-To: <CAPUexz_s=ePEiod9H_nXroBnTLOknbYww+8z2qvW=NEPF0TayQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 25.05.2012 09:33, schrieb Florian Haas:
> On Fri, May 25, 2012 at 8:47 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Am 24.05.2012 16:19, schrieb Florian Haas:
>>> On Thu, May 24, 2012 at 4:09 PM, Stefan Priebe - Profihost AG
>>> <s.priebe@profihost.ag> wrote:
>>>>> Take a look at these to see if anything looks familiar:
>>>>>
>>>>> http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
>>>>> http://oss.sgi.com/archives/xfs/2011-11/msg00400.html
>>>>
>>>> These are solved by using 3.0.20.
>>>
>>> ... or so Christoph says, but comment #4 in bug 922 seems to indicate otherwise.
>>
>> I'm sorry you're absolutely right. BUT XFS had some regressions with
>> xlog_grabt_log_space since 2.6.28 which was fixed in 3.0.X by reverting
>> back to a kernel thread instead of workers. I was working with Christoph
>> and Dave on this problem and it tooked be nearly a whole month to track
>> that down (git commit c7eead1e118fb7e34ee8f5063c3c090c054c3820). In this
>> case (#922) it seems it is really related to a too small log. But I
>> don't have a too small log in my ceph case ;-)
> 
> Hmmm. So what's Chinner saying about this one? Should we move this
> discussion to an XFS list?

I already send the trace to Christoph, Dave and the XFS List. Sadly no
reply.

Stefan
