From: Christoph Raible <c.raible@science-computing.de>
Subject: mount.ceph: modprobe failed, exit status 127
Date: Fri, 15 Apr 2011 13:23:10 +0200
Message-ID: <4DA82A9E.5010504@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.belwue.de ([129.143.2.15]:49261 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab1DOLew convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 07:34:52 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp2.belwue.de with ESMTP id p3FBNCLQ027158
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 13:23:12 +0200 (MEST)
	env-from (prvs=07949faaa=c.raible@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 72EA9AC002
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 13:23:11 +0200 (CEST)
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PEGc0Z0Rd3lh for <ceph-devel@vger.kernel.org>;
	Fri, 15 Apr 2011 13:23:10 +0200 (CEST)
Received: from nerva.science-computing.de (nerva.science-computing.de [10.10.16.94])
	by scmail.science-computing.de (Postfix) with ESMTP id D6447AC001
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 13:23:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nerva.science-computing.de (Postfix) with ESMTP id BC474A3423
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 13:23:10 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi @all

I compiled new kernel on CentOS 5.6 (kernel-ml-2.6.38-2) with CEPH support

     CONFIG_CEPH_LIB=y
     # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
     CONFIG_CEPH_FS=y


Now when I want to mount a Ceph filesystem with

     mount -t ceph 10.1.9.46:/ /mnt/ceph



I got following error:

     "mount.ceph: modprobe failed, exit status 127"


Have anyone an idea what I do wrong?

"dmesg | grep ceph"  sends following output:

     http://pastebin.com/rCzWdhVV



Regards,

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


