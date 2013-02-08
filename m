From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 5/6] SyntheticClient.cc: fix some memory leaks in the
 error handling
Date: Fri, 08 Feb 2013 18:47:59 +0100
Message-ID: <51153A4F.8030107@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de> <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:44405 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946758Ab3BHRsF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:48:05 -0500
In-Reply-To: <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Am 08.02.2013 17:25, schrieb Danny Al-Gaaf:
> Fix some memory leaks in case of error handling due to failed
> client->open() calls.
> 
> Error from cppcheck was:
> [src/client/SyntheticClient.cc:1980]: (error) Memory leak: buf
> [src/client/SyntheticClient.cc:2040]: (error) Memory leak: buf
> [src/client/SyntheticClient.cc:2090]: (error) Memory leak: buf
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>

Sorry, wrong patch version with a bug. I'll send a new version of this
patch.

Danny
