From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/2] two small patches for CEPH wireshark plugin
Date: Thu, 24 Jan 2013 10:31:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301241028420.13935@cobra.newdream.net>
References: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38442 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab3AXSb1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 13:31:27 -0500
In-Reply-To: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Hi Danny!

On Thu, 24 Jan 2013, Danny Al-Gaaf wrote:
> Danny Al-Gaaf (2):
>   wireshark: fix guint64 print format handling
>   wireshark: fix indention
> 
>  wireshark/ceph/packet-ceph.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Since you brought up wireshark...

We would LOVE LOVE LOVE it if this plugin could get upstream into 
wireshark.  IIRC, the problem (last time we checked, ages ago) was that 
there were strict coding guidelines for that project that weren't 
followed.  I'm not sure if that is still the case, or even if that is 
accurate.

It would be great if someone on this list who is looking for a way to 
contribute could take the lead on trying to make this happen... :-)

sage
