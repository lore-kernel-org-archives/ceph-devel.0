From: Christoph Raible <c.raible@science-computing.de>
Subject: Can't start Ceph with CentOS 5.6
Date: Thu, 14 Apr 2011 08:56:54 +0200
Message-ID: <4DA69AB6.9050508@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.belwue.de ([129.143.2.15]:63473 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757480Ab1DNHJX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 03:09:23 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp2.belwue.de with ESMTP id p3E6uuD6013752
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 08:56:56 +0200 (MEST)
	env-from (prvs=078379a8d=c.raible@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id A81B4414004
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 08:56:55 +0200 (CEST)
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifcfYyurjVbg for <ceph-devel@vger.kernel.org>;
	Thu, 14 Apr 2011 08:56:55 +0200 (CEST)
Received: from nerva.science-computing.de (nerva.science-computing.de [10.10.16.94])
	by scmail.science-computing.de (Postfix) with ESMTP id 1088C414003
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 08:56:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nerva.science-computing.de (Postfix) with ESMTP id E9900A3421
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 08:56:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi @all,

I compilied & configured ceph 0.26 today  and now i want to start ceph 
with  /etc/init.d/ceph -a start  oder service ceph -a start   but the 
service is unknown and in /etc/init.d  there is noch such file!

I compiled ceph with following commands:



######################

   ./autogen.sh

   CXXFLAGS="-g -O2" ./configure --prefix=/usr --sbindir=/sbin
   --localstatedir=/var --sysconfdir=/etc

   make

   make install


########################




My ceph.conf in /etc/ceph/ looks like this:


#######################

; global
[global]
	; enable secure authentication
	auth supported = cephx

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
	mon data = /data/mon$id

	; some minimal logging (just message traffic) to aid debugging
	debug ms = 1

[mon0]
	host = ceph0
	mon addr = 10.1.9.45:6789

[mon1]
	host = ceph1
	mon addr = 10.1.9.46:6789

....

; mds
;  You need at least one.  Define two to get a standby.
[mds]
	; where the mds keeps its secret encryption keys
	keyring = /data/keyring.$name

[mds.0]
	host = ceph0
         mds standby replay = true
         mds standby for name = ceph1
[mds.1]
	host = ceph1
         mds standby replay = true
         mds standby for name = ceph2
....



; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data = /data/osd$id

	; Ideally, make this a separate disk or partition.  A few GB
  	; is usually enough; more if you have fast disks.  You can use
  	; a file under the osd data dir if need be
  	; (e.g. /data/osd$id/journal), but it will be slower than a
  	; separate disk or partition.
	osd journal = /data/osd$id/journal

         ; If the OSD journal is a file, you need to specify the size. 
This is specified in MB.
         osd journal size = 512



[osd0]
; if 'btrfs devs' is not specified, you're responsible for
	; setting up the 'osd data' dir.  if it is not btrfs, things
	; will behave up until you try to recover from a crash (which
	; usually fine for basic testing).
	host = ceph0
	btrfs devs = /dev/sdb1

[osd1]
	host = ceph1
	btrfs devs = /dev/sdb1

....

#######################


When I want to start ceph with ceph -c /etc/ceph/ceph.conf  I got 
following messages:

#######################


2011-04-14 08:59:59.236688 4049d940 -- :/10014 >> 10.1.9.45:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:02.237107 41190940 -- :/10014 >> 10.1.9.48:6789/0 
pipe(0x7f1ff4001570 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:05.237271 4049d940 -- :/10014 >> 10.1.9.47:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:08.237502 41190940 -- :/10014 >> 10.1.9.48:6789/0 
pipe(0x7f1ff4001570 sd=4 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:11.237709 4049d940 -- :/10014 >> 10.1.9.47:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:14.237554 41190940 -- :/10014 >> 10.1.9.46:6789/0 
pipe(0x7f1ff4001570 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:17.238122 4049d940 -- :/10014 >> 10.1.9.47:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:20.238162 41190940 -- :/10014 >> 10.1.9.46:6789/0 
pipe(0x7f1ff4001570 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:23.238641 4049d940 -- :/10014 >> 10.1.9.45:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:26.238939 41190940 -- :/10014 >> 10.1.9.48:6789/0 
pipe(0x7f1ff4001570 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:29.239232 4049d940 -- :/10014 >> 10.1.9.45:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:32.239554 41190940 -- :/10014 >> 10.1.9.47:6789/0 
pipe(0x7f1ff4001570 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-04-14 09:00:35.239555 4049d940 -- :/10014 >> 10.1.9.46:6789/0 
pipe(0x7f1ff4000ad0 sd=3 pgs=0 cs=0 l=0).fault first fault


#######################



I realy hope someone can help me....


Best regards,

Christoph Raible
-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 


