From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 11:49:10 +0100
Message-ID: <50AF54A6.4040805@profihost.ag>
References: <c164551e-fb3d-4d4d-a750-33c032328fdb@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54957 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2KWKtU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 05:49:20 -0500
In-Reply-To: <c164551e-fb3d-4d4d-a750-33c032328fdb@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Am 23.11.2012 11:47, schrieb Alexandre DERUMIER:
>>> when i switch the journal to the OSD Disk seperate partiton on each disk
>>> (/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from 23.000
>>> iops to 200 iops random 4k.
> O_o , that's seem crazy...
> Are you sure that your partitions are correctly aligned ? (starting first partition at sector 2048 is best for ssd)

Model: ATA INTEL SSDSC2CW24 (scsi)
Disk /dev/sdb: 468862128s
Sector size (logical/physical): 512B/512B
Partition Table: gpt

Number  Start     End         Size        File system  Name  Flags
  1      2048s     2342911s    2340864s    xfs          pri
  2      2342912s  468860927s  466518016s  xfs          pri

Stefan
