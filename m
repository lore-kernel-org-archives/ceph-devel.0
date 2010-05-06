From: Martin Fick <mogulguy@yahoo.com>
Subject: RBD/OSD questions
Date: Thu, 6 May 2010 09:07:13 -0700 (PDT)
Message-ID: <853578.71750.qm@web36102.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36102.mail.mud.yahoo.com ([66.163.179.216]:48286 "HELO
	web36102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932146Ab0EFQHP convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 12:07:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a few more questions.

-Can files stored in the OSD heal "incrementally"?

Suppose there are 3 replicas for a large file and that
a small byte range change occurs while replica 3 is=20
down.=A0 Will replica 3 heal efficiently when it=20
returns?=A0 Will only the small changed byte range=20
be transferred?


-Also, can reads be spreadout over replicas?

This might be a nice optimization to reduce seek
times under certain conditions, when there are no
writers or the writer is the only reader (and thus
is aware of all the writes even before they=20
complete).  Under these conditions it seems like it
would be possible to not enforce the "tail reading"
order of replicas and thus additionally benefit
from "read stripping" across the replicas the way
many raid implementations do with RAID1.

I thought that this might be particularly useful
for RBD when it is used exclusively (say by mounting
a local FS)  since even with replicas, it seems like
it could then relax the replica tail reading=20
constraint.

Any thoughts?  Thanks,

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
