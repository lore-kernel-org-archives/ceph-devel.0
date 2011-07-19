From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: looks like a bug
Date: Tue, 19 Jul 2011 19:28:52 +0300
Message-ID: <4E25B0C4.70105@ufm.su>
References: <4E254135.70603@ufm.su>	<Pine.LNX.4.64.1107190729150.5656@cobra.newdream.net>	<4E259728.8050908@ufm.su> <Pine.LNX.4.64.1107190848360.24443@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:57799 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab1GSQ24 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2011 12:28:56 -0400
In-Reply-To: <Pine.LNX.4.64.1107190848360.24443@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/19/2011 06:49 PM, Sage Weil wrote:
>
> Okay, I found the problem (file mode calculation when O_APPEND is
> present).  There is a fix pushed to the stable branch of ceph.git (for
> mds) and to the for-linus branch of the kernel ceph-client.git.  You need
> both to behave.

Ok, I wait this. :)
> What workload turned this up?
I try restore from bacula backup system and got return error.

strace show:

open("/bacula/amanda.servers.dcv-sd.Restore-hvds0.servers.dcv.2011-07-19_10.59.12_09.6.bootstrap", 
O_RDWR|O_CREAT|O_APPEND, 0666) = 5
fstat(5, {st_mode=S_IFREG|0640, st_size=0, ...}) = 0
write(5, 
"Storage=\"File-hvds0.servers.dcv\"\nVolume=\"hvds0.servers.dcv-daily-20110716-000509\"\nMediaType=\"File-hvds0.servers.dcv\"\nDevice=\"FileStorage-hvds0.servers.dcv\"\nVolSessionId=6\nVolSessionTime=1310991740\nVolAddr=46902909-47361240\nFileIndex=17\nCount=1\n", 
244) = -1 EBADF (Bad file descriptor)

After that I wrote test and saw the same.

WBR,
     Fyodor.
