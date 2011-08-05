From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: read performance not perfect
Date: Fri, 05 Aug 2011 22:30:36 +0300
Message-ID: <4E3C44DC.9090906@ufm.su>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>	<Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>	<CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>	<Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>	<loom.20110804T213454-854@post.gmane.org>	<Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>	<4E3B2D78.5060605@ufm.su>	<Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>	<4E3B8F0E.20606@ufm.su> <Pine.LNX.4.64.1108050905350.12301@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:55625 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab1HETal (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Aug 2011 15:30:41 -0400
In-Reply-To: <Pine.LNX.4.64.1108050905350.12301@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 08/05/2011 07:07 PM, Sage Weil wrote:
>
> This is the problem.  The readahead patches in the master branch of
> git://ceph.newdream.net/git/ceph-client.git.  They're not upstream yet.
> Sorry that wasn't clear!
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=e9852227431a0ed6ceda064f33e4218757acab6c 
- it's not this patch?

WBR,
     Fyodor.
