From: =?UTF-8?B?bGluIHpob3Ug5ZGo5p6X?= <hnuzhoulin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: after a reboot,
	osd can not up because of leveldb Corruption
Date: Sat, 10 Oct 2015 12:05:44 +0800
Message-ID: <CANxbt0QJFryEOvm=BcRhPmwa3mvrnDKYs-RkAntUJsaNXbU_Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

hi,guys

the mon and osds in one of a node in our ceph cluster can not up now
because of leveldb.

ceph 0.80.7  ubuntu12.04

osd log is:
------------------------------------------------------

2015-10-10 11:12:58.896724 7f4cfcf9d7c0 -1 ESC[0;31m ** ERROR: error
converting store /var/lib/ceph/osd/ceph-3: (1) Operation not
permittedESC[0m
2015-10-10 11:12:59.090344 7f7f29eb47c0  0 ceph version 0.80.7
(6c0127fcb58008793d3c8b62d925bc91963672a3), process ceph-osd, pid
14134
2015-10-10 11:12:59.091039 7f7f29eb47c0 10 -- :/0 rank.bind 10.1.41.203:0/0
2015-10-10 11:12:59.091048 7f7f29eb47c0 10 accepter.accepter.bind
2015-10-10 11:12:59.091061 7f7f29eb47c0 10 accepter.accepter.bind
bound on random port 10.1.41.203:6800/0
2015-10-10 11:12:59.091066 7f7f29eb47c0 10 accepter.accepter.bind
bound to 10.1.41.203:6800/0
2015-10-10 11:12:59.091073 7f7f29eb47c0  1 -- 10.1.41.203:0/0 learned
my addr 10.1.41.203:0/0
2015-10-10 11:12:59.091076 7f7f29eb47c0  1 accepter.accepter.bind
my_inst.addr is 10.1.41.203:6800/14134 need_addr=0
2015-10-10 11:12:59.091081 7f7f29eb47c0 10 -- :/0 rank.bind 192.168.20.5:0/0
2015-10-10 11:12:59.091083 7f7f29eb47c0 10 accepter.accepter.bind
2015-10-10 11:12:59.091088 7f7f29eb47c0 10 accepter.accepter.bind
bound on random port 192.168.20.5:6800/0
2015-10-10 11:12:59.091091 7f7f29eb47c0 10 accepter.accepter.bind
bound to 192.168.20.5:6800/0
2015-10-10 11:12:59.091095 7f7f29eb47c0  1 -- 192.168.20.5:0/0 learned
my addr 192.168.20.5:0/0
2015-10-10 11:12:59.091098 7f7f29eb47c0  1 accepter.accepter.bind
my_inst.addr is 192.168.20.5:6800/14134 need_addr=0
2015-10-10 11:12:59.091100 7f7f29eb47c0 10 -- :/0 rank.bind 192.168.20.5:0/0
2015-10-10 11:12:59.091102 7f7f29eb47c0 10 accepter.accepter.bind
2015-10-10 11:12:59.091107 7f7f29eb47c0 10 accepter.accepter.bind
bound on random port 192.168.20.5:6801/0
2015-10-10 11:12:59.091109 7f7f29eb47c0 10 accepter.accepter.bind
bound to 192.168.20.5:6801/0
2015-10-10 11:12:59.091113 7f7f29eb47c0  1 -- 192.168.20.5:0/0 learned
my addr 192.168.20.5:0/0
2015-10-10 11:12:59.091116 7f7f29eb47c0  1 accepter.accepter.bind
my_inst.addr is 192.168.20.5:6801/14134 need_addr=0
2015-10-10 11:12:59.091118 7f7f29eb47c0 10 -- :/0 rank.bind 10.1.41.203:0/0
2015-10-10 11:12:59.091119 7f7f29eb47c0 10 accepter.accepter.bind
2015-10-10 11:12:59.091124 7f7f29eb47c0 10 accepter.accepter.bind
bound on random port 10.1.41.203:6801/0
2015-10-10 11:12:59.091126 7f7f29eb47c0 10 accepter.accepter.bind
bound to 10.1.41.203:6801/0
2015-10-10 11:12:59.091132 7f7f29eb47c0  1 -- 10.1.41.203:0/0 learned
my addr 10.1.41.203:0/0
2015-10-10 11:12:59.091134 7f7f29eb47c0  1 accepter.accepter.bind
my_inst.addr is 10.1.41.203:6801/14134 need_addr=0
2015-10-10 11:12:59.091137 7f7f29eb47c0 10 -- :/0 rank.bind 10.1.41.203:0/0
2015-10-10 11:12:59.091138 7f7f29eb47c0 10 accepter.accepter.bind
2015-10-10 11:12:59.091143 7f7f29eb47c0 10 accepter.accepter.bind
bound on random port 10.1.41.203:6802/0
2015-10-10 11:12:59.091145 7f7f29eb47c0 10 accepter.accepter.bind
bound to 10.1.41.203:6802/0
2015-10-10 11:12:59.091150 7f7f29eb47c0  1 -- 10.1.41.203:0/0 learned
my addr 10.1.41.203:0/0
2015-10-10 11:12:59.091153 7f7f29eb47c0  1 accepter.accepter.bind
my_inst.addr is 10.1.41.203:6802/14134 need_addr=0
2015-10-10 11:12:59.092322 7f7f29eb47c0  0
filestore(/var/lib/ceph/osd/ceph-3) mount detected xfs (libxfs)
2015-10-10 11:12:59.092327 7f7f29eb47c0  1
filestore(/var/lib/ceph/osd/ceph-3)  disabling 'filestore replica
fadvise' due to known issues with fadvise(DONTNEED) on xfs
2015-10-10 11:12:59.094728 7f7f29eb47c0  0
genericfilestorebackend(/var/lib/ceph/osd/ceph-3) detect_features:
FIEMAP ioctl is supported and appears to work
2015-10-10 11:12:59.095142 7f7f29eb47c0  0
genericfilestorebackend(/var/lib/ceph/osd/ceph-3) detect_features:
syncfs(2) syscall fully supported (by glibc and kernel)
2015-10-10 11:12:59.095181 7f7f29eb47c0  0
xfsfilestorebackend(/var/lib/ceph/osd/ceph-3) detect_feature: extsize
is disabled by conf
2015-10-10 11:12:59.098529 7f7f29eb47c0 -1
filestore(/var/lib/ceph/osd/ceph-3) Error initializing leveldb:
Corruption: 16 missing files; e.g.:
/var/lib/ceph/osd/ceph-3/current/omap/078957.sst

----------------------------------------------
mon log is :
===================================
2015-10-10 10:38:47.325121 7f4947e677c0  0 ceph version 0.80.7
(6c0127fcb58008793d3c8b62d925bc91963672a3), process ceph-mon, pid
35589
2015-10-10 10:38:47.326558 7f4947e677c0 10
ErasureCodePluginSelectJerasure: SSE4 plugin
2015-10-10 10:38:47.330133 7f4947e677c0 10 ErasureCodeJerasure:
technique=reed_sol_van
2015-10-10 10:38:47.330143 7f4947e677c0 10 ErasureCodeJerasure: k defaults to 7
2015-10-10 10:38:47.330148 7f4947e677c0 10 ErasureCodeJerasure: m defaults to 3
2015-10-10 10:38:47.330149 7f4947e677c0 10 ErasureCodeJerasure: w defaults to 8
2015-10-10 10:38:47.330162 7f4947e677c0 10 load: jerasure
2015-10-10 10:38:47.435134 7f4947e677c0 -1 failed to create new leveldb store
=============================

now I recreate this mon using ceph-deploy,adn it work well now.

But I do not want to recreate osd until this absolutely can not be repaired.
