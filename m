From: Sage Weil <sage@newdream.net>
Subject: Re: Having issues trying to get the OSD up on a MIPS64!!!
Date: Tue, 17 Feb 2015 09:06:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502170905520.22050@cobra.newdream.net>
References: <loom.20141023T030922-990@post.gmane.org> <alpine.DEB.2.00.1410231749420.13498@cobra.newdream.net> <BC9BE980F12C4446A1CB0380E1C97DCD3390D99A@EXMAIL1.taec.toshiba.com> <alpine.DEB.2.00.1410241743490.13498@cobra.newdream.net>
 <71E1B92E73606A4ABC3D0EC55B2BF09834221AED@EXMAIL1.taec.toshiba.com> <alpine.DEB.2.00.1410241810300.13498@cobra.newdream.net> <BC9BE980F12C4446A1CB0380E1C97DCD3390DAEC@EXMAIL1.taec.toshiba.com> <loom.20150217T085627-77@post.gmane.org>
 <alpine.DEB.2.00.1502170603410.22050@cobra.newdream.net> <54B715FC-60FA-4787-83BF-A9761E1C5334@sbcglobal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44053 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbbBQRGi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 12:06:38 -0500
In-Reply-To: <54B715FC-60FA-4787-83BF-A9761E1C5334@sbcglobal.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bao Vu <vu_bao@sbcglobal.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 17 Feb 2015, Bao Vu wrote:
> >> ./.libs/libosd.a(libos_la-FileStore.o): In function 
> >> `FileStoreBackend::create(long, FileStore*)':
> >> FileStore.cc:(.text+0x8f1c): undefined reference to 
> >> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> >> FileStore.cc:(.text+0x8f24): undefined reference to 
> >> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> >> FileStore.cc:(.text+0x8f2c): undefined reference to 
> >> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> >> collect2: error: ld returned 1 exit status
> > 
> > It looks like maybe the BtrfsFileStoreBackend is not being linked in?  
> > Perhaps there is some Makefile magic going on?  Which version/commit are 
> > you on, and have you made any Makefile modifications?
> > 
> > Unfortunately we don't have a MPIS64 box in the community lab to play 
> > with.
> > 
> > sage
> 
> I am using 0.87. I do not change makefile . It is created by the configure. I try to build ceph for MIPS64. So far, I have no luck. 

It is probably best to work from the latest git master to make sure you've 
captured any recent changes.  MIPS64 support isn't something that would 
have been backported.

sage
