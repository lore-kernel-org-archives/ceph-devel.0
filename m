From: Rui Xie <jerry.xr86@gmail.com>
Subject: unfound object problem
Date: Mon, 30 May 2016 11:58:12 +0800
Message-ID: <CAKE=UQJxaZPms82=qZeceSCW2+okmSPVGJ12ML0gd2JPW2uEEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33688 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbcE3D6O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 May 2016 23:58:14 -0400
Received: by mail-qg0-f48.google.com with SMTP id 52so8379599qgy.0
        for <ceph-devel@vger.kernel.org>; Sun, 29 May 2016 20:58:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

I found an unfound object problem in my test environment (hammer).
I suspect the reason is the wrong update of up_thru.

from osdmap, the up_thru become smaller than before at an epoch.  some
old PGTemp messages with smaller epoch are prepared and executed, and
change the up_thru to smaller epoch.
maybe_went_rw is wrong for that interval.

I think prepare_pgtemp should not change up_thru if it is smaller than
current, and duplicated PGTemp messages not be sent ?

Is this a bug or something wrong for me?

Thanks !
