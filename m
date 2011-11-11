From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: OSD hit suicide timeout
Date: Fri, 11 Nov 2011 19:53:57 +0100
Message-ID: <4EBD6F45.3090300@unilogicnetworks.net>
References: <CAO47_-_Rubnh9B_DGkUvO+DNn=1WHrZaeMK54fejYoJMHNFWew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpq1.gn.mail.iss.as9143.net ([212.54.34.164]:43191 "EHLO
	smtpq1.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738Ab1KKSyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Nov 2011 13:54:01 -0500
In-Reply-To: <CAO47_-_Rubnh9B_DGkUvO+DNn=1WHrZaeMK54fejYoJMHNFWew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hello Christian,

I have the same problem for some time now, but I'm in doubt if it's Ceph 
related. With my setup it looks like the IO stalls, ofcourse after some 
time the osd kills itself. Do you use BTRFS as local filesystem?

If so, do you get WARNING: at fs/btrfs/inode.c:2198 
btrfs_orphan_commit_root+0xa8/0xc0 messages in dmesg?

I also notice a slowdown after a few hours and then a complete stall of 
IO to the filesystem. With older versions of the osd they get in D state 
(ps/top), with newer versions the kill themselves. But if I logon to the 
osd (after they killed themselve) and go to the mounted filesystem I 
notice the filesystem is non-responsive (tried ls/dd).

Stefan

On 11/11/2011 05:20 PM, Christian Brunner wrote:
> I have upgraded to 0.38 today. After a few hours two of my OSDs
> crashed with "hit suicide timeout". After a restart, they are up
> again.
>
> I've seen this in prior versions, so I don't think it's related to the
> upgrade. I just wanted to report that it's still there.
>
> Here is what I've found in our syslog:
>
> Nov 11 17:05:59 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:05:59 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:05:59 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:04 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:04 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:04 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:09 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:09 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:09 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:14 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:14 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:14 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:19 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:19 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:19 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:24 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:24 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:24 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080fed4700' had timed out
> after 60
> Nov 11 17:06:29 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'OSD::op_tp thread 0x7f0809dc7700' had timed out after 30
> Nov 11 17:06:29 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had timed out
> after 60
> Nov 11 17:06:29 os03 osd.015[3641]: 7f0816ee2700 heartbeat_map
> is_healthy 'FileStore::op_tp thread 0x7f080f6d3700' had suicide timed
> out after 180
> Nov 11 17:06:29 os03 osd.015[3641]: common/HeartbeatMap.cc: In
> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
> const char*, time_t)', in thread
> '7f0816ee2700'#012common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit
> suicide timeout")
> Nov 11 17:06:29 os03 osd.015[3641]:  ceph version 0.38
> (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)#012 1:
> (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> long)+0x214) [0x5a7774]#012 2: (ceph::HeartbeatMap::is_healthy()+0x87)
> [0x5a7a97]#012 3: (ceph::HeartbeatMap::check_touch_file()+0x20)
> [0x5a7cc0]#012 4: (CephContextServiceThread::entry()+0x5f)
> [0x59ee3f]#012 5: (()+0x77e1) [0x7f0818a127e1]#012 6: (clone()+0x6d)
> [0x7f08171e177d]
> Nov 11 17:06:29 os03 osd.015[3641]:  ceph version 0.38
> (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)#012 1:
> (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> long)+0x214) [0x5a7774]#012 2: (ceph::HeartbeatMap::is_healthy()+0x87)
> [0x5a7a97]#012 3: (ceph::HeartbeatMap::check_touch_file()+0x20)
> [0x5a7cc0]#012 4: (CephContextServiceThread::entry()+0x5f)
> [0x59ee3f]#012 5: (()+0x77e1) [0x7f0818a127e1]#012 6: (clone()+0x6d)
> [0x7f08171e177d]
> Nov 11 17:06:29 os03 osd.015[3641]: *** Caught signal (Aborted) **#012
> in thread 7f0816ee2700
> Nov 11 17:06:29 os03 osd.015[3641]:  ceph version 0.38
> (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)#012 1:
> /usr/bin/ceph-osd() [0x59e2a4]#012 2: (()+0xf490) [0x7f0818a1a490]#012
> 3: (gsignal()+0x35) [0x7f081712e905]#012 4: (abort()+0x175)
> [0x7f08171300e5]#012 5:
> (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7f08179e3a7d]#012
> 6: (()+0xbcc06) [0x7f08179e1c06]#012 7: (()+0xbcc33)
> [0x7f08179e1c33]#012 8: (()+0xbcd2e) [0x7f08179e1d2e]#012 9:
> (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x39f) [0x5a05ef]#012 10:
> (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> long)+0x214) [0x5a7774]#012 11:
> (ceph::HeartbeatMap::is_healthy()+0x87) [0x5a7a97]#012 12:
> (ceph::HeartbeatMap::check_touch_file()+0x20) [0x5a7cc0]#012 13:
> (CephContextServiceThread::entry()+0x5f) [0x59ee3f]#012 14:
> (()+0x77e1) [0x7f0818a127e1]#012 15: (clone()+0x6d) [0x7f08171e177d]
>
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

