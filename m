From: Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
Subject: large memory leak on scrubbing
Date: Fri, 16 Aug 2013 15:11:30 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: pl-PL
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: =?iso-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, Sydor Bohdan <Bohdan.Sydor-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
We noticed some issues on CEPH/S3 cluster, I think it related with scrubbing: large memory leaks.

Logs 09.xx: https://www.dropbox.com/s/4z1fzg239j43igs/ceph-osd.4.log_09xx.tar.gz
From 09.30 to 09.44 (14 minutes) osd.4 proces grows up to 28G. 

I think this is something curious:
2013-08-16 09:43:48.801331 7f6570d2e700  0 log [WRN] : slow request 32.794125 seconds old, received at 2013-08-16 09:43:16.007104: osd_sub_op(unknown.0.0:0 16.113d 0//0//-1 [scrub-reserve] v 0'0 snapset=0=[]:[] snapc=0=[]) v7 currently no flag points reached

We have large rgw index and a lot of large files than on this cluster.
ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
Setup: 
- 12 servers x 12 OSD 
- 3 mons
Default scrubbing settings.
Journal and filestore settings:
        journal aio = true
        filestore flush min = 0
        filestore flusher = false
        filestore fiemap = false
        filestore op threads = 4
        filestore queue max ops = 4096
        filestore queue max bytes = 10485760
        filestore queue committing max bytes = 10485760
        journal max write bytes = 10485760
        journal queue max bytes = 10485760
        ms dispatch throttle bytes = 10485760
        objecter infilght op bytes = 10485760

Is this a known bug in this version?
(Do you know some workaround to fix this?)

---
Regards
Dominik
