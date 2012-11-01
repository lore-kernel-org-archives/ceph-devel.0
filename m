From: Nathan Howell <nathan.d.howell@gmail.com>
Subject: Re: Cephfs losing files and corrupting others
Date: Thu, 1 Nov 2012 16:30:33 -0700
Message-ID: <CAD84eiHm84hOAi-VdgVZPvfRWOHCup6sWXpJHGvV+Wcd9sA6vQ@mail.gmail.com>
References: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
	<5092F860.7040708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58086 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab2KAXad (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 19:30:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3121079obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 16:30:33 -0700 (PDT)
In-Reply-To: <5092F860.7040708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>, Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 1, 2012 at 3:32 PM, Sam Lang <sam.lang@inktank.com> wrote:
> Do the writes succeed?  I.e. the programs creating the files don't get
> errors back?  Are you seeing any problems with the ceph mds or osd processes
> crashing?  Can you describe your I/O workload during these bulk loads?  How
> many files, how much data, multiple clients writing, etc.
>
> As far as I know, there haven't been any fixes to 0.48.2 to resolve problems
> like yours.  You might try the ceph fuse client to see if you get the same
> behavior.  If not, then at least we have narrowed down the problem to the
> ceph kernel client.

Yes, the writes succeed. Wednesday's failure looked like this:

1) rsync 100-200mb tarball directly into ceph from a remote site
2) untar ~500 files from tarball in ceph into a new directory in ceph
3) wait for a while
4) the .tar file and some log files disappeared but the untarred files were fine

Total filesystem size is:

pgmap v2221244: 960 pgs: 960 active+clean; 2418 GB data, 7293 GB used,
6151 GB / 13972 GB avail

Generally our load looks like:

Constant trickle of 1-2mb files from 3 machines, about 1GB per day
total. No file is written to by more than 1 machine, but the files go
into shared directories.

Grid jobs are running constantly and are doing sequential reads from
the filesystem. Compute nodes have the filesystem mounted read-only.
They're primarily located at a remote site (~40ms away) and tend to
average 1-2 megabits/sec.

Nightly data jobs load in ~10GB from a few remote sites in to <10
large files. These are split up into about 1000 smaller files but the
originals are also kept. All of this is done on one machine. The
journals and osd drives are write saturated while this is going on.


On Thu, Nov 1, 2012 at 4:02 PM, Gregory Farnum <greg@inktank.com> wrote:
> Are you using hard links, by any chance?

No, we are using a handfull of soft links though.


> Do you have one or many MDS systems?

ceph mds stat says: e686: 1/1/1 up {0=xxx=up:active}, 2 up:standby


> What filesystem are you using on your OSDs?

btrfs


thanks,
-n
