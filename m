From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Controlling placement groups via RADOS
Date: Sun, 19 Dec 2010 12:45:12 -0800
Message-ID: <2F3AA09A-B624-4633-BD55-EC2C0B2016D9@cs.ucsc.edu>
References: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com> <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:60762 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932471Ab0LSUpS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Dec 2010 15:45:18 -0500
In-Reply-To: <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tatsuya Kawano <tatsuya6502@gmail.com>, ceph-devel@vger.kernel.org

> There are also a couple FileSystem implementations that replace HDFS with 
> Ceph.  One uses the libceph userspace client, and one relies on the 
> kernel's support and uses a few ioctls to control/expose file placement.  
> I wonder if that would also meet your needs?

The version that uses the native kernel Ceph client is available for
Hadoop 0.21 in the following Git branch:

    git://github.com/noahdesu/hadoop-common.git haceph/0.21-mimic-rawlocal

The JNI code that interfaces to the Ceph IOCTLs is integrated with
the Hadoop native-code feature. To compile simply use:

    ant -Dcompile.native=true -Dnative.ceph.srcdir=/path/to/ceph <targets>

Note that by default Hadoop native code builds some compression libraries,
thus you'll need to make sure that zlib development files are installed on the
system (zlib1g-dev on Debian).

Finally, the file system URI scheme to use is:

    "ceph:/path/to/mount".

- Noah