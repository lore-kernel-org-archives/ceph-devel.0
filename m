From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 0/2] libceph: more miscellaneous cleanups
Date: Tue, 28 Feb 2012 20:55:37 -0800
Message-ID: <4F4DAFC9.7020309@dreamhost.com>
References: <4F4DAF00.5020908@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59893 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2B2Ezi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:55:38 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id EBFBB24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:37 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E1407242C3
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:37 -0800 (PST)
In-Reply-To: <4F4DAF00.5020908@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 02/28/2012 08:52 PM, Alex Elder wrote:
> Messaging code again. The biggest improvement here is encapsulating
> the code that puts data into the write vectors. The second patch just
> adds more simple cleanups.

What I meant to say was...

These are two simple patches, the first is just a simple logic change
whose result I thought was slightly more readable.

					-Alex

