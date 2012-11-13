From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: OSD network failure
Date: Tue, 13 Nov 2012 15:15:55 +0100
Message-ID: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:33631 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab2KMOP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 09:15:56 -0500
Received: by mail-ea0-f174.google.com with SMTP id o11so698035eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 06:15:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
what happens in case of OSD network failure? Is ceph smart enough to
isolate OSDs not synced?
Should I use LACP in ODS network or a single 10GBe per server should be ok?

LACP will need stackable switches and much more hardware investment.
