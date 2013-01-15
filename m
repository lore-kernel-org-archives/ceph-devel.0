From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Rack Awareness
Date: Tue, 15 Jan 2013 11:17:48 +0100
Message-ID: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54500 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534Ab3AOKRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:17:50 -0500
Received: by mail-wg0-f51.google.com with SMTP id gg4so2591970wgb.6
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 02:17:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
is ceph able to distribute datas across multiple racks like MooseFS
does with Rack Awareness features?

For example, let's imagine a ceph cluster made with multiple OSDs
distributed in multiple server on multiple racks.
Is possible to tell ceph to distribute replicas across multiple racks
avoiding to have 3 copies of the same chunk on a single rack?

For example:

rack1.server1.osd1
rack2.server5.osd9
rack3.server9.osd11
