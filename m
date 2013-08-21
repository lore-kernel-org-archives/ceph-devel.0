From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: subdir-objects
Date: Wed, 21 Aug 2013 13:01:16 -0700
Message-ID: <CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:34653 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3HUUBR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 16:01:17 -0400
Received: by mail-ve0-f175.google.com with SMTP id oy10so777416veb.34
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 13:01:16 -0700 (PDT)
In-Reply-To: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 21, 2013 at 12:45 PM, Roald van Loon <roaldvanloon@gmail.com> wrote:
>
> from auto-registering the plugins in the RGW core. The only fix for
> this is making the RGW core aware of the subdirs/plugins, but I think
> that's nasty design. I'd like to have it in my make conf.

This patch will turn on the option (which should also fix your problem
if I understand correctly?), and should probably be committed anyway
as newer versions of autotools will complain loudly about our current
Makefile structure.

diff --git a/src/Makefile.am b/src/Makefile.am
index 93f3331..fb7c9dd 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,4 +1,4 @@
-AUTOMAKE_OPTIONS = gnu
+AUTOMAKE_OPTIONS = gnu subdir-objects
 SUBDIRS = ocf java
 DIST_SUBDIRS = gtest ocf libs3 java

> So, the question is; is there a reason why we don't use subdir objects?

I believe it is just historical, and unfortunately has just been
repeated over and over. Ideally I think that there should be a
restructuring to place a Makefile.am in every subdirectory. This would
address your issue and make it significantly easier to deal with
situations where we want to build a subset of Ceph, such as just FUSE
and librados, for example.
