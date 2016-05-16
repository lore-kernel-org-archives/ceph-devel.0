From: Yuri Weinstein <yweinste@redhat.com>
Subject: Nightlies scheduling changes
Date: Mon, 16 May 2016 09:00:04 -0700
Message-ID: <CAMMFjmGB5UZ-ZYe=o-DHAAhcAXqgWSpu3zjJvm4dgLpatsS54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36608 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbcEPQAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 12:00:06 -0400
Received: by mail-wm0-f44.google.com with SMTP id n129so106942689wmn.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2016 09:00:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, ceph-infra@redhat.com, "Mick, Dan" <dmick@redhat.com>, "Cerza, Zack" <zack@redhat.com>, "Weil, Sage" <sage@redhat.com>

We've made changes in the way crontab entries (used for scheduling
nightlies suites) send emails on success/failure.

From now on, emails will be sent *only* if there was an error observed
during scheduling (see http://tracker.ceph.com/issues/15563 for
details).
A log file(s) will be stored (and log rotated) in
/var/log/crontab-nightlies-log/

This change was deployed in sepia and ovh labs.

Thx
YuriW
