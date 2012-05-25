From: Florian Haas <florian@hastexo.com>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Fri, 25 May 2012 09:33:55 +0200
Message-ID: <CAPUexz_s=ePEiod9H_nXroBnTLOknbYww+8z2qvW=NEPF0TayQ@mail.gmail.com>
References: <4FBE167A.9060505@profihost.ag>
	<CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>
	<4FBE40FF.1040304@profihost.ag>
	<CAPUexz8S+T8K4e641N34WD=8nQYgoQOSCCBrkkvJA7bcrW+K+w@mail.gmail.com>
	<4FBF2AF5.5040805@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50814 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2EYHd5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 03:33:57 -0400
Received: by qadb17 with SMTP id b17so4686692qad.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 00:33:56 -0700 (PDT)
In-Reply-To: <4FBF2AF5.5040805@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 25, 2012 at 8:47 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 24.05.2012 16:19, schrieb Florian Haas:
>> On Thu, May 24, 2012 at 4:09 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>>> Take a look at these to see if anything looks familiar:
>>>>
>>>> http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
>>>> http://oss.sgi.com/archives/xfs/2011-11/msg00400.html
>>>
>>> These are solved by using 3.0.20.
>>
>> ... or so Christoph says, but comment #4 in bug 922 seems to indicate otherwise.
>
> I'm sorry you're absolutely right. BUT XFS had some regressions with
> xlog_grabt_log_space since 2.6.28 which was fixed in 3.0.X by reverting
> back to a kernel thread instead of workers. I was working with Christoph
> and Dave on this problem and it tooked be nearly a whole month to track
> that down (git commit c7eead1e118fb7e34ee8f5063c3c090c054c3820). In this
> case (#922) it seems it is really related to a too small log. But I
> don't have a too small log in my ceph case ;-)

Hmmm. So what's Chinner saying about this one? Should we move this
discussion to an XFS list?

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
