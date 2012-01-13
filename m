From: huang jun <hjwsm1989@gmail.com>
Subject: subuser of radosgw
Date: Fri, 13 Jan 2012 08:27:36 +0800
Message-ID: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37744 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab2AMA1g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 19:27:36 -0500
Received: by iabz25 with SMTP id z25so3475123iab.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 16:27:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
   when i use radosgw+s3, there are two werid things:
   1)  we can use the command "raodsgw_admin subuser create  --subuser
="a1"  -i 8" to create a subuser named "a1" under a user whoes user_id
is 8.
        and also can create many subusers under one single user.
   can we give the specified subuser  permission to visit a specified bucket?
   so what do subusers do here?
   2) we can create many access-key and secret-keys for an user, do we
need so many keys?

-- 
thanks!
huangjun
