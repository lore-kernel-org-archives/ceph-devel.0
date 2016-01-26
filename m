From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: _do_op and finish_op in filestore
Date: Tue, 26 Jan 2016 21:54:18 +0800
Message-ID: <CANE=7sUva4bNWgJEnVcu6czgPqS3sUxgNySn_pCQ2T6VVJwKsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33105 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965102AbcAZNyT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 08:54:19 -0500
Received: by mail-ob0-f171.google.com with SMTP id is5so143382538obc.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 05:54:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     I am confuse that could we move the logic of finish_op into
_do_op in filestore. If I do not missread, the different between them
is the finish_op is protected by the threadpool lock. But I do not

know why it could be protected. Could you explain it?

    Thanks.--
Regards,
Xinze Chi
