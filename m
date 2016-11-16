From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 17:10:18 -0500
Message-ID: <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbcKPWLx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 17:11:53 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 627B4335E87
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 22:11:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 16/11/2016, Gregory Farnum wrote:
> It turns out, Jenkins assumes the build is good if the build script
> returns 0 — it doesn't know anything about the actual text output and
> doesn't scan for warnings.
> I'm not sure how hard it would be to change things from that end. From
> the *compilation* end, Casey suggests the "nicest" thing would be to
> set the -Werr flag, which turns all warnings into errors. Since we
> like warning-free code, that's definitely appealing to me.
> Unfortunately, we've got a problem: boost is notorious for build
> warnings. At the moment, I'm only seeing one (repeated many times
> over) resulting from use of the "remove_whitespace" iterator
> functionality in RGW. Does anybody know a good way to handle that?

I have a fix for this in my Clangtastic branch, it turns off warnings
in the building of boost and makes inluded boost a system include.

> We also have another (seemingly real) warning: the BlueStore
> BitAllocator says there are missing return statements in
> BmapEntry::operator new [](size_t). I didn't look at the code; maybe
> it's failing to detect return statements in an if-else block. But that
> should be fixed up as well.

I have a fix for that I'm about to push, I just have it return nullptr
and mark it noexcept.

(We could also make it throw something and remove the assert entirely,
but this is more in tune with the current pattern.)

> 1) The Ceph source should build warning-free. If we have warnings
> from external code we still trust, we need a way to suppress *only*
> those warnings so that issues we introduce can easily be detected.

This is in principle fairly easily done with cmake hackery. Either
marking something as a system include path or fiddling the build flags
per-target.

> 2) Patches that generate new warnings should not be merged.

I agree while-heartedly!

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
