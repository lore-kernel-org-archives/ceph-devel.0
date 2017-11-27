From: Wido den Hollander <wido@42on.com>
Subject: Blocked / Slow requests in health JSON from Mon/Mgr
Date: Mon, 27 Nov 2017 11:29:21 +0100 (CET)
Message-ID: <666139692.5433.1511778561280@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se01-out.mail.pcextreme.nl ([185.66.251.200]:60831 "EHLO
        se01-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751332AbdK0K35 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Nov 2017 05:29:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

For the Zabbix plugin for the Mgr I wanted to report the amount of block and/or slow requests the cluster is experiencing.

There is no item with a int value in the JSON returned by the Monitors.

What would be the easiest way to obtain these values in a Mgr Module?

Or would we need to expand the JSON the MON reports?

I'd like to make a trigger in Zabbix that if num slow requests is > X a admin is alerted.

Right now you would have to parse a string which isn't very stable.

Any ideas?

Wido
