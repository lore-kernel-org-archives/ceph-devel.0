From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [Ceph - Bug #14664] (New) valgrind: mmap(...) failed in UME with
 error 12 (Cannot allocate memory).
Date: Fri, 12 Feb 2016 10:35:08 -0800
Message-ID: <CAJ4mKGb6YM25g3tpSkTbG+HxVgQadAvw4x5Gwfr94LR7WW7eCA@mail.gmail.com>
References: <redmine.issue-14664.20160205062333@tracker.ceph.com>
	<redmine.issue-14664.20160205062333.9e0e78b35c3f3488@tracker.ceph.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34756 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcBLSfK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Feb 2016 13:35:10 -0500
Received: by mail-wm0-f44.google.com with SMTP id 128so73542177wmz.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Feb 2016 10:35:09 -0800 (PST)
In-Reply-To: <redmine.issue-14664.20160205062333.9e0e78b35c3f3488@tracker.ceph.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

This bug is showing up a bit for me as well, on Ubuntu. Are we just
waiting hopefully for the distros to release new valgrind packages for
this to go away, or do we have a plan?
I'm concerned that we might not get fixed packages at all =E2=80=94 if =
I'm
understanding this correctly it's a result of us running new kernels
against "old" valgrind, and the distros obviously don't upgrade their
kernels like we are...
-Greg

On Thu, Feb 4, 2016 at 10:23 PM,  <redmine@tracker.ceph.com> wrote:
> Issue #14664 has been reported by Loic Dachary.
> ________________________________
>
> Bug #14664: valgrind: mmap(...) failed in UME with error 12 (Cannot a=
llocate
> memory).
>
> Author: Loic Dachary
> Status: New
> Priority: Normal
> Assignee:
> Category:
> Target version:
> Source: other
> Tags:
> Backport:
> Regression: No
> Severity: 3 - minor
> Reviewed:
> Affected Versions:
> ceph-qa-suite:
> Release:
>
> http://pulpito.ceph.com/loic-2016-02-04_00:33:20-rados-infernalis-bac=
kports---basic-multi/6141/
>
> CommandFailedError: Command failed on smithi054 with status 1: 'sudo =
ceph
> osd crush tunables default'
>
> 2016-02-04T01:11:56.731 INFO:teuthology.orchestra.run.smithi054:Runni=
ng:
> 'sudo ceph osd crush tunables default'
> 2016-02-04T01:11:56.847 INFO:tasks.ceph.mon.a.smithi054.stderr:valgri=
nd:
> mmap(0xaf5000, 131072) failed in UME with error 12 (Cannot allocate m=
emory).
> 2016-02-04T01:11:56.848 INFO:tasks.ceph.mon.c.smithi054.stderr:valgri=
nd:
> mmap(0xaf5000, 131072) failed in UME with error 12 (Cannot allocate m=
emory).
>
> ________________________________
>
> You have received this notification because you have either subscribe=
d to
> it, or are involved in it.
> To change your notification preferences, please click here:
> http://tracker.ceph.com/my/account
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
