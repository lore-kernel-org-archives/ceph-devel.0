From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 5/6] SyntheticClient.cc: fix some memory leaks in the
 error handling
Date: Sun, 10 Feb 2013 09:43:47 +0100
Message-ID: <51175DC3.2020008@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de> <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de> <alpine.DEB.2.00.1302092203440.11665@cobra.newdream.net>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43449 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600Ab3BJInv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Feb 2013 03:43:51 -0500
In-Reply-To: <alpine.DEB.2.00.1302092203440.11665@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Am 10.02.2013 07:04, schrieb Sage Weil:
> On Fri, 8 Feb 2013, Danny Al-Gaaf wrote:
[...]
>>    //dout(5) << "SyntheticClient::write_fd: writing to fd " << fd << dendl;
>> -  if (fd < 0) return fd;
>> +  if (fd < 0) {
>> +    return fd;
>> +    delete[] buf;
> 
> oops, wrong order...

I know, that's why I've send another fixed version of this patch to the
list the same day:
http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/12969/focus=12985

Danny

