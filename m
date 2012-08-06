From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Crash of almost full ceph
Date: Tue, 07 Aug 2012 02:09:14 +0930
Message-ID: <501FF332.3060005@bashkirtsev.com>
References: <501CFB7C.1040601@bashkirtsev.com> <CAPYLRzgTCu-_mvKBQNaHrmXqmBVib0cvcGKPmaL-yWGZ=uioww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:57848 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab2HFQje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 12:39:34 -0400
In-Reply-To: <CAPYLRzgTCu-_mvKBQNaHrmXqmBVib0cvcGKPmaL-yWGZ=uioww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 07/08/12 01:55, Gregory Farnum wrote:
> There is not yet any such feature, no =97 dealing with full systems i=
s=20
> notoriously hard and we haven't come up with a great solution yet. On=
e=20
> thing you can do is experiment with the "mon_osd_min_in_ratio"=20
> parameter, which prevents the monitors from marking out more than a=20
> certain percentage of the OSD cluster (and without something being=20
> marked out, no data will be moved around). If you don't want the=20
> cluster to automatically mark any OSDs out, you can also set the=20
> "mon_osd_down_out_interval" to zero. -Greg=20
But it is good idea to have such feature as fail safe device. Settings=20
you speak about may help a bit when cluster is almost full and there=20
good number of OSDs but hard refusal of ceph to run recovery if ANY liv=
e=20
OSD is over certain limit is quite unambiguous. If recovery fails due t=
o=20
one OSD is at capacity then it should be handed over to admin to decide=
=20
what to do: rebalance CRUSH, add new OSD, remove some objects. Certainl=
y=20
ceph should not be able to fill up OSD with activity which is not=20
required (but desired) by end clients.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
