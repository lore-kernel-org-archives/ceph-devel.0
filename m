From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 13:22:11 -0400
Message-ID: <CACkq2moOSBqzioacAHECdZQx9uahGLjGFkSNHdHf6JkxTDzMog@mail.gmail.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
 <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com> <505311CD02000099000EA409@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38069 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2INRWc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 13:22:32 -0400
Received: by qaas11 with SMTP id s11so53445qaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 10:22:32 -0700 (PDT)
In-Reply-To: <505311CD02000099000EA409@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

> If it's safe to defrag xfs while it's mounted in general, it's safe to
> do it when an OSD is running. Xfs either keeps its promises as a
> filesystem, or doesn't.

That was my expectation.  Thanks for the feedback.  Just wanted to confirm.

Also, I will report back on -o allocsize.  Probably some time next
week.  Got a few other things to take care of first.

Thanks again!

 - Travis

On Fri, Sep 14, 2012 at 1:15 PM, Nick Couchman <Nick.Couchman@seakr.com> wrote:
>>
>>> While I'm talking about XFS...  I know that RBD's use a default object
>>> size of 4MB.  I've stuck with that so far..  Would it be beneficial to
>>> mount XFS with -o allocsize=4M ?  What is the object size that gets
>>> used for non-RBD cases -- i.e. just dumping objects into data pool?
>>
>> Don't know about -o allocsize -- benchmark it!
>
> ...and let us know what you come up with!  I'm also using XFS for the underlying filesystem on which CEPH runs (and using RBD), and would be really interested to know if changing the alloc size improves performance!
>
> -Nick
>
>
>
>
> --------
>
> This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
