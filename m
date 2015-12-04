From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Why FailedAssertion is not my favorite exception
Date: Fri, 4 Dec 2015 12:37:18 -0800
Message-ID: <CAJ4mKGbg+wadiRnTsXbdZoWfv5PHQRUvYU=U=J03PG1k8yQdhA@mail.gmail.com>
References: <20151204203129.GA10038@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33825 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbbLDUhT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 15:37:19 -0500
Received: by wmvv187 with SMTP id v187so91293903wmv.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 12:37:18 -0800 (PST)
In-Reply-To: <20151204203129.GA10038@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>

On Fri, Dec 4, 2015 at 12:31 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> Noble Creators of the Squid Cybernetic Swimming in a Distributed Data Sea,
>
> There is a spectre haunting src/common/assert.cc: The spectre of throw
> FailedAssertion.
>
> This seemingly inconsequential yet villainous statement destroys the
> stack frame in which a failing assert statement is evaluated-- a stack
> frame of great interest to those hoping to divine the cause of such
> failures-- at the moment of their detection.
>
> This consequence follows from the hope that some caller might be able to
> catch and recover from the failure. That is an unworthy goal, for any
> failure sufficiently dire to rate an 'assert' is a failure from which
> there can be no recovery. As I survey the code, I see FailedAssertion
> is only caught as part of unit tests and in a few small programs where
> it lead to an immediate exit.
>
> Therefore! If there is no objection, I would like to submit a patch that
> will replace 'throw FailedException' with abort(). In support of this
> goal, the patch will also remove attempts to catch FailedException from
> driver programs like librados-config and change tests expecting a throw
> of FailedAssertion to use the EXPECT_DEATH or ASSERT_DEATH macros instead.
>
> These changes, taken together, should be non-disruptive and make
> debugging easier.

I must be missing something here. As far as I can tell, "throw
FailedAssertion" only happens in assert.cc, and I know that stuff
doesn't destroy the relevant stack frames since I've pulled the info
out of core dumps when debugging?
-Greg
