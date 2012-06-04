From: udit agarwal <fzdudit@gmail.com>
Subject: Re: iozone test crashed on ceph
Date: Mon, 4 Jun 2012 21:52:29 +0000 (UTC)
Message-ID: <loom.20120604T235042-446@post.gmane.org>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59587 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760946Ab2FDVxA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jun 2012 17:53:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SbfCh-00084d-Q3
	for ceph-devel@vger.kernel.org; Mon, 04 Jun 2012 23:52:53 +0200
Received: from mike-alien.esc.auckland.ac.nz ([130.216.209.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 23:52:47 +0200
Received: from fzdudit by mike-alien.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 23:52:47 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I ran the 5g iozone test on my ceph system and I got the following output on the
terminal: 

hp1:/media/ceph # /opt/iozone/bin/iozone -Rab 20120519_1641_results_5g.xls -R -i
0 -i 2 -f /media/ceph/iozone.file -s 5g
	Iozone: Performance Test of File I/O
	        Version $Revision: 3.408 $
		Compiled for 64 bit mode.
		Build: linux-AMD64 

	Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
	             Al Slater, Scott Rhine, Mike Wisner, Ken Goss
	             Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
	             Randy Dunlap, Mark Montague, Dan Million, Gavin Brebner,
	             Jean-Marc Zucconi, Jeff Blomberg, Benny Halevy, Dave Boone,
	             Erik Habbinga, Kris Strecker, Walter Wong, Joshua Root,
	             Fabrice Bacchella, Zhenghua Xue, Qin Li, Darren Sawyer.
	             Ben England.

	Run began: Mon Jun  4 20:27:31 2012

	Excel chart generation enabled
	Auto Mode
	Excel chart generation enabled
	File size set to 5242880 KB
	Command line used: /opt/iozone/bin/iozone -Rab 20120519_1641_results_5g.xls -R
-i 0 -i 2 -f /media/ceph/iozone.file -s 5g
	Output is in Kbytes/sec
	Time Resolution = 0.000001 seconds.
	Processor cache size set to 1024 Kbytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
                                                            random  random   
bkwd   record   stride                                   
              KB  reclen   write rewrite    read    reread    read   write   
read  rewrite     read   fwrite frewrite   fread  freread
         5242880       4   34256   32763                  Killed

Message from syslogd@hp1 at Jun  4 22:19:03 ...
 kernel:[ 7627.132065] Oops: 0000 [#1] PREEMPT SMP 

Message from syslogd@hp1 at Jun  4 22:19:03 ...
 kernel:[ 7627.132190] Stack:

Message from syslogd@hp1 at Jun  4 22:19:03 ...
 kernel:[ 7627.132213] Call Trace:

Message from syslogd@hp1 at Jun  4 22:19:03 ...
 kernel:[ 7627.132356] Code: ab c0 fe ff ff 0f 84 85 00 00 00 31 f6 48 89 df e8
03 d7 ff ff 4c 89 ef 48 89 44 24 28 e8 f6 91 ed e0 48 8b 44 24 28 48 8b 50 08 

Message from syslogd@hp1 at Jun  4 22:19:03 ...
 kernel:[ 7627.132426] CR2: 000000000000000a

Can anybody help me with this??

--Udit Agarwal


