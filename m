From: Guang Yang <yguang11@outlook.com>
Subject: OSD suicide after being down/in for one day as it needs to search large amount of objects
Date: Tue, 19 Aug 2014 14:30:11 +0800
Message-ID: <BLU436-SMTP1407B6BAC746323A36B7947DFD50@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s33.hotmail.com ([65.55.111.172]:63625 "EHLO
	BLU004-OMC4S33.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633AbaHSGaV convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Aug 2014 02:30:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>
Cc: david.z1003@yahoo.com

Hi ceph-devel,
David (cc=92ed) reported a bug (http://tracker.ceph.com/issues/9128) wh=
ich we came across in our test cluster during our failure testing, basi=
cally the way to reproduce it was to leave one OSD daemon down and in f=
or a day, at the same time, keep giving write traffic. When the OSD dae=
mon was started again, it hit suicide timeout and kill itself.

After some analysis (details in the bug), David found that the op threa=
d was busy searching for missing objects and once the volume to search =
increase, the thread is expected to work that long time, please refer t=
o the bug for detailed logs.

One simple fix is to let the op thread reset the suicide timeout period=
ically when it is doing long-time work, other fix might be to cut the w=
ork into smaller pieces?

Any suggestion is welcome.

Thanks,
Guang--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
