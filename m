From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: 0.56.6: MDS asserts on restart
Date: Mon, 13 May 2013 16:10:19 +0200
Message-ID: <5190F44B.6040308@de-punkt.de>
References: <518CF45B.7010402@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:33976 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3EMOKU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 10:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail-1.de-punkt.de (Postfix) with ESMTP id 752CD3A3AA
	for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 16:10:18 +0200 (CEST)
Received: from mail-1.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFr0bh1u8yc1 for <ceph-devel@vger.kernel.org>;
	Mon, 13 May 2013 16:10:18 +0200 (CEST)
Received: from Christophers-MacBook-Pro.local (p4FECE4C3.dip0.t-ipconnect.de [79.236.228.195])
	(Authenticated sender: chrislist@de-punkt.de)
	by mail-1.de-punkt.de (Postfix) with ESMTPSA id 47EE53A393
	for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 16:10:18 +0200 (CEST)
In-Reply-To: <518CF45B.7010402@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am 10.05.13 15:21, schrieb Christopher Kunz:
> Hi all,
> 
> after our update to 0.56.6, all MDSes assert and crash on start. This is
> not essential for our setup, but still not great. We assume this might
> be due to a bug - see the nopaste below for a trace.
> 
For reference: I created <http://tracker.ceph.com/issues/5037> for this
issue.

Regards,

--ck

