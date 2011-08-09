From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: cfuse memory leak?
Date: Tue, 09 Aug 2011 20:16:01 +0300
Message-ID: <4E416B51.7010709@ufm.su>
References: <4E415FAE.3050808@ufm.su> <4E41679A.8020807@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:34622 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab1HIRQE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Aug 2011 13:16:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 63ECA600247
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 20:16:02 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHfMM2DckQtp for <ceph-devel@vger.kernel.org>;
	Tue,  9 Aug 2011 20:16:02 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 41309600245
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 20:16:02 +0300 (EEST)
In-Reply-To: <4E41679A.8020807@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/09/2011 08:00 PM, Fyodor Ustinov wrote:
> On 08/09/2011 07:26 PM, Fyodor Ustinov wrote:
>> Hi!
>>
>> root@backup-ext:/etc/pure-ftpd/conf# ps v -C cfuse
>>   PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
>>   916 ?        Sl    86:35  21025  2260 1514931 645632 63.1 
>> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>>
>> WBR,
>>     Fyodor.
> root@backup-ext:/etc/pure-ftpd/conf# ps v -C cfuse
>   PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
>   916 ?        Sl    88:22  21052  2260 1514995 633112 61.9 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>   916 ?        Sl    88:33  21053  2260 1514999 631228 61.7 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>   916 ?        Sl    90:16  21278  2260 1515063 623672 60.9 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>   916 ?        Sl    90:52  21318  2260 1515083 620620 60.6 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>   916 ?        Sl    91:56  24599  2260 1548275 652880 63.8 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>   916 ?        Sl    95:20  27244  2260 1589003 659076 64.4 
> /usr/bin/cfuse -m 10.5.51.230 -r /clients /clients
>
> DRS memory more and more....
>
> WBR,
>     Fyodor
>
> P.S. rsync from nfs to ceph in background.
>
Well. As might be expected. Evil oom_killer put things in order.

[22571.133278] Out of memory: Kill process 916 (cfuse) score 684 or 
sacrifice child
[22571.133410] Killed process 916 (cfuse) total-vm:1591300kB, 
anon-rss:658892kB, file-rss:380kB

WBR,
     Fyodor.
