From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 21:44:44 +0100
Message-ID: <CAJH6TXgCSh3zzm053YcVrf3u8kRpAaMpBTj_Rscrhx57Mg7F6A@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
	<87FF75E30B3F4DCABD5DCE389CCE5A0A@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44326 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab3AVUoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 15:44:46 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so198414wgb.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 12:44:44 -0800 (PST)
In-Reply-To: <87FF75E30B3F4DCABD5DCE389CCE5A0A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/22 Gregory Farnum <greg@inktank.com>:
> If you're using mkcephfs to set it up, or asking etc/init.d/ceph to start up daemons on each node, it uses ssh to go in and do that. I believe the Quick-start guide is using both of those. :)

I'm using mkcephfs but actually I have just one host, mkcephfs is
trying to connect to itself via scp.

I think that an additional check should be made: if the host is the
same as "hostname -f" a standard cp should be used in place of scp
