From: Andrey Korolyov <andrey@xdel.ru>
Subject: page allocation failures on osd nodes
Date: Fri, 25 Jan 2013 01:42:39 +0300
Message-ID: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52135 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab3AXWuN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 17:50:13 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so4126883lbb.40
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 14:50:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Those traces happens only constant high constant writes and seems to
be very rarely. OSD processes do not consume more memory after this
event and peaks are not distinguishable by monitoring. I have able to
catch it having four-hour constant writes on the cluster.

http://xdel.ru/downloads/ceph-log/allocation-failure/
