From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Remote Ceph Install
Date: Mon, 19 Nov 2012 19:47:15 -0800
Message-ID: <50AAFD43.7000203@inktank.com>
References: <A2F373745D229246AD96986D5DDC5D3B4F970796@MLBMXUS22.cs.myharris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35749 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2KTDrS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 22:47:18 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3949838pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 19:47:18 -0800 (PST)
In-Reply-To: <A2F373745D229246AD96986D5DDC5D3B4F970796@MLBMXUS22.cs.myharris.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blackwell, Edward" <eblack04@harris.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 11/19/2012 11:42 AM, Blackwell, Edward wrote:
> Hi,
> I work for Harris Corporation, and we are investigating Ceph as a potential solution to a storage problem that one of our government customers is currently having.  I've already created a two-node cluster on a couple of VMs with another VM acting as an administrative client.  The cluster was created using some installation instructions supplied to us via Inktank, and through the use of the ceph-deploy script.  Aside from a couple of quirky discrepancies between the installation instructions and my environment, everything went well.  My issue has cropped up on the second cluster I'm trying to create, which is using a VM and a non-VM server for the nodes in the cluster.  Eventually, both nodes in this cluster will be non-VMs, but we're still waiting on the hardware for the second node, so 
 I'm using a VM in the meantime just to get this second cluster up and going.  Of course, the administrative client node is still a VM.

Hi Ed.  Welcome.

> The problem that I'm having with this second cluster concerns the non-VM server (elsceph01 for the sake of the commands mentioned from here on out).  In particular, the issue crops up with the ceph-deploy install elsceph01 command I'm executing on my client VM (cephclient01) to install Ceph on the non-VM server. The installation doesn't appear to be working as the command does not return the OK message that it should when it completes successfully.  I've tried using the verbose option on the command to see if that sheds any light on the subject, but alas, it does not:
>
>
> root@cephclient01:~/my-admin-sandbox# ceph-deploy -v install elsceph01
> DEBUG:ceph_deploy.install:Installing stable version argonaut on cluster ceph hosts elsceph01
> DEBUG:ceph_deploy.install:Detecting platform for host elsceph01 ...
> DEBUG:ceph_deploy.install:Installing for Ubuntu 12.04 on host elsceph01 ...
> root@cephclient01:~/my-admin-sandbox#
>
>
> Would you happen to have a breakdown of the commands being executed by the ceph-deploy script behind the scenes so I can maybe execute them one-by-one to see where the error is?  I have confirmed that it looks like the installation of the software has succeeded as I did a which ceph command on elsceph01, and it reported back /usr/bin/ceph.  Also, /etc/ceph/ceph.conf is there, and it matches the file created by the ceph-deploy new ... command on the client.  Does the install command do a mkcephfs behind the scenes?  The reason I ask is that when I do the ceph-deploy mon command from the client, which is the next command listed in the instructions to do, I get this output:

Basically install just runs the appropriate debian package commands to 
get the requested release of Ceph installed on the target host (in this 
case, defaulting to argonaut).  The command normally doesn't issue any 
output.

> root@cephclient01:~/my-admin-sandbox# ceph-deploy mon
> creating /var/lib/ceph/tmp/ceph-ELSCEPH01.mon.keyring

This looks like there may be confusion about case in the hostname.  What 
does "hostname" on elsceph01 report?  If it's ELSCEPH01, that's probably 
the problem; the pathnames etc. are all case-sensitive.
Could be that /etc/hosts has the wrong case, or both cases, of the 
hostname in it?

