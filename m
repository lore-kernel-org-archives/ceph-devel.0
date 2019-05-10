From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RFC: relicence Ceph LGPL-2.1 code as LGPL-2.1 or
 LGPL-3.0
Date: Fri, 10 May 2019 14:27:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1904221623540.7135@piezo.novalocal>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

-- What --

The Ceph Leadership Team[1] is proposing a change of license from 
*LGPL-2.1* to *LGPL-2.1 or LGPL-3.0* (dual license). The specific changes 
are described by this pull request:

	https://github.com/ceph/ceph/pull/22446

If you are a Ceph developer who has contributed code to Ceph and object to 
this change of license, please let us know, either by replying to this 
message or by commenting on that pull request.

Our plan is to leave the issue open for comment for some period of time 
and, if no objections are raised that cannot be adequately addressed (via 
persuasion, code replacement, or whatever) we will move forward with the 
change.


-- Why --

The primary motivation to relicense is a desire to integrate with projects 
that are licensed under the Apache License version 2.0. Although opinions 
vary, there are some who argue the the LGPL-2.1 and Apache-2.0 licenses 
are not fully compatible. We would like to avoid the ambiguity and 
potential for controversy.

Projects we would like to consume that are Apache-2.0 licensed include 
RocksDB, Seastar, OpenSSL (which is in the process of relicensing to 
Apache-2.0), and Swagger (swagger.io). Note that some of these are (or 
could be) dynamically linked or are consumed via a high-level language, 
and may or may not require a change to LGPL-3.0, but providing the option 
for LGPL-3.0 will avoid any uncertainty.

A few other source files are already incorporated into Ceph that claim an 
Apache-2.0 license:

   src/common/deleter.h
   src/common/sstring.h
   src/include/cpp-btree

The Ceph developers would further like to provide a license option that is 
more modern than the current LGPL-2.1. LGPL-3.0 includes updated, 
clarified language around several issues and is widely considered more 
modern, superior license.

Thank you!


[1] http://docs.ceph.com/docs/master/governance/#ceph-leadership-team
