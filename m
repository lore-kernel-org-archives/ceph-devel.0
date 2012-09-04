From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Inject configuration change into cluster
Date: Tue, 04 Sep 2012 10:17:44 +0200
Message-ID: <5045B928.1050706@widodh.nl>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50706 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab2IDIRq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 04:17:46 -0400
In-Reply-To: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U2tvd3JvbiBTxYJhd29taXI=?= <slawomir.skowron@grupaonet.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/04/2012 07:04 AM, Skowron S=C5=82awomir wrote:
> Is there any way now, to inject new configuration change, without res=
tarting daemons ??
>

Yes, you can use the injectargs command.

$ ceph osd tell 0 injectargs '--debug-osd 20'

What do you want to change? Not everything can be changed while the OSD=
=20
is running.

Wido

> Regards
>
> Slawomir Skowron--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
