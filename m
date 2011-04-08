From: Fyodor Ustinov <ufm@ufm.su>
Subject: mds and cpu
Date: Fri, 8 Apr 2011 23:28:16 +0000 (UTC)
Message-ID: <loom.20110409T012433-939@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44871 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab1DHX23 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Apr 2011 19:28:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q8L6K-0008Tz-AU
	for ceph-devel@vger.kernel.org; Sat, 09 Apr 2011 01:28:28 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Apr 2011 01:28:28 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Apr 2011 01:28:28 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

Looks as if mds uses only 1 cpu on the connection. This is so, or I mad=
e =E2=80=8B=E2=80=8Ba
mistake somewhere in the settings?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
