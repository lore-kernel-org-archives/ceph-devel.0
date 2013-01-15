From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Rack Awareness
Date: Tue, 15 Jan 2013 12:14:46 +0100
Message-ID: <CAJH6TXiFVGHe+xDSAsV9iR=2Sy1SNo9v9WPsDvL-T10wZ-FDhg@mail.gmail.com>
References: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com>
	<50F52E4C.4000704@widodh.nl>
	<CAJH6TXj96-OSbR+8MrS7o4bjzcC-zj=2z88sE=6TWzvadHNTTg@mail.gmail.com>
	<50F5369B.10601@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:42722 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3AOLOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 06:14:47 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so2172521wib.10
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 03:14:46 -0800 (PST)
In-Reply-To: <50F5369B.10601@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2013/1/15 Wido den Hollander <wido@widodh.nl>:
> You should know that you can never set replication higher then 2 with this
> setting since it always tries to pick a rack and you only have two.

Good to know, but is not our case, we have 24 racks :)
That was just an example.
