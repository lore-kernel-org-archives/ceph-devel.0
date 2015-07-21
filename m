From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: upstream/firefly exporting the same snap 2 times results in different
 exports
Date: Tue, 21 Jul 2015 18:55:43 +0200
Message-ID: <55AE798F.1010206@profihost.ag>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:59311 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbbGUQzq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:55:46 -0400
In-Reply-To: <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org


Am 21.07.2015 um 16:32 schrieb Jason Dillaman:
> Any chance that the snapshot was just created prior to the first export and you have a process actively writing to the image?
>

Sadly not. I executed those commands exactly as i've posted manually at 
bash.

I can reproduce this at 5 different ceph cluster and 500 vms each.

Stefan
