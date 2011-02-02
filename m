From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: gcov/lcov
Date: Tue, 1 Feb 2011 18:42:08 -0800
Message-ID: <AANLkTi=RXwrAmJr9A91zw_-FPsH1hNE7X_wpM5uEsc7U@mail.gmail.com>
References: <Pine.LNX.4.64.1101312121050.8040@cobra.newdream.net>
	<20110201172740.GA13828@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49911 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab1BBCmK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 21:42:10 -0500
Received: by fxm20 with SMTP id 20so7538642fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 18:42:09 -0800 (PST)
In-Reply-To: <20110201172740.GA13828@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Feb 1, 2011 at 9:27 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Mon, Jan 31, 2011 at 09:21:14PM -0800, Sage Weil wrote:
>> We should set up gcov/lcov as part of the testing infrastructure so =
we can
>> track what code paths are tested:
>>
>> =A0 =A0 =A0 =A0 http://ltp.sourceforge.net/coverage/lcov.php

That's pretty cool. It seems like this should be usable with both
system tests and unit tests.

On Tue, Feb 1, 2011 at 9:27 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> Please write unit
> tests, because otherwise the first coverage reports are going to be
> really disappointing ;)

Oh, by the way, I actually did write PG history merging unit test I
was talking about. It's in the refactor_pg branch now.

Eventually we should start unit testing more complex history merges.
But the current test is a start at least.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
