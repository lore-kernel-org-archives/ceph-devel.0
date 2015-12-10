From: Igor Fedotov <ifedotov@mirantis.com>
Subject: ceph-osd mem usage growth
Date: Thu, 10 Dec 2015 19:24:06 +0300
Message-ID: <5669A726.8080009@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34511 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbbLJQYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 11:24:09 -0500
Received: by lffu14 with SMTP id u14so60555577lff.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Dec 2015 08:24:08 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id b7sm2455369lbv.0.2015.12.10.08.24.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 08:24:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,

implementing compression support for EC pools I faced an issue that can 
be summarized as follows.

Imagine a client that continuously extends specific object xattr by 
doing complete attribute rewrite with new data portion appended.
As a result one can observe permanently increasing mem usage for 
ceph-osd processes. This happens for objects at EC pools only.

I briefly investigated for the root cause and it looks like that's due 
to PG log memory consumption growth. PG log entry count is pretty stable 
but each entry consumes more and more memory over the time since it 
contains full attribute value.
As far as I understand replicated pools do not log setattr operation ( 
actually mark it as unrollbackable ) that's why the issue isn't observed 
there.

With 3000 log entries and e.g. 64Kb attribute value memory consumption 
is pretty visible.

So the questions are:
* Are there any ideas how to resolve this issue? Obvious solution is to 
refactor attribute extending by using multiple keys...  Anything else?
* Does it make sense to resolve it at all?  IMO that's a sort of 
vulnerability for Ceph process to behave this way...

Please find a python script to reproduce the issue below, to be started 
from the folder where ceph.conf is located:

python repro.py <poolname>

######################################
import rados, sys
from time import sleep
import psutil

def print_process_mem_usage(pid):
   process = psutil.Process(pid)
   mem = process.get_memory_info()
   mem0=mem[0] / (2 ** 20)
   mem1=mem[1] / (2 ** 20)
   print "pid %d: Virt: %i MB, Res: %i MB" % (pid, mem1, mem0)

def print_processes_mem_usage():
   for proc in psutil.process_iter():
     try:
       if 'ceph-osd' in proc.name():
         print_process_mem_usage(proc.pid)
     except psutil.NoSuchProcess:
       pass

cluster = rados.Rados(conffile='./ceph.conf')

cluster.connect()

ioctx = cluster.open_ioctx(sys.argv[1])
try:
     ioctx.remove_object("pyobject")
except:
     pass
s=""
for i in range(25000):
     s=''.zfill( i*15)
     ioctx.set_xattr( 'pyobject', 'somekey', s)
     if (i % 500)==0:
         print '%d-th step, attr len = %d' % (i, len(s))
         print_processes_mem_usage()

ioctx.close()
#########################
Sample output is as below:
0-th step, attr len = 0
pid 23723: Virt: 700 MB, Res: 30 MB
pid 23922: Virt: 701 MB, Res: 32 MB
pid 24142: Virt: 700 MB, Res: 32 MB
...
4000-th step, attr len = 60000
pid 23723: Virt: 896 MB, Res: 207 MB
pid 23922: Virt: 900 MB, Res: 212 MB
pid 24142: Virt: 897 MB, Res: 210 MB
...
6000-th step, attr len = 90000
pid 23723: Virt: 1025 MB, Res: 331 MB
pid 23922: Virt: 1032 MB, Res: 338 MB
pid 24142: Virt: 1025 MB, Res: 333 MB
...


Thanks,
Igor
