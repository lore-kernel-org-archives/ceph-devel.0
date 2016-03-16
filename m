From: Willem Jan Withagen <wjw@digiware.nl>
Subject: LDAP usuage
Date: Wed, 16 Mar 2016 13:38:29 +0100
Message-ID: <56E953C5.5020900@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:39686 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbcCPMt0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Mar 2016 08:49:26 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 213831534CE
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 13:49:23 +0100 (CET)
Received: from [192.168.101.107] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 8BDFE1534CD
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 13:38:30 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

After rebasing I find that radosrgw, amonst others, is now dependant on
LDAP.

Now LDAP has been something I've tried to avoid for as long as it
exists. And uptill now I've done oke....

So is there any chance of excluding this from the building process?
Otherwise I'll add openldap to the dependancies and get on with trying
to port. But I'd prefer to do so without LDAP.

Would that be possible....

--WjW
