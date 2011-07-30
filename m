From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 20:27:28 +0300
Message-ID: <4E343F00.7070701@ufm.su>
References: <4E33D101.1050504@ufm.su>	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su>	<20110730165001.GI7361@thunk.org> <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:54638 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab1G3R1a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 13:27:30 -0400
In-Reply-To: <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ted Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

On 07/30/2011 08:21 PM, Sage Weil wrote:
>
>> Hmm, looking through recent commits which will shortly be merged into
>> 3.1, this one leaps out, but I'm not sure it's the cause --- how full
>> was your disk at the end of this exercise?
>>
>> I haven't looked at Ceph in quite a while.  As I recall it was
>> primarily doing Direct I/O writes, correct?  Or does it use buffered
>> I/O?  And does it use the new "punch" ioctl to release blocks from the
>> middle of a file?  Ext4 added punch support in 3.0, and there are some
>> bug fixes that are going into 3.1, but I don't think there were any
>> that would lead to the failure mode you are seeing.
> Direct-io is used for the osd journal only; is that on the ext4 partition,
> Fyodor?  Everything else is buffered io.
No, journal placed on tempfs.
> We don't use the new punch ioctl.
>
> We do use xattrs extensively, though; that was the last extN bug we
> uncovered.  That's where my money is.
>
> Fyodor, if you set 'debug filestore = 10' you'll get a log of every
> operation on the fs in the osd log.  (Or close to it; there may be a few
> that we missed, but to a first approximation at least it'll describe the
> workload pretty well.)
Ok, I will try it. But my system fs have only 16G. I'm not sure that it 
fits.

WBR,
     Fyodor.

