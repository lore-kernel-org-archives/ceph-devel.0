From: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Subject: Developing osd plugins
Date: Mon, 2 Sep 2013 20:32:24 +0300
Message-ID: <CA+CdmLZ1HKHWAw4+AG15Ud1yAEBF+DvUaP+6KwCexpXx8yBWJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:40503 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab3IBRcZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Sep 2013 13:32:25 -0400
Received: by mail-ve0-f169.google.com with SMTP id db10so3425899veb.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Sep 2013 10:32:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all

I've been playing with osd plugins and I can't figure out how to load one.
There is a loadclass.sh script but it seems quite outdated.
I tried to copy .so to /usr/lib/rados-classes on all nodes and restart
ceph cluster, but it didn't help, rados_exec returns -95, I haven't
yet found the constant for the value.

Thanks for any help!
