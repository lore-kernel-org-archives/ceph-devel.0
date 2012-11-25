From: Gregory Farnum <greg@inktank.com>
Subject: Re: Statistics / Nagios
Date: Sun, 25 Nov 2012 11:08:59 -0800
Message-ID: <9536A23884D44002B4C59911713210DF@inktank.com>
References: <50B262F2.4090205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51101 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2KYTJC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 14:09:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4515987pad.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 11:09:02 -0800 (PST)
In-Reply-To: <50B262F2.4090205@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Sunday, November 25, 2012 at 10:26 AM, Stefan Priebe wrote:
> Hello list,
> 
> are there any useful statistics for ceph? ceph -s shows just the status 
> but i would like to record something which gives me an idea about the 
> ceph load or usage.

Each daemon has an admin socket which you can use to extract "perfcounters" (performance counters). It's not well-documented at all right now, unfortunately.
"ceph --admin-daemon /path/to/admin/socket help"
"ceph --admin-daemon /path/to/admin/socket perfcounters_dump"

"ceph --admin-daemon /path/to/admin/socket perfcounters_schema"

should get you started.
http://ceph.com/docs/master/radosgw/troubleshooting has some examples of troubleshooting the gateway with them.
-Greg

