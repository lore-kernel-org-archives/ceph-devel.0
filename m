From: Shayan Saeed <shayansaeed93@gmail.com>
Subject: Disabling CRUSH for erasure code and doing custom placement
Date: Tue, 24 Jun 2014 11:29:50 -0400
Message-ID: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37347 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbaFXP3v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 11:29:51 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so385490pbb.18
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jun 2014 08:29:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

CRUSH placement algorithm works really nice with replication. However,
with erasure code, my cluster has some issues which require making
changes that I cannot specify with CRUSH maps.
Sometimes, depending on the type of data, I would like to place them
on different OSDs but in the same pool.

I realize that to disable the CRUSH placement algorithm and replacing
it with my own custom algorithm, such as random placement algo or any
other, I have to make changes in the source code. I want to ask if
there is an easy way to do this without going into every code file and
looking where the mapping from objects to PG is done and changing
that. Is there some configuration option which disables crush and
points to my own placement algo file for doing custom placement.

Let me know about the most neat way to go about it. Appreciate any
help I can get.

Regards,
Shayan Saeed
Research Assistant, Systems Research Lab
University of Illinois Urbana-Champaign
