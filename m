From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Filesystems for ceph
Date: Thu, 28 Jul 2011 21:27:27 +0300
Message-ID: <4E31AA0F.10202@ufm.su>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>	<loom.20110728T001529-856@post.gmane.org>	<Pine.LNX.4.64.1107271633110.29985@cobra.newdream.net>	<4E30E42E.30101@ufm.su> <Pine.LNX.4.64.1107272133000.29447@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:57800 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab1G1S1b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jul 2011 14:27:31 -0400
In-Reply-To: <Pine.LNX.4.64.1107272133000.29447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/28/2011 07:35 AM, Sage Weil wrote:
> Oh, you mean the fsck errors?  Got it.  If you see it again (on another
> disk/machine, with a reasonably fresh fs) the ext4 guys will be interested
> in hearing about it.  It's probably in the xattr code, which ceph uses
> heavily but most people only set once per file (for selinux labels), if
> at all.
I now see it on _all_ of 12 osd (8 physical servers, each osd have own fs).

I plan to upgrade the kernel on the osd servers to 3.0 and if  do not 
get better - then time to shake the guys from ext4 team (with your help)

WBR,
     Fyodor.
