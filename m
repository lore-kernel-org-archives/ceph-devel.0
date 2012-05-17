From: Sam Just <sam.just@inktank.com>
Subject: Re: OSD Journal Failure Behavior
Date: Thu, 17 May 2012 14:42:15 -0700
Message-ID: <CA+4uBUYSySwaBFGCo0cGqVRGVfaFXyuW+9gynkkxWOrhh9UYxQ@mail.gmail.com>
References: <CADxhoDTd9Jm6xixSqkCmxx8+bj_OSarJ8J_aYm6ycJzH7gHq4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62911 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761026Ab2EQVmP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 17:42:15 -0400
Received: by pbbrp8 with SMTP id rp8so3063846pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 14:42:15 -0700 (PDT)
In-Reply-To: <CADxhoDTd9Jm6xixSqkCmxx8+bj_OSarJ8J_aYm6ycJzH7gHq4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: ceph-devel@vger.kernel.org

Loss of the journal will kill any osds using that journal.  With
btrfs, we theoretically could run without a journal, but it would be
impractically slow.  In the case of parallel journaling, loss of the
journal can result in the loss of updates which have been reported to
the client as committed, but replacing the journal device will be
enough to allow recovery from the replicas to occur.  In the case of
write ahead, loss of the journal can additionally result in
inconsistent data on the osd.  Thus, with write ahead, you should
recreate the osd and allow recovery to occur.

The --mkjournal option is used to recreate the journal on a fresh devic=
e.

This information does need to find its way into our documentation,
thanks for the heads up!

-Sam

On Fri, May 11, 2012 at 11:31 AM, Calvin Morrow <calvin.morrow@gmail.co=
m> wrote:
> The Ceph Wiki (http://ceph.com/wiki/OSD_journal) does a pretty good
> job explaining the purpose of the journal and various modes available=
=2E
> =A0What isn't clear is what happens during the failure of a journal.
>
> With the use of btrfs enabling parallel journaling, it sounds like
> failure of a journal device would still enable OSD writes to occur
> albeit at a slower pace. =A0In writeahead mode, failure of the journa=
l
> seems like it would take all OSDs using that device for journaling
> offline.
>
> Is this a correct assessment? =A0If the journal is a single point of
> failure to a system with potentially multiple OSDs ... it might be
> worth mentioning in one of the "building a cluster" or hardware pages
> about journal redundancy.
>
> Also, it would be nice to know what steps are required to replace a
> journal. =A0(I think this is just an update of the cluster.conf with =
the
> new journal device and a restart of the OSD process, correct?)
>
> Best regards,
> Calvin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
