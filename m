From: John Spray <jspray@redhat.com>
Subject: Re: Question about cephfs MDS journal
Date: Thu, 31 Mar 2016 12:09:30 +0100
Message-ID: <CALe9h7fOqmBSD9yrrzn2n0Zaq0cWdrSm84avW24CkQh_7xWcPA@mail.gmail.com>
References: <BEBDA66B-72D9-4468-B464-DEB67903EE12@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33288 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbcCaLJv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 07:09:51 -0400
Received: by mail-ob0-f182.google.com with SMTP id x3so95420884obt.0
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 04:09:50 -0700 (PDT)
In-Reply-To: <BEBDA66B-72D9-4468-B464-DEB67903EE12@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: WuJaven <javen.wu@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "peng.hse" <peng.hse@xtaotech.com>

On Thu, Mar 31, 2016 at 4:20 AM, WuJaven <javen.wu@icloud.com> wrote:
> Hi Team,
>
> I have a question about MDS journal trim policy.
> I found the MDS journal would be flushed when the segment number is o=
ver the predefined value (default 30) only in tick thread context.
> If the journal is not over the predefined value, the segments would n=
ot be flushed to the OMAP even eventhrough  the system is not busy.
> My question is what=E2=80=99s the intention for the design?
> I can understand that journal replay is able to restore metadata into=
 memory, there is no negative impact even though the journal is committ=
ed to the backend OMAP.
> Is there any more concern?
> What if we flush the journal segments in the every tick period as alo=
ng as journal is not empty?

In general, we don't want to flush sooner because it would generate a
higher number of metadata IOs overall.  Because many workloads
repeatedly modify the same pieces of metadata, it's beneficial to
coalesce these and only do the final IO when the dirty
inode/dentry/dirfrag "falls off" the end of the journal.  Note that
the dirty_inodes etc members on LogSegments are `elists`, so that when
we dirty an inode on a newer logsegment, it gets implicitly
disassociated from the old logsegement.

However, I have also thought that it would be useful to flush the
journal on idle systems.  Especially, since our new fsck/recovery
functionality benefits from having a fully written-back metadata
store, it would be nice to do this opportunistically if we could
invent a suitable heuristic for detecting idleness.

John

>
> Thanks
> Javen--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
