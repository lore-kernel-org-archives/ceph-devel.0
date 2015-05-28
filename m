From: Dan van der Ster <dan@vanderster.com>
Subject: python-ceph centos7 epel issues
Date: Thu, 28 May 2015 15:38:51 +0200
Message-ID: <CABZ+qq==Dr-VAmnNjUSK5vyGhHZFw88pBFiVGBQxLS=JMAt_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34578 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbE1Nje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 09:39:34 -0400
Received: by obew15 with SMTP id w15so32939593obe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 06:39:33 -0700 (PDT)
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com. [209.85.218.50])
        by mx.google.com with ESMTPSA id qx8sm1189679oeb.15.2015.05.28.06.39.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 06:39:32 -0700 (PDT)
Received: by oifu123 with SMTP id u123so32328995oif.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 06:39:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ken,

I'm having trouble installing ceph cleanly on CentOS 7 -- I guess this
is related to https://bugzilla.redhat.com/1193182.

(1) If I disable epel-testing, and have check_obsoletes = 1, then the
install works [ http://pastebin.com/gvHbRJ3T ].

(2) With epel-testing enabled -- to get your new -0.5 "fixed"
python-ceph rpms -- the install fails in two different ways, depending
on check_obsoletes. With check_obsoletes = 1 [
http://pastebin.com/AWRdP2Hh ] and without it [
http://pastebin.com/8Uxj6N1s ]

Do you understand what's happening with the -0.5 package? In the
meantime we're doing (1) above to install ceph.

Thanks, Dan
