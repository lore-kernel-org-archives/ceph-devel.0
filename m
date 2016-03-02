From: John Spray <jspray@redhat.com>
Subject: cmake+cython
Date: Wed, 2 Mar 2016 12:41:40 +0000
Message-ID: <CALe9h7c8+feNZ1c_VF90u+fPKrXipgdScnXs2X=78YZ0qyPWRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34626 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbcCBMmB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 07:42:01 -0500
Received: by mail-lb0-f169.google.com with SMTP id of3so117108879lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 04:42:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <amaredia@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

For cmake users: I've created a working but rough change to enable
building the .pyx modules from cmake:
https://github.com/jcsp/ceph/commit/d2c4be85ccb53bac3835a3a3b84a3f4626016c93

This is just enough cmake to unblock me.

I imagine that currently a lot of cmake users are still surviving on
lingering .pyc files from before the cython change.

John
