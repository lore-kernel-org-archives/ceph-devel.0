From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: branches
Date: Tue, 08 Jan 2013 12:48:26 -0600
Message-ID: <50EC69FA.2030205@inktank.com>
References: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64009 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab3AHSs2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 13:48:28 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so654124iay.5
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 10:48:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/08/2013 12:39 PM, Sage Weil wrote:
> I'd like to adjust the branches we're maintaining in ceph.git.  Currently:
>
> master
>   - active development
> next
>   - frozen for next release
>   - bug fixes only
>   - regularly merged back into master
> testing
>   - last development release
>   - cherry-pick -x'd critical fixes
>   - packages at ceph.com/debian-testing, /rpm-testing
> stable
>   - argonaut long-term backport series
>   - cherry-pick -x'd critical fixes
>   - packages at ceph.com/debian-argonaut, /debian
>
> The stable is ambiguous, and testing is a confusing name.  Instead, I
> propose:
>
> master  -- same
> next    -- same
> last
>   - last release (instead of 'testing')
>   - packages at /debian-testing and /debian-last, /rpm-testing, /rpm-last

I actually think I liked the testing name, but don't have a real strong 
opinion.

> bobtail
>   - bobtail backport series 0.56.x
>   - packages at /debian-bobtail (and /debian, until cuttlefish),
>     /rpm-bobtail, /rpm
> argonaut
>   - argonaut backport series 0.48.x
>   - packages at /debian-argonaut
>

Definitely yes.

> We'll need to update the parallel branches in teuthology.git,
> ceph-qa-suite.git, and s3-tests.git to match.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

