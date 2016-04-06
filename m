From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: Permissions for /run/ceph
Date: Wed, 6 Apr 2016 16:01:33 +0200
Message-ID: <CADr68WZ+A7YLb1OF7RdijqKMyD9em1jCuprgqXWAFB0810Go+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34683 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcDFOBg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 10:01:36 -0400
Received: by mail-lb0-f178.google.com with SMTP id vo2so30517302lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 Apr 2016 07:01:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

in https://github.com/ceph/ceph/commit/3aa38bc07f84f452d70757585ef2620ee60ee227
you changed the permissions from 0755 to 0770. The description of the
commit only talks about making the directory group-writable, so I'm
failing to see why this should not be world-readable anymore.

In particular this breaks our monitoring, which tries to check things
with a different user. That used to work earlier, because the sockets
themselves are still 0755.

Was this just an oversight and you really meant to change it to 0775?
Or is there some other argument that I am not seeing yet?

Yours,
Jens
