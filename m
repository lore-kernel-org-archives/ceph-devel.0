From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 14:12:00 +0100
Message-ID: <50AF7620.6060505@profihost.ag>
References: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39181 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2KWNMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 08:12:12 -0500
In-Reply-To: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Am 23.11.2012 12:03, schrieb Alexandre DERUMIER:
> so correcly aligned...
>
> Maybe try to use journal directly on the full partition, without xfs ?

The same - just 200 iops for rand 4k.

Stefan
