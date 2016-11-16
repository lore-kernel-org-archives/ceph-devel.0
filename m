From: Sage Weil <sweil@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 23:10:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611162310220.12110@piezo.us.to>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com> <CALe9h7eC_JqpbfDzJek-4MS1bW35MTVhPDYJCQYd+3RFqGL22w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1967156191-1479337852=:12110"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbcKPXKx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 18:10:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C9EBC05490A
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 23:10:52 +0000 (UTC)
In-Reply-To: <CALe9h7eC_JqpbfDzJek-4MS1bW35MTVhPDYJCQYd+3RFqGL22w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1967156191-1479337852=:12110
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 16 Nov 2016, John Spray wrote:
> On Wed, Nov 16, 2016 at 10:05 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > Recently, Patrick noticed an issue with the MDS TrackedOp
> > implementation where we weren't actually dumping out the event lists
> > anywhere. It turned out to be as a result of an incorrect cleanup, and
> > he fixed it by just reverting the commit in
> > https://github.com/ceph/ceph/pull/11985.
> >
> > But we also wanted to clean up the spurious "now" parameter which goes
> > on used, and John did that in https://github.com/ceph/ceph/pull/12007.
> > It was reviewed by Patrick, Kefu, and myself and got merged with green
> > checkboxes (ie, Github and Jenkins agreed it was good).
> >
> > Then Patrick noticed we'd missed the Monitor's use of TrackedOp code
> > and it was spawning warnings because the relevant _dump() functions no
> > longer had matching parameter lists
> > (https://github.com/ceph/ceph/pull/12029). This concerned me since
> > we'd gotten a pass from Jenkins.
> >
> > It turns out, Jenkins assumes the build is good if the build script
> > returns 0 — it doesn't know anything about the actual text output and
> > doesn't scan for warnings.
> > I'm not sure how hard it would be to change things from that end. From
> > the *compilation* end, Casey suggests the "nicest" thing would be to
> > set the -Werr flag, which turns all warnings into errors. Since we
> > like warning-free code, that's definitely appealing to me.
> > Unfortunately, we've got a problem: boost is notorious for build
> > warnings. At the moment, I'm only seeing one (repeated many times
> > over) resulting from use of the "remove_whitespace" iterator
> > functionality in RGW. Does anybody know a good way to handle that?
> >
> > We also have another (seemingly real) warning: the BlueStore
> > BitAllocator says there are missing return statements in
> > BmapEntry::operator new [](size_t). I didn't look at the code; maybe
> > it's failing to detect return statements in an if-else block. But that
> > should be fixed up as well.
> >
> > So, I guess I'll just throw out a few statements and see how people
> > react to them:
> >
> > 1) The Ceph source should build warning-free. If we have warnings from
> > external code we still trust, we need a way to suppress *only* those
> > warnings so that issues we introduce can easily be detected.
> >
> > 2) Patches that generate new warnings should not be merged.
> >
> > 3) We should turn on -Werr just as soon as the existing BlueStore
> > warning is fixed and the boost warnings can be suppressed. That should
> > happen quickly.
> >
> > 4) If we do that, I guess the existing Jenkins is okay?
> 
> Yes to all points.

Yep!

I have a patch fixing the bluestore warning buried in another series; I'll 
separate it out and submit it separately.

sage
--8323329-1967156191-1479337852=:12110--
