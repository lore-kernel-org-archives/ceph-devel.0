From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 20:16:00 +0300
Message-ID: <4E343C50.1000106@ufm.su>
References: <4E33D101.1050504@ufm.su>	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su> <20110730165001.GI7361@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:45787 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab1G3RQE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 13:16:04 -0400
In-Reply-To: <20110730165001.GI7361@thunk.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org

Ted Ts'o <tytso <at> mit.edu> writes:


 > Right, sorry, I missed that.  And just to be clear this wasn't an -rc
 > kernel but 3.0 final, right?
Yes.

 >
 > Hmm, looking through recent commits which will shortly be merged into
 > 3.1, this one leaps out, but I'm not sure it's the cause --- how full
 > was your disk at the end of this exercise?
root@osd0:~# df -h /osd.0/
Filesystem            Size  Used Avail Use% Mounted on
/dev/sdc1             3.6T  1.3T  2.2T  37% /osd.0
root@osd0:~#

 >
 > I haven't looked at Ceph in quite a while.  As I recall it was
 > primarily doing Direct I/O writes, correct?  Or does it use buffered
 > I/O?  And does it use the new "punch" ioctl to release blocks from the
 > middle of a file?  Ext4 added punch support in 3.0, and there are some
 > bug fixes that are going into 3.1, but I don't think there were any
 > that would lead to the failure mode you are seeing.

Ted, I'm sorry, I'm not a developer. I can not answer these questions, 
but I can try build 3.1

WBR,
     Fyodor

