From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Facing some basic stability issues
Date: Fri, 11 Mar 2011 20:01:23 +0530
Message-ID: <1299853883.15120.20.camel@indica.cc.iitb.ac.in>
References: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
	 <41CFF52D45D542C8A45E8590301D5557@gmail.com>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:45300 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755396Ab1CKOba (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Mar 2011 09:31:30 -0500
In-Reply-To: <41CFF52D45D542C8A45E8590301D5557@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg,

I found that the mds process dies during the weird 'untar'
behavior. I am trying to analyze the logs. May be I will
find something there.

I also have made another mistake. My client host runs FC13
whereas the rest (mon-mds, osd1, and osd2) are FC14.
Is this mix of OS OK ? I will anyway try and quickly upgrade
the client to FC14 ASAP.

Thanks.

--ajit
 
On Thu, 2011-03-10 at 09:16 -0800, Gregory Farnum wrote:
> Hmmm, your conf file isn't obviously broken but you shouldn't be having any trouble with an untar, either.
> 
> When the untar hangs, have you checked to make sure none of the daemons have crashed? Are they all idle, or is one of them using a lot of CPU?
> -Greg
> On Thursday, March 10, 2011 at 3:04 AM, Ajit K Jena wrote: 
> > Hi List,
> > 
> > We are trying to setup a small 3 node ceph testbed.
> > The basic setup is:
> > 
> >  node1: cmon and mds
> > 
> >  node2: osd1
> > 
> >  node3: osd2
> > 
> >  cl1 and cl2: The clients where ceph filesystem
> >  is mounted. We are using it as a
> >  standard POSIX filesystem and not
> >  using fuse.
> > 
> >  Operating System: All the participating systems
> >  have Fedora core 14 as the operating
> >  system.
> > 
> >  Underlying Filesystem: We have tried both btrfs and
> >  and ext4. For each filesystem type we
> >  have tried both with and without journal
> >  options.
> > 
> >  Ceph version: 0.25
> > 
> > The problem we are facing is:
> > 
> >  The setup goes thru fine. When we copy single files of
> >  upto 5-6 GB that also is fine. However we get into trouble
> >  if we untar even small files (e.g. 50 MB). The untar
> >  process on the client hangs. In fact if any process tries
> >  to access the ceph mounted filesystem (e.g. doing 'ls -l'),
> >  the process simply hangs and even the shell gets locked
> >  up. The only solution seems to be a system reboot.
> > 
> > The ceph.conf file is attached with the mail.
> > 
> > Pl help us solve this problem. I have seen
> > other postings in this list where people talk
> > about performance benchmarking but we are
> > stuck up on this very basic issue.
> > 
> > Thanks in anticipation.
> > 
> > --ajit
> > 
> > Attachments: 
> > - ceph.conf
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


