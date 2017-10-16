From: Wido den Hollander <wido@42on.com>
Subject: Luminous: osd_crush_location_hook renamed to crush_location_hook
Date: Mon, 16 Oct 2017 14:02:53 +0200 (CEST)
Message-ID: <1406455169.3092.1508155374117@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se01-out.mail.pcextreme.nl ([185.66.251.200]:37521 "EHLO
        se01-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752347AbdJPPCy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 16 Oct 2017 11:02:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

Hi,

I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.

When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.

Was this an oversight with Luminous or was it intentional?

Wido
