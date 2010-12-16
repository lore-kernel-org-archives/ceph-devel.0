From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: stripping of ceph class objects
Date: Thu, 16 Dec 2010 15:35:06 -0800
Message-ID: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42751 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0LPXfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 18:35:08 -0500
Received: by wwa36 with SMTP id 36so109188wwa.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Dec 2010 15:35:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Hi Laszlo,

 we just installed the latest ceph debian packages and it seems that
the class objects (that are installed in /usr/lib/rados-classes/) are
stripped. We need to keep a few symbols visible on those shared
objects, namely, all the symbols that start with '__cls_'. Our regular
automake resulted binaries keeps those symbols, but I guess that the
debian packaging strips them.
These symbols have the class name and version in them, which helps us
in cases where the ceph installation is running on a cluster that
consists of multiple architectures. A script running on the monitor
thus should be able to identify the class name and version no matter
what its architecture is.

Thanks,
Yehuda
