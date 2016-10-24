From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: mempools everywhere
Date: Mon, 24 Oct 2016 15:12:06 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1610241506011.31007@ancalagon.suse.de>
References: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to> <BLUPR0201MB15240B7882D0381D5152363AE8D30@BLUPR0201MB1524.namprd02.prod.outlook.com> <BLUPR0201MB152443595C256F34701829CFE8D20@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <589246c6-4094-c782-28b7-5d5dd7f493dd@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323584-636748606-1477346963=:31007"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757422AbcJXWMN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 18:12:13 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08BC4ABC8
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 22:12:11 +0000 (UTC)
In-Reply-To: <589246c6-4094-c782-28b7-5d5dd7f493dd@corp.ovh.com>
Content-ID: <alpine.LSU.2.20.1610241510040.31007@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-636748606-1477346963=:31007
Content-Type: text/plain; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LSU.2.20.1610241510041.31007@ancalagon.suse.de>

On Thu, 20 Oct 2016, Bart這miej 安i璚ki wrote:

Hi Bart這miej,

WRT the function-returning static trick, yep, it should work as you 
describe. I believe Scott Meyers popularized this "static singleton" 
trick. I pretty much abhorr singletons, but it's super handy way to 
mitigate the "unordered initialization fiasco", which is exactly wher e 
you're going here.

> IIRC this should also ensure that destructors are called when unloading
>the module, not 100% sure about that though.

I seem to remember this biting me, so checked-- it's a "fun" answer: from 
what I can see, the C++ standard says nothing about it, and furthermore 
the POSIX standard doesn't require specific behavior from dlclose(). In 
practice, it probably will happen, but it's not reliable behavior. (But, 
see below.)

I suppose that means the way to go is to write a finalizer (perhaps put 
both that, and the mutable singleton-function in a shared namespace to 
keep them together but make it clear there's no class behavior, and then 
for "const" data, make the finalizer a friend) and calling it before the 
module is unloaded. Imagine this now requires some locks, since the data's 
mutable.

I mentioned this to Bart這miej in a PM, and he pointed out that if the 
module consumer can be sure that nothing's using the memory pools at the 
point of unloading, locking could be avoided. As long as that guarantee 
holds, I agree.

I hope that's helpful,

-Jesse

Also:

The manpage (3 dlopen) has an interesting note under the heading 
"Initialization and finalization functions"-- there are some extensions 
for a sort of constructor/destructor mechanism, and some interesting notes 
about _init() and _fini() that are worth reading.
--8323584-636748606-1477346963=:31007--
