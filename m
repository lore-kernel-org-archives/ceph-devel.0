From: Sage Weil <sage@inktank.com>
Subject: Re: ceph osd crush set command under 0.53
Date: Mon, 12 Nov 2012 16:34:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211121633020.26823@cobra.newdream.net>
References: <CA+jddaPtzT0OenHxOGa1ZxTsAtzkeSxX=wbicdB07S97pyP5Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41039 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2KMAe4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 19:34:56 -0500
In-Reply-To: <CA+jddaPtzT0OenHxOGa1ZxTsAtzkeSxX=wbicdB07S97pyP5Gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org, eng@pistoncloud.com

On Mon, 12 Nov 2012, Mandell Degerness wrote:
> Did the syntax and behavior of the "ceph osd crush set ..." command
> change between 0.48 and 0.53?
> 
> When trying out ceph 0.53, I get the following in my log when trying
> to add the first OSD to a new cluster (similar behavior for osds 2 and
> 3).  It appears that the ceph osd crush command fails, but still marks
> the OSDs as up and in:

The 'pool=default' is changed to 'root=default', as in the root of the 
crush hierarchy.  'pool' was confusing because there are also rados pools, 
which are something else entirely.

(You can also omit the first '0' (i.e., just 'osd.123' and not [..., 
'123', 'osd.123', ...]), but both the old and new syntax are supported.)

sage


> 
> Nov 12 23:19:05 node-172-20-0-13/172.20.0.13 [2012-11-12 23:19:05.759]
> 908/MainThread savage/INFO: execute(['ceph', 'osd', 'crush', 'set',
> '0', 'osd.0', '1.0', 'host=172.20.0.13', 'rack=0', 'pool=default'])
> Nov 12 23:19:05 node-172-20-0-14/172.20.0.14 ceph-mon: 2012-11-12
> 23:19:05.804080 7ffd761fe700  0 mon.1@1(peon) e1 handle_command
> mon_command(osd crush set 0 osd.0 1.0 host=172.20.0.13 rack=0
> pool=default v 0) v1
> Nov 12 23:19:05 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:05.772215 7fad40911700  0 mon.0@0(leader) e1 handle_command
> mon_command(osd crush set 0 osd.0 1.0 host=172.20.0.13 rack=0
> pool=default v 0) v1
> Nov 12 23:19:05 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:05.772248 7fad40911700  0 mon.0@0(leader).osd e2 adding/updating
> crush item id 0 name 'osd.0' weight 1 at location
> {host=172.20.0.13,pool=default,rack=0}
> Nov 12 23:19:05 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:05.772323 7fad40911700  1 error: didn't find anywhere to add
> item 0 in {host=172.20.0.13,pool=default,rack=0}
> Nov 12 23:19:05 node-172-20-0-13/172.20.0.13 [2012-11-12 23:19:05.783]
> 908/MainThread savage/CRITICAL: Logging uncaught exception Traceback
> (most recent call last):   File "/usr/bin/sv-fred.py", line 9, in
> <module>     load_entry_point('savage==9999.2101.118c3ebc8c0843f87e82eb047de043c8a70086bd',
> 'console_scripts', 'sv-fred.py')()   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 811, in main   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 798, in run   File
> "/usr/lib64/python2.6/site-packages/savage/utils/nfa.py", line 291, in
> step   File "/usr/lib64/python2.6/site-packages/savage/utils/nfa.py",
> line 252, in step   File
> "/usr/lib64/python2.6/site-packages/savage/utils/nfa.py", line 231, in
> _newstate   File
> "/usr/lib64/python2.6/site-packages/savage/utils/nfa.py", line 219, in
> _newstate   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 563, in action_firstboot_full   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 768, in handle_message   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 750, in start_phase   File
> "/usr/lib64/python2.6/site-packages/savage/services/fred.py", line
> 164, in start   File
> "/usr/lib64/python2.6/site-packages/savage/utils/__init__.py", line
> 275, in _wrap   File
> "/usr/lib64/python2.6/site-packages/savage/command/commands/ceph.py",
> line 50, in crush_myself   File
> "/usr/lib64/python2.6/site-packages/savage/utils/__init__.py", line
> 244, in execute   File
> "/usr/lib64/python2.6/site-packages/savage/utils/__init__.py", line
> 130, in collect_subprocess ExecutionError: Command failed: ceph osd
> crush set 0 osd.0 1.0 host=172.20.0.13 rack=0 pool=default
> return_code: 1 stdout: (22) Invalid argument stderr:
> Nov 12 23:19:06 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:06.491514 7fad40911700  1 mon.0@0(leader).osd e3 e3: 3 osds: 1
> up, 1 in
> Nov 12 23:19:06 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:06.494461 7fad40911700  0 log [INF] : osdmap e3: 3 osds: 1 up, 1
> in
> Nov 12 23:19:06 node-172-20-0-13/172.20.0.13 ceph-mon: 2012-11-12
> 23:19:06.494463 mon.0 172.20.0.13:6789/0 16 : [INF] osdmap e3: 3 osds:
> 1 up, 1 in
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
