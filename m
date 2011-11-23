From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Why Ceph's aggregate write throughput does not scale with the number
 of osd nodes
Date: Wed, 23 Nov 2011 10:38:18 -0800
Message-ID: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42776 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab1KWSit convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 13:38:49 -0500
Received: by yenq3 with SMTP id q3so1717781yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 10:38:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I searched online. saw=A0Bug #538 and=A0Tasks #584=A0may related to my
problem. What's the status of this problem? I first used version 0.34.
Then I tried a newer version which is 0.37. But the problem still
exists. Is there anyone who knows this problem and how to solve this?
Thanks a lot. and Happy Thanksgiving

--
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
