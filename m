From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 0/2] Add resource agents to debian build, trivial C&P error
Date: Thu,  5 Jan 2012 22:33:30 +0100
Message-ID: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44884 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab2AEVds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 16:33:48 -0500
Received: by eekc4 with SMTP id c4so668754eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 13:33:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

please consider two follow-up patches to the OCF resource agents: the
first adds them to the Debian build, as a separate package
"ceph-resource-agents" that depends on resource-agents, the second
fixes a trivial (and embarassing, however harmless) cut and paste
error. Thanks!

Cheers,
Florian

