From: Yuri Weinstein <yweinste@redhat.com>
Subject: 0.94.8 QE validation - on-hold
Date: Mon, 15 Aug 2016 16:19:37 -0700
Message-ID: <CAMMFjmG7sa8zL7mSJzaLyivYv-j2GLx9rW-=XLT=Z8L_eG2hbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38308 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbcHOXTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 19:19:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id o80so132026437wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 16:19:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, Brad Hubbard <bhubbard@redhat.com>

Nathan,

Based on a small subset of suites ran so far, one issue seems persisting -

http://tracker.ceph.com/issues/17035
"saw valgrind issues" in hammer 0.94.8 release

I need your assessment if we need to fix this issue before continuing
QE validation of this point release.

Holding on further validations till we make this decision.

Thx
YuriW
