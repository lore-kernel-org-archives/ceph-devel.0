From: John Spray <jspray@redhat.com>
Subject: Should pgls filters be part of object classes?
Date: Wed, 5 Aug 2015 14:00:58 +0100
Message-ID: <CALe9h7ds-M+orF+ao70GqN+uFkwiONnbHjzWOXPpFS3crs+YBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36299 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbHENBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 09:01:18 -0400
Received: by pacrr5 with SMTP id rr5so857346pac.3
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 06:01:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

So, I've got this very-cephfs-specific piece of pgls filtering code in
ReplicatedPG:
https://github.com/ceph/ceph/commit/907a3c5a2ba8e3edda18d7edf89ccae7b9d91dc5

I'm not sure I'm sufficiently motivated to create some whole new
plugin framework for these, but what about piggy-backing on object
classes?  I guess it would be an additional
cls_register_filter("myfilter", my_callback_constructor) fn.

tl;dr; How do people feel about extending object classes to include
providing PGLS filters as well?

John
