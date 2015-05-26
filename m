From: John Spray <john.spray@redhat.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Tue, 26 May 2015 12:57:23 +0100
Message-ID: <55645FA3.3090507@redhat.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com>	<CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>	<555F4C78.7060601@redhat.com>	<CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com> <CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbbEZNuf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 09:50:35 -0400
In-Reply-To: <CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>, Barclay Jameson <almightybeeij@gmail.com>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 26/05/2015 07:55, Yan, Zheng wrote:
> the reason for slow file creations is that bonnie++ call fsync(2) 
> after each creat(2). fsync() wait for safe replies of the create 
> requests. MDS sends safe reply when log event for the request gets 
> journaled safely. MDS flush the journal every 5 seconds 
> (mds_tick_interval). So the speed of file creation for bonnie++ is one 
> file every file seconds.

Ah, I hadn't noticed that the benchmark called... I wonder if I'm seeing 
the fuse client return quickly because it simply doesn't implement the 
fsyncdir call.  We should fix that!

It looks like we used to have an OP_FSYNC in the client-server protocol 
(perhaps for flushing the log immediately on fsyncs), anyone have any 
background on why that went away?

Cheers,
John
