From: Dong Wu <archer.wudong@gmail.com>
Subject: why not add (offset,len) to pglog
Date: Fri, 25 Dec 2015 11:16:28 +0800
Message-ID: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35448 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbLYDQ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Dec 2015 22:16:29 -0500
Received: by mail-pf0-f173.google.com with SMTP id 78so73546334pfw.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Dec 2015 19:16:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,
I have doubt about pglog, the pglog contains (op,object,version) etc.
when peering, use pglog to construct missing list,then recover the
whole object in missing list even if different data among replicas is
less then a whole object data(eg,4MB).
why not add (offset,len) to pglog? If so, the missing list can contain
(object, offset, len), then we can reduce recover data.
