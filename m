From: Sage Weil <sage@newdream.net>
Subject: Re: write operations
Date: Sat, 23 Jul 2011 07:30:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107230728180.30052@cobra.newdream.net>
References: <CAJMJAuM74+eod5PMKC_VowxwAMyutbKJr0oY8xX2ELFAybZk5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43990 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab1GWO1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jul 2011 10:27:14 -0400
In-Reply-To: <CAJMJAuM74+eod5PMKC_VowxwAMyutbKJr0oY8xX2ELFAybZk5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Hastings <bllhastings@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Jul 2011, Bill Hastings wrote:
> Hi Sage
> 
> Sorry to send this to you directly. All attempts to send emails to
> ceph-devel@vger.kernel.org are failing for me. Here is my questions:

vger throws out all HTML email.  Make sure you send in plaintext.

> How do writes work in Ceph? If I open a file and write say 255 bytes say
> intervals of 10 secs 1000 times. Are small amounts of data cached and then
> pushed out to the server? I want to know the flow of the write operation
> through the system.

The page cache will normally absorb this and write out large chunks. This 
is governed by the Linux VM, and behavior will be more or less identical 
to any other file system (ext3, NFS, etc.).

> If I am doing a large streaming write are writes chunked the way they are in
> HDFS for instance?

Ceph (by default) stripes files over 4MB objects.  The default policy is 
configurable on a per-directory or per-file basis.

sage
