From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: fs selection.
Date: Fri, 27 May 2011 19:56:51 +0300
Message-ID: <4DDFD7D3.2030302@ufm.su>
References: <4DDF9207.4090008@ufm.su> <BANLkTi=6RAQgCnqoNvMPFfchgCtLpF7qhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:47415 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1E0Q4y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2011 12:56:54 -0400
In-Reply-To: <BANLkTi=6RAQgCnqoNvMPFfchgCtLpF7qhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/27/2011 06:18 PM, Gregory Farnum wrote:
> You are really putting this stuff through the wringer -- nobody else
> hits these issues so frequently!
I wait release of ceph bouncing on the chair with impatience. :)
And to help catch errors as many as possible before the release - it's a 
minimum what I can do.
> Can you remind us of your test setup? I'd like to figure out how
> you're killing these FSes so badly.
>
> And just randomly, I'd try ext4 before xfs. :)
ext4 have the same user_xattr. I think no sense. :)

WBR,
     Fyodor.
