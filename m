From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RGW: Pools .rgw .rgw.control .users.uid .users.email .users
Date: Fri, 2 Nov 2012 16:20:48 +0100
Message-ID: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54324 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab2KBPUt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 11:20:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3703229obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 08:20:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've just started RGW and it created some pools automatically :
.rgw .rgw.control .users.uid .users.email .users

But when looking at them, they used PG_NUM=8 which is a bit low.
Now, I noticed it and created .rgw.buckets myself with an appropriate
PG_NUM, I assume it will work or is there some special setup done by
rgw beside just creating the pool ?

Also, I assume those pools will actually be pretty small and so I can
just leave them with PG_NUM=8 without much issue ?

Cheers,

    Sylvain
