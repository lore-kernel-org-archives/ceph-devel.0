From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: [GSoC2016] BlueStore SMR Support
Date: Fri, 4 Mar 2016 15:06:17 -0500
Message-ID: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36426 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182AbcCDUGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 15:06:23 -0500
Received: by mail-yk0-f169.google.com with SMTP id 1so27399821ykg.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 12:06:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@redhat.com

Hi All,

I am a 1st Year PhD student at University of Toronto. I am interested
in working on the SMR friendly allocator for Bluestore file system. I
am new to Ceph. But I am familiar with FS development in user space, and
SMR drives. I am currently going through Ceph codebase.
It looks like the allocator is very basic, hence the current name of
the block allocator:
os/bluestore/StupidAllocator.cc :-)

Few initial questions:

1) Will the project involve Drive managed SMR drives or Host Managed SMR drives?

2) Will scope of project be to build an allocator on a simulator for
SMR Drives? Or will I get actual HDDs to work with? In case of
simulators, will the project involve building a simulator on disksim?

3) Ideally, the benchmark should be to compare StupidAllocator scheme
with a SmartAllocator scheme in terms of the following performance
metrics:
a) speed
b) correctness
c) fragmentation
d) garbage collection efficiency

are there any other metrics that we would like to measure the allocator for?

Thanks and I look forward to working on this project. Please feel free
to send out your comments/suggestions.

Regards,

-- 
Shehbaz Jaffer
First Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineering
University of Toronto
