From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Multiple IPnr for OSDs in a multi-tenant environment
Date: Wed, 3 Feb 2016 13:21:07 +0100
Message-ID: <56B1F0B3.5050907@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:11718 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbcBCMVS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Feb 2016 07:21:18 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id BB40B1534EC
	for <ceph-devel@vger.kernel.org>; Wed,  3 Feb 2016 13:21:15 +0100 (CET)
Received: from [192.168.101.175] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 522CE1534E6
	for <ceph-devel@vger.kernel.org>; Wed,  3 Feb 2016 13:21:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I was discussing multi-tenant sollutions with our engineers.
And one of the requirements we have there is:
	- tenants should not see one-another in the network
	- Seperate VLAN to customer/tenant

Now perhaps the first one would be possible by stringently applying
firewalls. But that is not really the most performant way since
everything has to go thru a firewall at 10Gb.

The second one would be relatively easy dependant on the chosen
construction of the infra.

I've seen some discussion on having multiple addresses on OSDs, but as
far as I can see/remember, and this is limitted to max 2 ipnrs.

For performance reasons perhaps everything can go over the same network,
but for separation and security, it might be that more is needed.

Who have others solved this in a multi-tenant environment?

Thanx,
--WjW
