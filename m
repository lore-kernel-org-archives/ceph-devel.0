From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 14:18:37 -0700
Message-ID: <CA+55aFxZRUn333pP3fNN9NDLxp_JiZu+=vJH=k6gohQtDQRA5Q@mail.gmail.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
	<CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
	<alpine.DEB.2.11.1605261446230.6221@cpach.fuggernut.com>
	<CA+55aFygBAq19UXECwQf_crUqNH4btTDircZJ=CctAHtFhnexw@mail.gmail.com>
	<20160526201011.GM14480@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160526201011.GM14480@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 26, 2016 at 1:10 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How about the things like followups to earlier merges?

Small and obvious follow-ups are fine. What I really hated about this
ceph pull request was that it was multiple thousand lines of changes,
with no previous work or warning, and effectively no time in
linux-next.

Your for-linus branch is three small commits that actually restore old
functionality (well, one of them is documentetion) that got removed by
the big stuff you sent early (*).

So not at all the same kind of thing, and not problematic at all.

              Linus

(*) thanks, btw - you used to be one of the late people, now lately
you've been one of the early ones.
