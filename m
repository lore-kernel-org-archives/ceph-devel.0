From: Florian Haas <florian@hastexo.com>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Thu, 24 May 2012 16:19:41 +0200
Message-ID: <CAPUexz8S+T8K4e641N34WD=8nQYgoQOSCCBrkkvJA7bcrW+K+w@mail.gmail.com>
References: <4FBE167A.9060505@profihost.ag>
	<CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>
	<4FBE40FF.1040304@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52696 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2EXOTm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 10:19:42 -0400
Received: by qadb17 with SMTP id b17so4083076qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 07:19:41 -0700 (PDT)
In-Reply-To: <4FBE40FF.1040304@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 24, 2012 at 4:09 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>> Take a look at these to see if anything looks familiar:
>>
>> http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
>> http://oss.sgi.com/archives/xfs/2011-11/msg00400.html
>
> These are solved by using 3.0.20.

... or so Christoph says, but comment #4 in bug 922 seems to indicate otherwise.

Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
