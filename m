From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Re: Controlling placement groups via RADOS
Date: Wed, 22 Dec 2010 00:56:04 +0900
Message-ID: <ABDCBC1E-E7A5-4990-AD8B-2D6D74761549@gmail.com>
References: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com> <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net> <2F3AA09A-B624-4633-BD55-EC2C0B2016D9@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53599 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0LUP4L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 10:56:11 -0500
Received: by pva4 with SMTP id 4so857213pva.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 07:56:10 -0800 (PST)
In-Reply-To: <2F3AA09A-B624-4633-BD55-EC2C0B2016D9@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


Thanks, Noah. I'll definitely check it out.

-Tatsuya


On 12/20/2010, at 5:45 AM, Noah Watkins wrote:

>> There are also a couple FileSystem implementations that replace HDFS with 
>> Ceph.  One uses the libceph userspace client, and one relies on the 
>> kernel's support and uses a few ioctls to control/expose file placement.  
>> I wonder if that would also meet your needs?
> 
> The version that uses the native kernel Ceph client is available for
> Hadoop 0.21 in the following Git branch:
> 
>    git://github.com/noahdesu/hadoop-common.git haceph/0.21-mimic-rawlocal
> 
> The JNI code that interfaces to the Ceph IOCTLs is integrated with
> the Hadoop native-code feature. To compile simply use:
> 
>    ant -Dcompile.native=true -Dnative.ceph.srcdir=/path/to/ceph <targets>
> 
> Note that by default Hadoop native code builds some compression libraries,
> thus you'll need to make sure that zlib development files are installed on the
> system (zlib1g-dev on Debian).
> 
> Finally, the file system URI scheme to use is:
> 
>    "ceph:/path/to/mount".
> 
> - Noah





