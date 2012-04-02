From: Marco Aroldi <marco.aroldi@gmail.com>
Subject: Failed HD, automate procedure?
Date: Mon, 2 Apr 2012 12:31:17 +0200
Message-ID: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49196 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2DBKbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 06:31:18 -0400
Received: by bkcik5 with SMTP id ik5so2298513bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Apr 2012 03:31:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
i'm looking the procedure to replace a failed HD
(http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD)
and I was wondering if the procedure could be more automated like:

1- The operator replaces the failed hd, say osd.23
2- Give a new command like "ceph reborn osd.23"

Thanks, thanks to all the community for this big piece of software!
Marco Aroldi
