From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cannot delete some empty dirs and weird sizes
Date: Tue, 31 Jan 2012 10:40:23 -0800
Message-ID: <CAF3hT9AE9A0d_rdGN+W=wHQG1ksUJkg0H1+-eQh1n+5ZOBn2Hg@mail.gmail.com>
References: <201201311300.20787.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52060 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab2AaSkY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 13:40:24 -0500
Received: by iacb35 with SMTP id b35so307350iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 10:40:23 -0800 (PST)
In-Reply-To: <201201311300.20787.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Tue, Jan 31, 2012 at 4:00 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Hi again!
>
> We are running Ceph 0.41 and kernel 3.2.2 with current for-linus code (commit
> 3d882ce47de80e0294a536bec771b5651885b4d3) now.
>
> After some heavy workloads we see quite a few directories that cannot be
> deleted, although ls and find show that they are empty. rmdir says they are
> not empty.
>
> Additionally, ceph reports various weird size values for some, but not all of
> them:
> ls -la .tmp/tiny61/.mozilla/firefox/default.yat/
> insgesamt 0
> drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 .
> drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 ..
>
> Is this a known or a new bug? Can it be related to .snap pseudo dirs? The
> problem appeared without ever using snapshots, though.

I believe this is new. Based on the odd sizes (that's a 64-bit -1
interpreted as unsigned, fyi), my guess is that the "recursive
accounting" statistics are off and that's leading the MDS to believe
the directory is not empty even though it is. It's unlikely to be
directly related to snapshots, though it's not impossible.

Have you seen this on more than one MDS? If it's reproducible we could
more easily figure out the cause; otherwise the best we can do is to
maybe fix up the specific instance of it.
-Greg
