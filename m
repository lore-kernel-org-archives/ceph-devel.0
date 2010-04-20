From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: Problem with Ceph installation inside Amazon EC2
Date: Tue, 20 Apr 2010 18:13:36 +0200
Message-ID: <201004201813.36253.cray@unix-ag.uni-kl.de>
References: <1271773294.1905.75.camel@wido-desktop> <201004201718.35784.cray@unix-ag.uni-kl.de> <1271778117.1905.81.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:38375 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0DTQN4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Apr 2010 12:13:56 -0400
In-Reply-To: <1271778117.1905.81.camel@wido-desktop>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wido@pcextreme.nl
Cc: ceph-devel@vger.kernel.org

Hi,

I think it is working now.

I had to do these steps:
cp src/init-ceph /etc/init.d/ceph
chmod a+x /etc/init.d/ceph
chmod u+w /etc/init.d/ceph
/etc/init.d/ceph -c /etc/ceph/ceph.conf start

Now, the server processes are running

# ps -aux | grep ceph
Warning: bad ps syntax, perhaps a bogus '-'? See http://procps.sf.net/faq.html
root      1948  0.0  0.0      0     0 ?        S    11:28   0:00 [ceph-msgr/0]
root      1949  0.0  0.0      0     0 ?        S    11:28   0:00 [ceph-msgr/1]
root     12467  0.0  0.0 179812  3452 ?        Ssl  15:58   0:00 /usr/local/bin/cmon -i 0 -c /etc/ceph/ceph.conf
root     12495  0.0  0.0 189532  3792 ?        Ssl  15:58   0:00 /usr/local/bin/cmds -i 0 -c /etc/ceph/ceph.conf
root     12545  0.0  0.2 247480 21676 ?        Ssl  15:58   0:00 /usr/local/bin/cosd -i 1 -c /etc/ceph/ceph.conf
root     12597  0.0  0.0   7616   920 pts/1    R+   16:01   0:00 grep --color=auto ceph

The mount command at the client machine was successful too:

# mount | grep ceph
10.194.145.203:/ on /mnt/ceph type ceph (rw)



A small performance test inside EC2:

I created 2 Instances. 1 Instance has an EBS-Volume attached. The EBS-Volume is the storage for the Ceoh. Both instances (m1.large) are inside EC2 us-east-1d.

Create testdata

# dd if=/dev/zero of=/tmp/testfile bs=1024 count=1000000
1000000+0 records in
1000000+0 records out
1024000000 bytes (1.0 GB) copied, 7.24084 s, 141 MB/s

# cat test.bat 
cp /tmp/testfile /mnt/ceph
sync

Copy the testdata from the client to the server:

# time ./test.bat 
real	0m29.211s
user	0m0.020s
sys	0m1.490s

Thanks a lot for the help.

Best Regards,
   Christian 


Am Dienstag, 20. April 2010 schrieb Wido den Hollander:
> Hi,
> 
> Do you have the following processes running?
> 
> - cmon
> - cmds
> - cosd
> 
> And you are trying to mount the Ceph filesystem which is running local
> isn't it?
> 
> I also experienced some troubles with mounting a local Ceph filesystem,
> so i switched to a dedicated client.
> 


