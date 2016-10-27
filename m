From: Rui Xie <jerry.xr86@gmail.com>
Subject: ceph -s report all mons down
Date: Thu, 27 Oct 2016 09:56:32 +0800
Message-ID: <CAKE=UQLCJoJXzhVdtp24wQzb2AKDzMywUqG_R-cvC+0WNOi1xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35576 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbcJ0B4d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 21:56:33 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so26757301qkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 18:56:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi:
      Sometimes when i use ceph -s to query cluster status, it shows
all mons down (Hammer), but in fact monitor is not really down. from
the code it seems ceph -s not wait elect finish, so maybe quorum is
empty at that time?
