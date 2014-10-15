From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting
Date: Wed, 15 Oct 2014 08:22:11 +0200 (CEST)
Message-ID: <e1f8eda8-3711-4f50-8910-20a09daa472f@mailpro>
References: <543DECC6.9030607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45022 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaJOGWS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 02:22:18 -0400
In-Reply-To: <543DECC6.9030607@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

about performance, maybe could it be great to also include client side performance ?

Currently I see 2 performance problems with librbd:

1) The cpu usage is quite huge. (I'm cpu bound with 8cores CPU E5-2603 v2 @ 1.80GHz, with 40000iops 4k read using fio-rbd)

2) in qemu, it's impossible to reach more than around 7000iops with 1 disk. (maybe is it also related to cpu or threads number).
   I have also try with the new qemu iothread/dataplane feature, but it doesn't help.





