From: Nathan Cutler <ncutler@suse.cz>
Subject: Client test suite
Date: Sat, 18 Feb 2017 22:29:27 +0100
Message-ID: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44193 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753315AbdBRV3a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 18 Feb 2017 16:29:30 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CFC4AB5D
        for <ceph-devel@vger.kernel.org>; Sat, 18 Feb 2017 21:29:28 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm preparing the beginnings of a sketch of a possible design for a Ceph 
client integration test suite.

The need for a way to test different versions/platforms/architectures of 
clients against different versions/platforms/architectures of server is, 
I think, obvious.

Such a client test suite could be run by teuthology within a 
conventional teuthology cluster like Sepia, but it would also need to be 
runnable outside of a such an environment. (For example, think of how 
one would test an aarch64 client against a Ceph cluster running on 
x86_64, or vice versa.)

This got me thinking about how teuthology could be leveraged to 
implement a client integration test suite.

First, the test suite itself could (optionally) take a set of monitor 
hostnames/IP addresses and a cephx key as an input, so it could (again, 
optionally) run against a Ceph cluster running outside of teuthology.

Second, teuthology could be modified to allow it to run a test suite on 
a single machine by creating VMs (libvirt) or containers for the tests, 
and running the tests in series instead of in parallel.

Any thoughts on this?

Nathan
