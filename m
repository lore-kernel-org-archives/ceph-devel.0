From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: ec pool history objects
Date: Mon, 15 Jun 2015 18:06:40 +0800
Message-ID: <CANE=7sWOYZ2KJn=LMUYTtUxAAQb_Ky18qYeCG5wOU2uJwZz1oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35336 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbbFOKGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 06:06:40 -0400
Received: by obbgp2 with SMTP id gp2so60460641obb.2
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 03:06:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

    when I use ec poll, I see there are some object history for object xxxxxx.

    Such as: xxxxxx__head_610951D6__2_fe1_2,
xxxxxx__head_610951D6__2_fe2_2
xxxxxx__head_610951D6__2_ffffffffffffffff_2

    I think this object is used for roll_back when not all shards have
written object to filestore. Is it right?

    If that, why not delete this history objects when all shards has
written object to filestore?

-- 
Regards,
xinze
