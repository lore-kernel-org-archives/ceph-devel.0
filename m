From: Yehuda Sadeh <yehuda@inktank.com>
Subject: blueprint: rgw multi-region disaster recovery, second phase
Date: Mon, 29 Jul 2013 15:24:31 -0700
Message-ID: <CABBk=J9vDbYisdHk5nzw_FnCDeFPpkzQhh74n-nte9TvPkjodA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:64521 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3G2WYc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 18:24:32 -0400
Received: by mail-vb0-f43.google.com with SMTP id h11so2382612vbh.16
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 15:24:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've created a blueprint for the second phase of the multiregion / DR project:

http://wiki.ceph.com/index.php?title=01Planning/02Blueprints/Emperor/RGW_Multi-region_%2F%2F_Disaster_Recovery_(phase_2)

While a huge amount of work was done for Dumpling, there's still some
work that needs to be done (mainly in the area of the disaster
recovery). If you're interested in discussing this at CDS, please add
yourself as an interested party to the blueprint.


Yehuda
