From: Sage Weil <sage@newdream.net>
Subject: Re: The cache problem of re-export NFS test
Date: Tue, 12 Apr 2011 08:35:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54437 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab1DLPbw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 11:31:52 -0400
In-Reply-To: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 12 Apr 2011, Sylar Shen wrote:
> Hi developers,
> I know that the following question may not be relative to Ceph but
> this confuses me a lot.
> I am testing the function of re-exporting nfs by command "dd" without
> using buffer.
> That means I would like my data to be written to Ceph DFS directly
> without passing by the buffer of client or nfs-client.
> Here is my test architecture. Hope you could understand what I am
> trying to express.....:p
> ------------------------------------------------------------------------------
>                    nfs                             ceph protocol
> Client <------------>Ceph-Client <-------------------> Ceph DFS
> ------------------------------------------------------------------------------
> I used the command "dd if=/dev/zero of=/mnt/ceph/test bs=64k
> count=10000 oflag=dsync"
> My purpose was to write the data from the client to Ceph DFS through
> Ceph-client.
> Ceph DFS was mounted by Ceph-client using Ceph protocol and
> Ceph-client was mounted by client using nfs protocol.
> I know that my dd command with argument oflag=dsync would write the
> data to Ceph-client without using buffer on the client.
> But I want my Ceph-client could also just pass the data to Ceph DFS
> without using its buffer.
> So.....is there any way I can run my scenario?
> Or in other words, is there any method I can assure that Ceph-client
> won't do the buffer task itself?

I think what you're looking for is the 'sync' option in /etc/exports on 
the ceph-client machine.  See 'man 5 exports'.  That will slow things down 
considerably but will give you the consistency and safety you're looking 
for.

sage
