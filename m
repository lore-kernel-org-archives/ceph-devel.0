From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: /etc/init.d/ceph bug  for multi-host when using -a option
Date: Wed, 23 Jan 2013 07:18:35 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC5E5A56@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11612 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab3AWHSj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 02:18:39 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "sage@inktank.com" <sage@inktank.com>

Hi List,
     Here is part of /etc/init.d/ceph script:
case "$command" in
        start)
            # Increase max_open_files, if the configuration calls for it.
            get_conf max_open_files "8192" "max open files"
            if [ $max_open_files != "0" ]; then
                # Note: Don't try to do math with these numbers, because POSIX shells
                # can't do 64-bit math (natively). Just treat them as strings.
                cur=`ulimit -n`
                if [ "x$max_open_files" != "x$cur" ]; then
Line253:                  ulimit -n $max_open_files    
                fi
            fi

      When using with -a option, for **remote** osd , this script also run ulimit on **local**, and results in ulimit -n didn't change in remote nodes. I think the Line 253 shoud use do_cmd instead of run directly,also line 251.

Here is the output of local osd daemon's limits:
root@ceph-4:~# cat /proc/13131/limits  | grep file
Max file size             unlimited            unlimited            bytes     
Max core file size        unlimited            unlimited            bytes     
Max open files            131072               131072               files     
Max file locks            unlimited            unlimited            locks     

Here is a remote one:
root@snb-15:~# cat /proc/23709/limits | grep file
Max file size             unlimited            unlimited            bytes     
Max core file size        unlimited            unlimited            bytes     
Max open files            1024                 4096             files     
Max file locks            unlimited            unlimited            locks     

																																					Xiaoxi
