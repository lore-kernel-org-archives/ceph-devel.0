From: David Casier AEVOO <david.casier@aevoo.fr>
Subject: [Documentation] Hardware recommandation : RAM and PGLog
Date: Sun, 19 Jul 2015 18:07:37 +0200
Message-ID: <55ABCB49.1080304@aevoo.fr>
References: <55ABC8E5.1030304@aevoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:41925 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbbGSQId (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 19 Jul 2015 12:08:33 -0400
Received: from [192.168.1.97] (84.197.151.77.rev.sfr.net [77.151.197.84])
	by aevoo.fr (Postfix) with ESMTPSA id 0DD75401EC
	for <ceph-devel@vger.kernel.org>; Sun, 19 Jul 2015 18:08:32 +0200 (CEST)
In-Reply-To: <55ABC8E5.1030304@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I have a question about PGLog and RAM consumption.

In the documentation, we read "OSDs do not require as much RAM for 
regular operations (e.g., 500MB of RAM per daemon instance); however, 
during recovery they need significantly more RAM (e.g., ~1GB per 1TB of 
storage per daemon)"

But in fact, all pg log are read in the start of ceph-osd daemon and put 
in RAM ( pg->read_state(store, bl); )

Is this normal behavior or I have a defect in my environment?

Cordialement,
David Casier.
