From: Dan Mick <dan.mick@inktank.com>
Subject: Ceph developers, please note: changes to 'ceph' CLI tool in master
 branch
Date: Wed, 12 Jun 2013 14:20:48 -0700
Message-ID: <51B8E630.4060709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35748 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab3FLVUv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 17:20:51 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4411116pdi.41
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 14:20:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-users <ceph-users@lists.ceph.com>

A large restructuring of the 'ceph' command-line tool has been pushed to 
the master branch (and will be present in v0.65 as well).  The ceph tool 
you execute is now a Python script that talks to the cluster through 
rados.py, the Python binding to librados.so (and, of course, then, with 
librados.so).

Those who install/upgrade using packages will get the coordinated 
versions of all the pieces, and can stop reading except as a matter of 
interest.

However, those who build from source will need to be aware that 
PYTHONPATH must include the source versions of src/pybind/rados.py, and 
LD_LIBRARY_PATH must include .libs.  Currently, you must set these in 
your environment before running ./ceph.

I've just pushed a commit that will try to automatically determine this 
situation: if the path to the ceph tool ends in src/, and there exist 
.libs and pybind directories there, the tool will reset LD_LIBRARY_PATH 
and PYTHONPATH and re-exec itself so that LD_LIBRARY_PATH takes effect.
It also issues a message to stderr noting this "developer mode":

*** DEVELOPER MODE: setting PYTHONPATH and LD_LIBRARY_PATH

This latest convenience feature for developers is in
commit e5184ea95031b7bea4264062de083045767d5dc3 in master.

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
