From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Performance test on Ceph cluster
Date: Wed, 22 Feb 2012 09:55:15 -0800
Message-ID: <CAF3hT9BFCUwkQhPsNm6fYW4wePRaOr_pK1MfxHTtnYSvBJoupA@mail.gmail.com>
References: <loom.20120222T102830-526@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59193 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab2BVRzQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 12:55:16 -0500
Received: by yhoo21 with SMTP id o21so195078yho.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 09:55:15 -0800 (PST)
In-Reply-To: <loom.20120222T102830-526@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 22, 2012 at 1:39 AM, madhusudhana
<madhusudhana.u.acharya@gmail.com> wrote:
> Hi
> I have finally configured a ceph cluster with 8 nodes. I have 2 MDS
> servers and 3 monitors and rest of 3 nodes are OSD. Each system has
> 2T SATA drives. I have 3 partitions created, one for root file
> system, another for CEPH journal and the rest of the space is for
> OSD. I was able to get 5.6T space from three nodes.
>
> All the machines are of same type (HP DL160 G7) with 48 of RAM and
> quad core dual cpu's.
>
> I am using iozone for testing the performance against NetApp filer
> Below is the command what I am using for iozone test
>
> /opt/iozone/bin/iozone -R -e -l i -u 1 -r 4096k -s 1024m -F /mnt/ceph-
> test/ceph.iozone

If I'm reading it correctly you're using Direct IO? That's almost
certainly just going to be slow...

>
> When I see the result, the value from ceph cluster is not at all
> coming near to an entry level NetApp filer. I would like to
> know the ideal way (if there is any) for testing ceph cluster
> performance so that we can compare it with other file systems.
> If required, I can share the test results.

Please do, or we won't have anywhere to go off of. :) And are you
running this on GigE or 10GigE?
-Greg
