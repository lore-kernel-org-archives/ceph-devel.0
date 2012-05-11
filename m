From: Tommi Virtanen <tv@inktank.com>
Subject: Re: "converting" btrfs osds to xfs?
Date: Thu, 10 May 2012 17:47:09 -0700
Message-ID: <CADvuQRFpxwpwp3yw6j_dX2vJnG31dt6=1+Nrq2KjfsrBv_K1=w@mail.gmail.com>
References: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
 <CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
 <Pine.LNX.4.64.1205081238010.14100@cobra.newdream.net> <CAPud5_5fsBXX-N-SM7P7Fouba+9P2Nt5aAPfq+nLkUcN4_d5OQ@mail.gmail.com>
 <CADvuQRHq6Ljp6bnwgicrHRrjqf-5mfJ2muwSHeNn688cdYtwUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34901 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab2EKAra (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 20:47:30 -0400
Received: by dady13 with SMTP id y13so2368308dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 17:47:29 -0700 (PDT)
In-Reply-To: <CADvuQRHq6Ljp6bnwgicrHRrjqf-5mfJ2muwSHeNn688cdYtwUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 10, 2012 at 5:23 PM, Tommi Virtanen <tv@inktank.com> wrote:
> Good question! "ceph -s" will show you that. This is from a run where
> I ran "ceph osd out 1" on a cluster of 3 osds. See the active+clean
> counts going up and active+recovering counts going down, and the
> "degraded" percentage dropping. The last line is an example of an "all
> done" situation.

Oh, and if your cluster is busy enough that there's always some
rebalancing going on, you might never get to 100% active+clean. In
that case, I do believe that "ceph pg dump" probably contains all the
information needed, and --format=json makes it parseable, but it's
just not currently documented. We really should provide a good way of
accessing that information.

I filed http://tracker.newdream.net/issues/2394 to keep track of this task.
