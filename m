From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: python crush tools uses pre luminous health status
Date: Mon, 6 Nov 2017 09:46:12 +0100
Message-ID: <a738bbd8-e443-e3dc-9083-3774337c761a@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:28718 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751968AbdKFIqO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 03:46:14 -0500
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

while trying to use python crush tools on a luminous cluster i get:

crush.ceph.HealthError: expected health overall_status == HEALTH_OK but
got HEALTH_WARNinstead

It seems crush-1.0.35 uses the deprecated overall_status element.

Greets,
Stefan
