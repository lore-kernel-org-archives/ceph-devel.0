From: Loic Dachary <loic@dachary.org>
Subject: Standalone libcrush: call for participation
Date: Sat, 21 Jan 2017 00:16:26 +0100
Message-ID: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42182 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdATXQc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2017 18:16:32 -0500
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 24B5BC5A55
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2017 00:16:30 +0100 (CET)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter16-d.gandi.net (mfilter16-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id LY06SnR5G5eR for <ceph-devel@vger.kernel.org>;
        Sat, 21 Jan 2017 00:16:26 +0100 (CET)
Received: from [192.168.3.6] (x55b59f12.dyn.telefonica.de [85.181.159.18])
        (Authenticated sender: loic@dachary.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C6149C5A51
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2017 00:16:26 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ceph,

The idea of packaging CRUSH [1] as a standalone library that can be used by Ceph and other projects is not new. 

From the beginning Sage expected/hoped that the algorithm would be useful for lots of different applications. Other storage systems, load balancers, CDNs, or any other distributed thing where a compact description of how to map a large number of things to other things would be useful.  This has partly been proven out in that some storage systems "use CRUSH," but they use it in the sense that they reimplemented something based on the underlying algorithm.

It's also a place where we haven't seen a need to do anything ceph-specific; the problems we've fixed and changes we've made are general issues with the original algorithm and implementation.  The main barrier has been that the code and tools are built using a lot of the generic ceph infrastructure like encode/decode/bufferlists.

The beginning of the next ceph release cycle seems like a good time to initiate that effort. If someone is willing to help with the bootstrap, now is a good time. The library will be hosted under the libcrush.org domain name. But that's about the only thing that happened so far :-)

Cheers

[1] https://github.com/ceph/ceph/tree/master/src/crush

-- 
Loïc Dachary, Artisan Logiciel Libre
