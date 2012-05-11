From: Tommi Virtanen <tv@inktank.com>
Subject: Re: "converting" btrfs osds to xfs?
Date: Thu, 10 May 2012 17:23:08 -0700
Message-ID: <CADvuQRHq6Ljp6bnwgicrHRrjqf-5mfJ2muwSHeNn688cdYtwUQ@mail.gmail.com>
References: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
 <CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
 <Pine.LNX.4.64.1205081238010.14100@cobra.newdream.net> <CAPud5_5fsBXX-N-SM7P7Fouba+9P2Nt5aAPfq+nLkUcN4_d5OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54299 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2EKAX2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 20:23:28 -0400
Received: by dady13 with SMTP id y13so2348762dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 17:23:28 -0700 (PDT)
In-Reply-To: <CAPud5_5fsBXX-N-SM7P7Fouba+9P2Nt5aAPfq+nLkUcN4_d5OQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 10, 2012 at 3:44 PM, Nick Bartos <nick@pistoncloud.com> wrote:
> After I run the 'ceph osd out 123' command, is there a specific ceph
> command I can poll so I know when it's OK to kill the OSD daemon and
> begin the reformat process?

Good question! "ceph -s" will show you that. This is from a run where
I ran "ceph osd out 1" on a cluster of 3 osds. See the active+clean
counts going up and active+recovering counts going down, and the
"degraded" percentage dropping. The last line is an example of an "all
done" situation.

2012-05-10 17:19:47.376864    pg v144: 24 pgs: 14 active+clean, 10
active+recovering; 180 MB data, 100217 MB used, 173 GB / 285 GB avail;
88/132 degraded (66.667%)

2012-05-10 17:19:59.220607    pg v146: 24 pgs: 19 active+clean, 5
active+recovering; 180 MB data, 100227 MB used, 173 GB / 285 GB avail;
24/132 degraded (18.182%)

2012-05-10 17:20:16.522978    pg v148: 24 pgs: 24 active+clean; 180 MB
data, 100146 MB used, 173 GB / 285 GB avail

If you want a lower-level double-check, you can peek inside the osd
data directory and see that the "current" subdirectory has no *_head
entries, du is low, etc.
