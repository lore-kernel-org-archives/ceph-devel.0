From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: massive rbd speed decrease with latest git master
Date: Mon, 05 Nov 2012 11:48:23 +0100
Message-ID: <50979977.2090006@profihost.ag>
References: <50979779.3040300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54643 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab2KEKs0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 05:48:26 -0500
In-Reply-To: <50979779.3040300@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: alexandre DERUMIER <aderumier@odiso.com>

Am 05.11.2012 11:39, schrieb Stefan Priebe - Profihost AG:
> Hello list,
>
> while updating ceph to the latest master i noticed this:
>
> Commit a01b112d71a0b6a1bb206d53867d13536d17bbf6:
> rand. 4k WRITE: 3000 iop/s
>
> Commit 72a710ac47355ae3ca1d055be1496c91956d549d:
> rand. 4k WRITE: 900 iop/s
>
> Same for rand 4k read - haven't tested sequential stuff.

Now i'm strangely seeing this slow performance with old commit too. 
Pretty strange. So please ignore my mail until i made further tests.

Stefan
