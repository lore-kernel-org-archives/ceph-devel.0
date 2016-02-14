From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Help in analyzing Jenkins output
Date: Sun, 14 Feb 2016 11:46:39 -0800
Message-ID: <CAJ4mKGaQjLFzO3gfD=iDw-12xY+XZNcVks_r2uenw+Q7jYx8jQ@mail.gmail.com>
References: <56C07822.5080600@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35288 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcBNTql (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Feb 2016 14:46:41 -0500
Received: by mail-wm0-f52.google.com with SMTP id c200so86310104wme.0
        for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 11:46:40 -0800 (PST)
In-Reply-To: <56C07822.5080600@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Feb 14, 2016 at 4:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> I'm having a bit of trouble in finding the actual error in
>
> https://jenkins.ceph.com/job/ceph-pull-requests/1419/console
>
> The first few python warning/errors seem harmless, because the tests
> are actually run.
> Then 'bash -x tests/ceph-disk.sh' is run, which generates a lot of
> output. But I'm missing the point where that generates an error.
>
> Could somebody help me point out where the error is that makes this test
> fail??
>
> The test ATM fails under FreeBSD because of other errors still in some
> of the scripts and programs..
> So testing it there doest not even get as far as this point.

Search for "FAIL:" and you get:
> FAIL: ceph-disk/run-tox.sh

and then farther down a big block of output from that test. It's angry
about a bunch of python syntax issues.
There's also what looks like an unexpected network disconnect at the
end; we've been having network troubles and the jenkins bot is failing
intermittently.
-Greg
