From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Why FailedAssertion is not my favorite exception
Date: Fri, 4 Dec 2015 12:44:59 -0800
Message-ID: <CAJ4mKGa3mEwDkF_fGJafwsqgC6JavhqFkxn3zhVFL3fftDb2rA@mail.gmail.com>
References: <20151204203129.GA10038@ultraspiritum.redhat.com>
	<CAJ4mKGbg+wadiRnTsXbdZoWfv5PHQRUvYU=U=J03PG1k8yQdhA@mail.gmail.com>
	<20151204204035.GC10038@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37639 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbbLDUpB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 15:45:01 -0500
Received: by wmww144 with SMTP id w144so79994100wmw.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 12:45:00 -0800 (PST)
In-Reply-To: <20151204204035.GC10038@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Ceph Developers <ceph-devel@vger.kernel.org>

On Fri, Dec 4, 2015 at 12:40 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 04/12/2015, Gregory Farnum wrote:
>> I must be missing something here. As far as I can tell, "throw
>> FailedAssertion" only happens in assert.cc, and I know that stuff
>> doesn't destroy the relevant stack frames since I've pulled the info
>> out of core dumps when debugging?
>> -Greg
>
> The behavior I'm seeing is that when I am attached to a process with gdb, and
> an assertion fails it bounces all the way up to terminate with an uncaught
> exception.

Oh, yeah, I've no idea what it does when you're attached. I just want
to make sure it's generating core dump files on assert failure (that
is by far the most common way of generating and analyzing issues),
which it looks like abort() does, so fine with me. :)
-Greg
