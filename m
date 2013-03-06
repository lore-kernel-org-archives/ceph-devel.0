From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS First product release discussion
Date: Wed, 6 Mar 2013 12:07:41 -0700
Message-ID: <513793FD.7010001@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:50003 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab3CFTIH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 14:08:07 -0500
In-Reply-To: <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 03/05/2013 12:33 PM, Sage Weil wrote:
>> > Running 'du' on each directory would be much faster with Ceph since it
>> > accounts tracks the subdirectories and shows their total size with an 'ls
>> > -al'.
>> > 
>> > Environments with 100k users also tend to be very dynamic with adding and
>> > removing users all the time, so creating separate filesystems for them would
>> > be very time consuming.
>> > 
>> > Now, I'm not talking about enforcing soft or hard quotas, I'm just talking
>> > about knowing how much space uid X and Y consume on the filesystem.
> The part I'm most unclear on is what use cases people have where uid X and 
> Y are spread around the file system (not in a single or small set of sub 
> directories) and per-user (not, say, per-project) quotas are still 
> necessary.  In most environments, users get their own home directory and 
> everything lives there...

Hmmm, is there a tool I should be using that will return the space
used by a directory, and all its descendants?

If it's 'du', that tool is definitely not fast for me.

I'm doing an 'strace du -s <path>', where <path> has one
subdirectory which contains ~600 files.  I've got ~200 clients
mounting the file system, and each client wrote 3 files in that
directory.

I'm doing the 'du' from one of those nodes, and the strace is showing
me du is doing a 'newfstat' for each file.  For each file that was
written on a different client from where du is running, that 'newfstat'
takes tens of seconds to return.  Which means my 'du' has been running
for quite some time and hasn't finished yet....

I'm hoping there's another tool I'm supposed to be using that I
don't know about yet.  Our use case includes tens of millions
of files written from thousands of clients, and whatever tool
we use to do space accounting needs to not walk an entire directory
tree, checking each file.

-- Jim


> 
> sage
> 
> 
>> > 
>> > Wido


