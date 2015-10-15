From: GuangYang <yguang11@outlook.com>
Subject: OSD cascading crash during recovery with corrupted replica
Date: Wed, 14 Oct 2015 17:20:45 -0700
Message-ID: <BLU175-W16434E04172D4499DD5DEADF3E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s18.hotmail.com ([65.55.111.157]:56093 "EHLO
	BLU004-OMC4S18.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007AbbJOAUq convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Oct 2015 20:20:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sjust@redhat.com" <sjust@redhat.com>, "dzafman@redhat.com" <dzafman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sam/David,
We came across this problem a couple of times and it is extremely painf=
ul to work around it via operational steps, I would like to work on a p=
atch, but before I start, it would be nice hear your suggestions.

The problem is:
On erasure coded pool, when there is a corruption, and the object is a =
recovery candidate, currently it would crash the primary when trying to=
 recover the object, and so on so forth as other OSDs on the acting set=
 to be promoted as primary, until the PG gets down.

Solution:
I think one way to fix it, is to put the object back to recovery waitin=
g list together with the corruption information (add the corrupted shar=
d to peering_missing), and then let it be picked up by the next round o=
f recovery.=A0

Does that sound like a good way to pursue? Do you have any other sugges=
tions I may look into?

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
