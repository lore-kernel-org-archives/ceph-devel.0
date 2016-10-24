From: Loic Dachary <loic@dachary.org>
Subject: jewel 10.2.4 freeze
Date: Mon, 24 Oct 2016 16:36:03 +0200
Message-ID: <580E1C53.6060503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34827 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757454AbcJXOgH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 10:36:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi Abhishek,

If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do you think it we should stop merging new backports and prepare for the release ? If so, I'll ask the lead of each component to make sure nothing is missing from their point of view.

You can find the progress of the jewel 10.2.4 release in the ttp://tracker.ceph.com/issues/17487.

Cheers

[0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.com/versions/524

-- 
Loïc Dachary, Artisan Logiciel Libre

