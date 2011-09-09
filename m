From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Debs must not contain /var/run
Date: Fri, 9 Sep 2011 09:04:40 -0700
Message-ID: <CAORUGqDWnPYmDpXqjpMitdDV7bAKnrHKFFu2zqzD4cT-X90UmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab1IIQFB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 12:05:01 -0400
Received: by wwf5 with SMTP id 5so1334162wwf.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2011 09:05:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi. Commit a73d5 is bad. Debs must not contain /var/run; the FHS
defines /var/run as being emptied at boot, so there is no permanent
storage there. Any subdirectories you need there must be re-created by
the init scripts.

http://ceph.newdream.net/gitbuilder-deb-amd64/log.cgi?log=a73d53fdcb2a0734812bc3159e929dde7ae9089f