> 2012-11-15 11:35:38.954261 7f7a6c274780 -1 asok(0x260b000) AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain socket to '/var/run/ceph/ceph-mon.ELSCEPH01.asok': (2) No such file or directory
> Traceback (most recent call last):
>    File "/usr/local/bin/ceph-deploy", line 9, in <module>
>      load_entry_point('ceph-deploy==0.0.1', 'console_scripts', 'ceph-deploy')()
>    File "/root/ceph-deploy/ceph_deploy/cli.py", line 80, in main
> added entity mon. auth auth(auid = 18446744073709551615 key=AQBWDj5QAP6LHhAAskVBnUkYHJ7eYREmKo5qKA== with 0 caps)
>      return args.func(args)
> mon/MonMap.h: In function 'void MonMap::add(const string&, const entity_addr_t&)' thread 7f7a6c274780 time 2012-11-15 11:35:38.955024
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 3: (main()+0x12bb) [0x45ffab]
> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 5: ceph-mon() [0x462a19]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> 2012-11-15 11:35:38.955924 7f7a6c274780 -1 mon/MonMap.h: In function 'void MonMap::add(const string&, const entity_addr_t&)' thread 7f7a6c274780 time 2012-11-15 11:35:38.955024
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
>
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 3: (main()+0x12bb) [0x45ffab]
> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 5: ceph-mon() [0x462a19]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>      -1> 2012-11-15 11:35:38.954261 7f7a6c274780 -1 asok(0x260b000) AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain socket to '/var/run/ceph/ceph-mon.ELSCEPH01.asok': (2) No such file or directory
>       0> 2012-11-15 11:35:38.955924 7f7a6c274780 -1 mon/MonMap.h: In function 'void MonMap::add(const string&, const entity_addr_t&)' thread 7f7a6c274780 time 2012-11-15 11:35:38.955024
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
>
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 3: (main()+0x12bb) [0x45ffab]
> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 5: ceph-mon() [0x462a19]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> *** Caught signal (Aborted) **
> in thread 7f7a6c274780
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: ceph-mon() [0x52569a]
> 2: (()+0xfcb0) [0x7f7a6b910cb0]
> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d]
> 6: (()+0xb5846) [0x7f7a6b03c846]
> 7: (()+0xb5873) [0x7f7a6b03c873]
> 8: (()+0xb596e) [0x7f7a6b03c96e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x5deb9e]
> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 12: (main()+0x12bb) [0x45ffab]
> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 14: ceph-mon() [0x462a19]
> 2012-11-15 11:35:38.957723 7f7a6c274780 -1 *** Caught signal (Aborted) **
> in thread 7f7a6c274780
>
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: ceph-mon() [0x52569a]
> 2: (()+0xfcb0) [0x7f7a6b910cb0]
> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d]
> 6: (()+0xb5846) [0x7f7a6b03c846]
> 7: (()+0xb5873) [0x7f7a6b03c873]
> 8: (()+0xb596e) [0x7f7a6b03c96e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x5deb9e]
> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 12: (main()+0x12bb) [0x45ffab]
> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 14: ceph-mon() [0x462a19]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>       0> 2012-11-15 11:35:38.957723 7f7a6c274780 -1 *** Caught signal (Aborted) **
> in thread 7f7a6c274780
>
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
> 1: ceph-mon() [0x52569a]
> 2: (()+0xfcb0) [0x7f7a6b910cb0]
> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d]
> 6: (()+0xb5846) [0x7f7a6b03c846]
> 7: (()+0xb5873) [0x7f7a6b03c873]
> 8: (()+0xb596e) [0x7f7a6b03c96e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x5deb9e]
> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) [0x5988b8]
> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59bd53]
> 12: (main()+0x12bb) [0x45ffab]
> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
> 14: ceph-mon() [0x462a19]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>    File "/root/ceph-deploy/ceph_deploy/mon.py", line 125, in mon
>      get_monitor_secret=get_monitor_secret,
>    File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-packages/pushy-0.5.1-py2.7.egg/pushy/protocol/proxy.py", line 255, in <lambda>
>      (conn.operator(type_, self, args, kwargs))
>    File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-packages/pushy-0.5.1-py2.7.egg/pushy/protocol/connection.py", line 66, in operator
>      return self.send_request(type_, (object, args, kwargs))
>    File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-packages/pushy-0.5.1-py2.7.egg/pushy/protocol/baseconnection.py", line 323, in send_request
>      return self.__handle(m)
>    File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-packages/pushy-0.5.1-py2.7.egg/pushy/protocol/baseconnection.py", line 639, in __handle
>      raise e
> pushy.protocol.proxy.ExceptionProxy: Command '['ceph-mon', '--cluster', 'ceph', '--mkfs', '-i', 'ELSCEPH01', '--keyring', '/var/lib/ceph/tmp/ceph-ELSCEPH01.mon.keyring']' returned non-zero exit status -6
>
>
> Which seems to indicate that the creation of the admin socket on the elsceph01 server didn't work.  I've verified that the /var/run/ceph/ceph-mon.ELSCEPH01.asok file does not exist on the elsceph01 server.  Any help on this issue would be greatly appreciated.
>
> On a side note, I think the ceph-deploy command's verbose setting might be a little more helpful if it is a little more clear on the commands that are being executed for the installation of the software on the remote server, and their results.  Also, it might be a good idea to alter the exit status of the ceph-deploy command when an error occurs to a number that can be looked up in a map which indicates what went wrong.  This way even the non-verbose use of the command could still be helpful in figuring out what went wrong if something did go wrong.  Right now, ceph-deploy returns 0 for my failed installation.  It'd be really cool if it returned something like 14, which could be traced back to something like, mkcephfs failed on the remote server.  It's just a thought.
>
> Thanks,
>
> Todd
>
> Todd Blackwell
> HARRIS Corporation
> Work: 321-984-6911
> Cell: 954-817-3662
> eblack04@harris.com
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
