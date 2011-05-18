From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: librados dependency
Date: Wed, 18 May 2011 05:28:12 -0700
Message-ID: <BANLkTin4zPSHQ7afkXRStuDJWbzZUCe9ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52256 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932939Ab1ERM2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 08:28:13 -0400
Received: by bwz15 with SMTP id 15so1369565bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2011 05:28:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

The ceph master branch was broken today, as librados was using some
undefined symbols (that are defined in libcrush). At the moment I
worked around the issue by adding libcrush to the linkage where
appropriate, however, we should definitely want to remove this
dependency.

Yehuda
