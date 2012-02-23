From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: Performance test on Ceph cluster
Date: Thu, 23 Feb 2012 07:12:56 +0000 (UTC)
Message-ID: <loom.20120223T080047-368@post.gmane.org>
References: <loom.20120222T102830-526@post.gmane.org> <CAORUGqC4Nof1d0V1K-ntNuRMh6c27AC+cB67HCxsKR-fWa+qPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40861 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab2BWHNN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Feb 2012 02:13:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S0SrY-0005J2-LC
	for ceph-devel@vger.kernel.org; Thu, 23 Feb 2012 08:13:12 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 08:13:12 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 08:13:12 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:

> 
> On Wed, Feb 22, 2012 at 01:39, madhusudhana
> <madhusudhana.u.acharya <at> gmail.com> wrote:
> > Hi
> > I have finally configured a ceph cluster with 8 nodes. I have 2 MDS
> > servers and 3 monitors and rest of 3 nodes are OSD. Each system has
> > 2T SATA drives. I have 3 partitions created, one for root file
> > system, another for CEPH journal and the rest of the space is for
> > OSD. I was able to get 5.6T space from three nodes.
> >
> > All the machines are of same type (HP DL160 G7) with 48 of RAM and
> > quad core dual cpu's.
> >
> > I am using iozone for testing the performance against NetApp filer
> > Below is the command what I am using for iozone test
> >
> > /opt/iozone/bin/iozone -R -e -l i -u 1 -r 4096k -s 1024m -F /mnt/ceph-
> > test/ceph.iozone
> 
> 1. Make sure you have only 1 active MDS, multi-MDS is an extra
> complication you're better skipping right now.
> 2. What underlying filesystem are you using for the OSDs?
> 3. What Linux kernel version is running on the OSDs?
> 4. What machine is the client, running iozone? How is it connected to
> the others? Kernel client or FUSE?
> 5. What Linux kernel version is running on the client?
> 
> Going forward, in a setup like that you could put OSDs on the machines
> that run ceph-mon; ceph-mon is very lightweight and doesn't need
> dedicated machines in a small setup.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
1. can you please let me know how I can make only 1 MDS active ?
2. BTRFS for all OSD's
3. All hosts (including OSD) in my ceph cluster are running 3.0.9 ver
                [root@ceph-node-8 ~]# uname -r
                3.0.9
4. All 9 machines are replica of each other. I have imaged them using 
systemimager. Only difference is 9th node is not a part of CEPH 
cluster. I mounted ceph cluster to this node using mount -t ceph 
command
5. All 9 clients are running same version of CentOS and Kernel with
1GigE interface

You mean to say, I can have ceph mon/OSD's running in the 
same machine ? but, in ceph wiki, i have read that its better to 
have different machines for each mds/mon/osd. 

I assume that ceph uses whatever ethernet interface i have (1GigE)
in my system to load balance the cluster in case of node failure and
node addition. Won't this uses entire bandwidth during load 
balancing ? won't this cause bandwidth saturation for clients ?

I would like to know what benchmark I should use to test CEPH ?
I want to present the data to my management how CEPH can perform when
compared with other file systems (like GlusterFS/NetApp/Lustre)

Thanks
Madhusudhana


