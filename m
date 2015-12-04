From: Sage Weil <sage@newdream.net>
Subject: Re: Why FailedAssertion is not my favorite exception
Date: Fri, 4 Dec 2015 12:35:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512041234550.3431@cobra.newdream.net>
References: <20151204203129.GA10038@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42059 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbLDUfz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 15:35:55 -0500
In-Reply-To: <20151204203129.GA10038@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>

On Fri, 4 Dec 2015, Adam C. Emerson wrote:
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

Sounds good.  Feel free to replace the code the deliberately induces a 
segv with abort(), too... I wasn't aware of it when writing the original 
code.

sage
