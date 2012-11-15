From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: endless flying slow requests
Date: Thu, 15 Nov 2012 00:18:40 -0800
Message-ID: <50A4A560.3010406@inktank.com>
References: <50A3607A.6050209@profihost.ag> <alpine.DEB.2.00.1211140656590.6512@cobra.newdream.net> <50A4A351.8020506@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52631 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab2KOISr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 03:18:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so988485pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 00:18:47 -0800 (PST)
In-Reply-To: <50A4A351.8020506@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/15/2012 12:09 AM, Stefan Priebe - Profihost AG wrote:
> Am 14.11.2012 15:59, schrieb Sage Weil:
>> Hi Stefan,
>>
>> I would be nice to confirm that no clients are waiting on replies for
>> these requests; currently we suspect that the OSD request tracking is the
>> buggy part.  If you query the OSD admin socket you should be able to dump
>> requests and see the client IP, and then query the client.
>>
>> Is it librbd?  In that case you likely need to change the config so that
>> it is listening on an admin socket ('admin socket = path').
>
> Yes it is. So i have to specify admin socket at the KVM host? How do i
> query the admin socket for requests?

Yes, add 'admin socket = /path/to/admin/socket' to the [client] section
in ceph.conf, and when a guest is running, show outstanding requests
with:

ceph --admin-daemon /path/to/admin/socket objecter_requests

Josh
