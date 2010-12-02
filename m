From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: questions about pg membership
Date: Thu, 2 Dec 2010 23:28:59 +0800
Message-ID: <AANLkTin8d5xMoqvjt8YcS6NrCTEB=-L2Tyx4_96TckZd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50005 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab0LBP27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 10:28:59 -0500
Received: by qwb7 with SMTP id 7so8489900qwb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Dec 2010 07:28:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

I have some questions about the pg membership.

Suppose I have a ceph cluster of 3 osds (osd0, osd1, osd2) and the
replication number is 2. I observed that if osd2 failed and became
down and out, one pg's acting osds would changed from [0,2] to [1,0].

Does it mean that the primary of the pg changed from osd0 to osd1? If
the client wants to access the object in the pg at that time, would
the client's request be blocked until osd1 has acquired the missing
object from osd0?

If so, is there any way (e.g. a crush rule?) to choose osd0 as the new
primary since it was the replica and had the object already? Then, it
should be able to shorten the time the client has to wait.

Thanks,
Henry
