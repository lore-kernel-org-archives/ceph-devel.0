From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 08 Nov 2012 16:45:54 +0100
Message-ID: <509BD3B2.1040001@profihost.ag>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <509BC95F.5090904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54217 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2KHPqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:46:03 -0500
In-Reply-To: <509BC95F.5090904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 16:01, schrieb Mark Nelson:
> Hi Stefan,
>
> You might want to try running sysprof or perf while the OSDs are running
> during the tests and see where CPU time is being spent.  Also, how are
> you determining how much CPU usage is being used?

Hi Mark,

have a 300MB perf.data file and no idea what todo next ;-)

Stefan
