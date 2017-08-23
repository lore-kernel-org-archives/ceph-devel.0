From: Linux Chips <linux.chips@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Wed, 23 Aug 2017 15:21:54 +0300
Message-ID: <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com>
 <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36600 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbdHWMV5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 08:21:57 -0400
Received: by mail-wm0-f44.google.com with SMTP id z132so14418566wmg.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 05:21:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mustafa Muhammad <mustafa1024m@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/23/2017 01:33 AM, Sage Weil wrote:
> One other trick that has been used here: if you look inside the PG
> directories on the OSDs and find that they are mostly empty then it's
> possible some of the memory and peering overhead is related to
> empty and useless PG instances on the wrong OSDs.  You can write a script
> to find empty directories (or ones that only contain the single pgmeta
> object with a mostly-empty name) and remove them (using
> ceph-objectstore-tool).  (For safety I'd recommend doing
> ceph-objectstore-tool export first, just in case there is some useful
> metadata there.)
> 
> That will only help if most of the pg dirs look empty, though.  If so,
> it's worth a shot!
> 
> The other thing we once did was use a kludge patch to trim the
> past_intervals metadata, which was respnosible for most of the memory
> usage.  I can't tell from the profile in this thread if that is the case
> or not.  There is a patch floating around in git somewhere that can be
> reused if it looks like that is the thing consuming the memory.
> 
> sage
> 
> 

we ll try the empty pg search. not sure how much is there, but i 
randomly checked and found a few.

as for the "kludge" patch, where can I find it. I searched the git repo, 
but could not identify it. did not know what to look for specifically.
also, what would we need to better know if the patch would be useful?
e.g. if we need another/more mem profiling.

we installed a test cluster of 4 nodes and replicated the issue there, 
and we are testing various scenarios there. if any one cares to 
replicate it i can elaborate on the steps.

if all failed, do you think moving pgs out of the current dir is safe? 
we are trying to test it, but we ll never be sure 100%

thanks
ali


