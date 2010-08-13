From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Enabling RDMA in Ceph
Date: Fri, 13 Aug 2010 10:01:45 -0600
Message-ID: <1281715305.4792.76.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56302 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab0HMQBx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Aug 2010 12:01:53 -0400
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1A8984B7978
	for <ceph-devel@vger.kernel.org>; Fri, 13 Aug 2010 10:01:49 -0600 (MDT)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o7DG1cH2001207 for
 <ceph-devel@vger.kernel.org>; Fri, 13 Aug 2010 10:01:39 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: John H Naegle <jhnaegl@sandia.gov>, "Monk, Stephen" <smonk@sandia.gov>

Hi,

I was wondering if there was any work in progress to get Ceph
to run over RDMA transports?  Our HPC clusters here, where we 
would like to run Ceph, all use DDR or QDR IB interconnects, 
and we think there are latency and bandwidth improvements 
to be had that would improve Ceph performance.

On the server side I've been looking at SimpleMessenger and
SimpleMessenger::Pipe, and the threading model they use. 

It seems like it would be pretty straightforward to
have a RDMAPipe that works like Pipe, but holds an
IB queue pair rather than a socket, and uses the same
threading model as Pipe.  An RDMAMessenger could hold
a collection of RDMAPipe objects, but otherwise work
much the same way as SimpleMessenger does now.

Some recent commits for the OSD code introduced separate
messengers for clients and cluster members, so it seems 
a natural way forward to introduce an option for RDMA
support between daemons, followed by RDMA support between
clients and daemons.

Comments? Opinions?

Also, FWIW quite a lot of work happened in 2008 for NFS-RDMA,
and some of the issues they had to deal with might be pertinent. 
This presentation:
http://openfabrics.org/archives/spring2008sonoma/Tuesday/NFS-RDMA-OFA-08.pdf
has some interesting information on memory registration issues at page 20.
It was mentioned in this email: http://www.spinics.net/lists/linux-nfs/msg03035.html,
which is part of an interesting thread on some of the issues involved.

Thanks -- Jim



