From: David Zafman <david.zafman@inktank.com>
Subject: Re: [PATCH 0/2] two small patches for CEPH wireshark plugin
Date: Mon, 28 Jan 2013 20:35:59 -0800
Message-ID: <A96E0EEB-4620-4634-880B-4DC087C14F92@inktank.com>
References: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de> <alpine.DEB.2.00.1301241028420.13935@cobra.newdream.net> <51019E41.9070705@bisect.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64786 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3A2EgE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 23:36:04 -0500
Received: by mail-pb0-f42.google.com with SMTP id wz17so21335pbc.29
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 20:36:03 -0800 (PST)
In-Reply-To: <51019E41.9070705@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>


You could look at the wip-wireshark-zafman branch.  I rebased it and force pushed it.   It has changes to the wireshark.patch and a minor change I needed to get it to build.  I'm surprised the recent checkin didn't include the change to packet-ceph.c which I needed to get it to build.

David Zafman
Senior Developer
david.zafman@inktank.com



On Jan 24, 2013, at 12:49 PM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:

> Am 24.01.2013 19:31, schrieb Sage Weil:
>> Hi Danny!
> [...]
>> Since you brought up wireshark...
>> 
>> We would LOVE LOVE LOVE it if this plugin could get upstream into 
>> wireshark.  
> 
> Yes, this would be great.
> 
>> IIRC, the problem (last time we checked, ages ago) was that 
>> there were strict coding guidelines for that project that weren't 
>> followed.  I'm not sure if that is still the case, or even if that is 
>> accurate.
>> 
>> It would be great if someone on this list who is looking for a way to 
>> contribute could take the lead on trying to make this happen... :-)
> 
> I'll take a look at it maybe ... if I find some free time for it.
> 
> What about the patches? Can we apply them to the ceph git tree until we
> have another solution for the wireshark code?
> 
> Danny
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

