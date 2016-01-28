From: Wido den Hollander <wido@42on.com>
Subject: Re: how to debug librados/librbd in logfile
Date: Thu, 28 Jan 2016 15:41:18 +0100
Message-ID: <56AA288E.1010205@42on.com>
References: <CABAwU-YLhiSdD8cbZWHC=8cBeNi_UM2rp3XpJefwWsiszwv6ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:60814 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcA1OlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 09:41:12 -0500
In-Reply-To: <CABAwU-YLhiSdD8cbZWHC=8cBeNi_UM2rp3XpJefwWsiszwv6ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 28-01-16 15:33, huang jun wrote:
> hi,all
> I want to get debug log when using librados/librbd,
> set client section in ceph.conf:
> [client]
> debug_rbd = 20
> debug_objecter = 20
> log_file = /var/log/ceph/ceph.rbd.log
> 
> that not work, file "/var/log/ceph/ceph.rbd.log" does not exist at all.
> Any ideas?
> 

Does the user under which you run the client have access to /var/log/ceph?

You might want to try /tmp for a test.

Wido
