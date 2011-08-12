From: Sylar Shen <kimulaaa@gmail.com>
Subject: remove user function of radosgw
Date: Fri, 12 Aug 2011 23:14:43 +0800
Message-ID: <CAPE_nyKvv5SG1wE0iVT0crTMpUHr6RfwWxBnhQuwKN-XqbGkeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53843 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1HLPOo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 11:14:44 -0400
Received: by bke11 with SMTP id 11so1720359bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 08:14:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,
I am using radosgw right now.
It worked great but there is a strange thing - I cannot remove a radosgw user.
I've read the usage information of "radosgw_admin" and knew that it
has "user rm" command.
So my command was "radosgw_admin user rm --uid=test" but the test
account wasn't deleted.
I am wondering if my command was wrong or something.
Thanks~~~~^^
--
Best Regards,
Sylar Shen
