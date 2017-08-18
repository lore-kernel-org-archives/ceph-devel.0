From: Jos Collin <jcollin@redhat.com>
Subject: Re: multi-line comments
Date: Fri, 18 Aug 2017 20:16:06 +0530
Message-ID: <74552be3-a556-3a8b-f232-26fb4c8f1c80@redhat.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
 <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
 <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
 <5996d531.c26f630a.ad731.d0e9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32881 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdHROqL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 10:46:11 -0400
Received: by mail-pg0-f53.google.com with SMTP id t3so37765661pgt.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 07:46:11 -0700 (PDT)
In-Reply-To: <5996d531.c26f630a.ad731.d0e9@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit <amitkuma@redhat.com>, John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 1. I believe multiline text comment is one entity - which you want to
> logically keep together. Line breaks in such a comment are nothing more
> than places to wrap text, so breaking it up into many "separate"
> comments makes no sense to me though. Therefore, I construct a single
> comment block around the whole thing - using /* */.

Using /* */ makes difficulty in later use. Especially in lengthy 
functions and classes where there are lot of comments using /* */. For 
instance, if we want to comment the code and test the functionality. 
While // each line doesn't create this problem.

Try:

void fn1()
{
/*
   /*
    Call add
   */
   obj.add();
*/

   obj.subtract();
}


I hope you got my point.

Regards,
Jos Collin
