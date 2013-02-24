From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS: stable release?
Date: Sun, 24 Feb 2013 14:41:27 -0800
Message-ID: <655D5B8BA34841288B351F2C19C68F34@inktank.com>
References: <CAJH6TXh12ocVd00Vf5GaTxF53nxg0gxt9CUP=8YntaNznCtG-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34639 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759357Ab3BXWl3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Feb 2013 17:41:29 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1313874pbc.38
        for <ceph-devel@vger.kernel.org>; Sun, 24 Feb 2013 14:41:28 -0800 (PST)
In-Reply-To: <CAJH6TXh12ocVd00Vf5GaTxF53nxg0gxt9CUP=8YntaNznCtG-w@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Saturday, February 23, 2013 at 2:14 AM, Gandalf Corvotempesta wrote:
> Hi all,
> do you have an ETA about a stable realease (or something usable in
> production) for CephFS?

Short answer: no. 

However, we do have a team of people working on the FS again as of a month or so ago. We're doing a lot of stabilization (bug fixes), code cleanups, and utility work in the coming months; we can estimate the utility and cleanup work but not the bugs that we'll find, and those are our main concern right now. Depending on how the next couple months of QA and bug fixing go we should be able to publicize real estimates soonish.
-Greg

