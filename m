From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: fs again
Date: Sat, 04 Jun 2011 02:58:52 +0300
Message-ID: <4DE9753C.7010306@ufm.su>
References: <4DE97258.2040206@ufm.su> <BANLkTikWGimkB49ah8i01ZTcy8Y19PgyXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:37215 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab1FCX6z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2011 19:58:55 -0400
In-Reply-To: <BANLkTikWGimkB49ah8i01ZTcy8Y19PgyXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 06/04/2011 02:49 AM, Gregory Farnum wrote:
> I run ext4 and btrfs on different partitions, that I use for Ceph, and
> I think everybody else does too.
>
> I don't remember if you're killing new or old versions of these FSes, though.
Hmm. Ok, ext4 - it's my next target. :)
About btrfs I'm wrote in the same letter that ext3.

BTW, as I see - in fresh 2.6.39.1 no patches that would be interesting 
(ext3/btrfs/ceph). Or I do something not notice?

WBR,
     Fyodor.
