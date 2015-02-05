From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: How to notify an object watched by client via ceph class API
Date: Thu, 5 Feb 2015 16:09:35 +0800
Message-ID: <CA+U0gVi=kLnWGbb_Ea=xNGLaRdoxhxGW0HPFT9HUACnHZBM_wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59784 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbbBEIJ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 03:09:56 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so8575727pab.0
        for <ceph-devel@vger.kernel.org>; Thu, 05 Feb 2015 00:09:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hello,

Just as the subject indicated, how can I notify an object watcher
within a class '.so' loaded into osd deamon. I checked the code and
found the below op code defined already:CEPH_OSD_OP_NOTIFY, but this
op code is not used by existing ceph class api, I guest there must be
a simple solution to resolve this if I don't want to make the osd to
play client role the same time.

Anyone can help me out this?

-- 
Den
