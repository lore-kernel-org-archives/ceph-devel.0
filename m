From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 08 Jan 2013 13:57:10 +0100
Message-ID: <50EC17A6.1080707@ledeuns.net>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com> <50EBDC5E.3090207@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:48817 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab3AHM5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 07:57:09 -0500
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 0099A93271
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 13:57:05 +0100 (CET)
In-Reply-To: <50EBDC5E.3090207@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I'm wondering if I can get every "rb.0.8e10.3e2219d7.*" from the OSD 
drive and cat them together and get back a usable raw volume from which 
I could get back my data ?

Everything seems to be there but I don't know the order of the rbd 
objects. Are the last bytes of the file name the offset of the block ?

Regards,
Denis
