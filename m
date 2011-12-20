From: Mark Kampe <mark.kampe@dreamhost.com>
Subject: towards a user-mode diagnostic log mechanism
Date: Mon, 19 Dec 2011 18:42:28 -0800
Message-ID: <4EEFF614.8040207@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41155 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1LTCm2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 21:42:28 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9802CC064
	for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 18:52:56 -0800 (PST)
Received: from [192.168.107.232] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 8A462C062
	for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 18:52:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'd like to keep this ball moving ... as I believe that the
limitations of our current logging mechanisms are already
making support difficult, and that is about to become worse.

As a first step, I'd just like to get opinions on the general
requirements we are trying to satisfy, and decisions we have
to make along the way.

Comments?

I Requirements

   A. Primary Requirements (must have)
      1. information captured
         a. standard: time, sub-system, level, proc/thread
         b. additional: operation and parameters
         c. extensible for new operations
      2. efficiency
         a. run time overhead < 1%
            (I believe this requires delayed flush circular bufferring)
         b. persistent space O(Gigabytes per node-year)
      3. configurability
         a. capture level per sub-system
      4. persistence
         a. flushed out on process shut-down
         b. recoverable from user-mode core-dumps
      5. presentation
         a. output can be processed w/grep,less,...

   B. Secondary Requirements (nice to have)
      1. ease of use
         a. compatible with/convertable from existing calls
         b. run-time definition of new event records
      2. configurability
         a. size/rotation rules per sub-system
         b. separate in-memory/on-disk capture levels

II Decisions to be made

    A. Capture Circumstances
       1. some subset of procedure calls
          (I'm opposed to this, but it is an option)
       2. explicit event logging calls

    B. Capture Format
       1. ASCII text
       2. per-event binary format
       3. binary header + ASCII text

    C. Synchronization
       1. per-process vs per-thread buffers

    D. Flushing
       1. last writer flushes vs dedicated thread
       2. single- vs double-bufferred output

    E. Available open source candidates

