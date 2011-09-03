From: huang jun <hjwsm1989@gmail.com>
Subject: the messenger to send osd write ack|ondisk
Date: Sat, 3 Sep 2011 10:28:57 +0800
Message-ID: <CABAwU-aCazA1vtpokbntNd054mL12gp5Cc3+eJ9C_6UkNp_Now@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40891 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab1ICC25 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2011 22:28:57 -0400
Received: by vws1 with SMTP id 1so2690888vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2011 19:28:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
i'm confused by the question:
ceph use client_messenger to send MOSDOpReply:ondisk
but use cluster_messenger to send MOSDOpReply:ack
are they have any difference?
