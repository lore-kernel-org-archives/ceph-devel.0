From: Wido den Hollander <wido@42on.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 14:46:44 +0200
Message-ID: <5187A634.7010804@42on.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51176 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab3EFMqq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 08:46:46 -0400
In-Reply-To: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2013 11:18 AM, Andreas Friedrich wrote:
> Hello,
>
> we are using Infiniband instead of Ethernet for cluster interconnection.
> Instead of IPoIB (IP-over-InfiniBand Protocol) we want to use SDP
> (Sockets Direct Protocol) as a mid layer protocol.
>
> To connect the Ceph daemons to SDP without changing the Ceph code, the
> LD_PRELOAD mechanism can be used.
>
> To enable the LD_PRELOAD mechanism for the Ceph daemons only, a little
> generic extension in the global section of /etc/ceph/ceph.conf would
> be helpful, e.g.:
>
> [global]
> 	environment = LD_PRELOAD=/usr/lib64/libsdp.so.1
>
> The appending patch adds 5 lines in the Bobtail (0.56.6) init script.
> The init script will then read the environment setting and - if present -
> call the Ceph daemons with the preceding environment string.
>

You can also submit this via a Pull request on Github. That way the 
author stays preserved and you get all the credits for this patch :)

> With best regards
> Andreas Friedrich
> ----------------------------------------------------------------------
> FUJITSU
> Fujitsu Technology Solutions GmbH
> Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany
> Tel: +49 (5251) 525-1512
> Fax: +49 (5251) 525-321512
> Email: andreas.friedrich@ts.fujitsu.com
> Web: ts.fujitsu.com
> Company details: de.ts.fujitsu.com/imprint
> ----------------------------------------------------------------------
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
