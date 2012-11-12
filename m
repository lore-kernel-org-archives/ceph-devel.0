From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [BUG] ceph-mon crashes
Date: Mon, 12 Nov 2012 16:10:02 +0100
Message-ID: <50A1114A.5070200@profihost.ag>
References: <50A01DCB.9010001@profihost.ag> <50A024B2.3080502@inktank.com> <50A02542.1000602@profihost.ag> <50A03412.1030206@inktank.com> <21B8A3CE-BC02-44AF-ABB5-45C9C74F9380@profihost.ag> <50A10EB1.4040802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40180 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2KLPKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 10:10:05 -0500
In-Reply-To: <50A10EB1.4040802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 12.11.2012 15:58, schrieb Joao Eduardo Luis:
> Hi Stefan,
>
>
> Any chance you can get me a larger chunk of the log from the monitor
> that was the leader by the time you issued those commands until the
> point the monitor crashed (from the excerpt you provided, that should be
> mon.b)?

Sure:
https://www.dropbox.com/s/8e604bihk56m0yd/ceph-mon.b.log.1.gz

Greets,
Stefan
