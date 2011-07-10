From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: 0.31
Date: Mon, 11 Jul 2011 00:29:16 +0300
Message-ID: <4E1A19AC.8060304@ufm.su>
References: <4E19837D.7030702@ufm.su> <Pine.LNX.4.64.1107101411040.10951@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:44180 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab1GJV3U (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Jul 2011 17:29:20 -0400
In-Reply-To: <Pine.LNX.4.64.1107101411040.10951@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/11/2011 12:12 AM, Sage Weil wrote:
> Hmm, yeah the 'loaded dup inode' messages should never happen.  They
> appear to be just files, though, not directories, so you can safely ignore
> them.  The namespace repair will need to clean that up at some point. The
> recursive rstat errors you saw are probably just fallout from that, and
> can also be ignored.
I understand it correctly, that until not  implemented the Feature # 86 
I have no way to fix this?
> I'm curious how you got into that state, though.  Are you running a single
> or clustered mds?  Is the workload purely amanda?
Single mds. I have these clients:
1. Amanda. Used cfuse.
2. Gate. Used cfuse. NFS gate.
3. One experimental server with many different workloads.

WBR,
     Fyodor.

P.S. My friends have always said that I can find a bug in the software, 
even where it can not be. Sometimes it interferes. :)

I will try again to use ceph with BackupPC. Last time it was over "brain 
explosion" in ceph. :)
