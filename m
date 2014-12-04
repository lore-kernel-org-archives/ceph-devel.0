From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Chinese translation of Ceph Documentation
Date: Thu, 4 Dec 2014 11:55:33 +0800
Message-ID: <CAJiejCRVS2DORGr=uGvRsFNn98YZzrmLy0KamgW3aR4-tkPvLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44157 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaLDDzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 22:55:54 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so12621172obc.15
        for <ceph-devel@vger.kernel.org>; Wed, 03 Dec 2014 19:55:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux-fs <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

Hi,

    I have migrated my Chinese translation from PDF to Ceph official
doc build system. Just replace doc/ in ceph repository with this repo,
the building should be work. The  official doc build guide should be
work for this too.

Old PDF: https://github.com/drunkard/docs_zh
New: https://github.com/drunkard/ceph-doc-zh_CN
The html output: https://github.com/drunkard/docs_zh/tree/master/output/html

    There's a lot changes to sync with mainline since my last updates,
will do it in spare time :)

    There's some issues to resolve:

1. The build system doesn't support python3 yet, so if you are using
python3 as default interpreter, you shoule switch to python2
temporarily.

2. Building of man pages will fail, changes needed to support
non-ascii encoding. HTML version is fine.

Any way, I'm improving it ;) Any help is welcome!
