From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: My favorite question
Date: Wed, 27 Jul 2011 13:05:05 +0300
Message-ID: <4E2FE2D1.8040902@ufm.su>
References: <4E25646C.4000909@ufm.su>	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>	<4E2996DD.8040809@ufm.su>	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>	<4E2DDD1D.2040003@ufm.su>	<CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>	<4E2E04C2.2050000@ufm.su>	<CAF3hT9AMrbtu051uQaBAAMnfnUWrSFdBHix9FFYgzLrg42YV5g@mail.gmail.com>	<4E2F0981.50504@ufm.su>	<CAF3hT9AD+f6gEbzihUpNFKSfhALvMoPpudHDXxnmL5PRyOPZ0Q@mail.gmail.com>	<4E2F135C.5010306@ufm.su> <CAF3hT9CtaCi8S56+hGpU0mn-tH1WJob081J4Bb0_Z7asPZcXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:47615 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1G0KFK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jul 2011 06:05:10 -0400
In-Reply-To: <CAF3hT9CtaCi8S56+hGpU0mn-tH1WJob081J4Bb0_Z7asPZcXdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 07/27/2011 01:24 AM, Gregory Farnum wrote:
> Hmm, I'm afraid I can't see anything useful in these logs right now --
> just confusion!
>
> The only thing I can think of that might provide useful information
> now is to turn off osd5, update its config file to have heavy
> debugging information (debug osd = 20, at a minimum), and then start
> the OSD back up again. Then we can see if pg 0.256 is still having any
> issues (it is in the logs you sent me).
>
> If not I'll have to mark this as "Can't reproduce" and hope we see it
> again from somebody with higher log levels on. :(
> -Greg

I started manual scrubbing on osd5 and got next message:

2011-07-27 11:38:30.360812   log 2011-07-27 11:38:28.540559 osd5 
10.5.51.145:6803/19737 2842 : [ERR] 0.256 scrub stat mismatch, got 
2196/2196 objects, 0/0 clones, 9046200695/9046200817 bytes, 
8834197/8834197 kb.
2011-07-27 11:38:30.360812   log 2011-07-27 11:38:28.540571 osd5 
10.5.51.145:6803/19737 2843 : [ERR] 0.256 scrub 1 errors

"Hmmm" I said to myself.

stop osd5
fsck -fy /dev/sdb1

And got:

Inode 230558734, i_blocks is 8, should be 16.  Fix? yes
Inode 230559279, i_blocks is 8208, should be 8200.  Fix? yes
Inode 230559410, i_blocks is 40, should be 32.  Fix? yes
Inode 230559527, i_blocks is 24, should be 32.  Fix? yes
Inode 231342174, i_blocks is 40, should be 32.  Fix? yes
Inode 231342209, i_blocks is 24, should be 32.  Fix? yes

Ups. Familiar message. :(

I login to different node and got the same.

Greg, I think to catch any errors no sense. 2.6.39 have broken ext4. I 
will try 3.0.0 (or 3.1.0) and tell about result.

WBR,
     Fyodor.
