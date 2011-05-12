From: Fyodor Ustinov <ufm@ufm.su>
Subject: rbd
Date: Thu, 12 May 2011 13:53:44 +0300
Message-ID: <201105121353.44166.ufm@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:33208 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab1ELKxq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2011 06:53:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id D0CFE60059D
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 13:53:44 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BM+dR52Rjv50 for <ceph-devel@vger.kernel.org>;
	Thu, 12 May 2011 13:53:44 +0300 (EEST)
Received: from amd.localnet (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id B05EB60059C
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 13:53:44 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Latest (git pulled) version of 2.6 kernel. Ceph - 0.27.1

Still troubles with rbd. Now with ocfs2 no messages in syslog, but iozone 
still return error:

#df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1             237G   15G  210G   7% /
none                  2.0G  164K  2.0G   1% /dev
none                  2.0G     0  2.0G   0% /dev/shm
none                  2.0G   52K  2.0G   1% /var/run
none                  2.0G     0  2.0G   0% /var/lock
/dev/rbd0            1000G  3.2G  997G   1% /mnt

# cd /mnt/
root@stb1:/mnt# ls
lost+found
root@stb1:/mnt# iozone -a -n4g -g20g
        Iozone: Performance Test of File I/O
                Version $Revision: 3.373 $
                Compiled for 64 bit mode.
                Build: linux-AMD64

[...]

        Run began: Thu May 12 13:42:45 2011

        Auto Mode
        Using minimum file size of 4194304 kilobytes.
        Using maximum file size of 20971520 kilobytes.
        Command line used: iozone -a -n4g -g20g
        Output is in Kbytes/sec
        Time Resolution = 0.000001 seconds.
        Processor cache size set to 1024 Kbytes.
        Processor cache line size set to 32 bytes.
        File stride size set to 17 * record size.
                                                            random  random    
bkwd   record   stride
              KB  reclen   write rewrite    read    reread    read   write    
read  rewrite     read   fwrite frewrite   fread  freread
         4194304      64  146906  150779

Error in file: Found ?7f24fb70a210? Expecting ?3a3a3a3a3a3a3a3a? addr 
7fe5b720e000
Error in file: Position 2481971200
Record # 37871 Record size 64 kb
where 7fe5b720e000 loop 57344
root@stb1:/mnt#           

Can I help to catch this error?

WBR,
    Fyodor.
