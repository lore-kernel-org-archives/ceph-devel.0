From: Radoslav Georgiev <rgeorgiev583@gmail.com>
Subject: Google Summer of Code 2017 project proposal: implementation of RBD
 diff checksums using a rolling checksum algorithm
Date: Sun, 2 Apr 2017 22:36:25 +0300
Message-ID: <590b7274-9806-e8b1-e81e-b0df9ffa9d3b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35125 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdDBTg3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Apr 2017 15:36:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id k6so136845058wre.2
        for <ceph-devel@vger.kernel.org>; Sun, 02 Apr 2017 12:36:29 -0700 (PDT)
Received: from [192.168.1.110] ([77.70.111.135])
        by smtp.gmail.com with ESMTPSA id o66sm11341923wmg.33.2017.04.02.12.36.26
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2017 12:36:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

My name is Radoslav Georgiev and I am currently studying Computer 
Science at Sofia University.  As a passionate software developer with a 
special appreciation of free and open source software, I am interested 
in taking part in the Google Summer of Code 2017 program.  My main 
motivation to choose Ceph as my prospective mentoring organization is 
because I am interested in distributed and scalable storage in general, 
and the way Ceph does it in particular (especially its architecture: the 
RADOS concept and library, the RADOSGW, the Ceph block device, CephFS, 
and the various assorted APIs).  In addition to that, I used to work as 
a systems programmer for an organization that employed Ceph for its data 
storage and scalability needs, writing software that interacts with 
Ceph's service interfaces.

When I went through your organization's list of ideas, I saw that there 
is a need for verification of diffs of RADOS block device images (i.e. 
RBD diff checksums) to be implemented. Since (as mentioned in the idea 
description) calculating the checksum of an entire image would be too 
slow and inefficient, I came up with the (actually pretty trivial) 
solution to use a rolling checksum algorithm.

As you might know, rolling hash algorithms save computation time and 
memory.  They split the input into chunks, and calculate the hash of 
each chunk using a simple (i.e. fast) hash algorithm.  What is important 
to note here is that the hash for the whole string is calculated 
incrementally, beginning from zero (or some known constant value), and 
for each chunk added the checksum of the string including that chunk is 
calculated using only the old checksum (of the string without the chunk) 
and the difference between the last chunk and the currently added one. 
(For more information on this topic, see 
<https://en.wikipedia.org/wiki/Rolling_hash>.)

Some useful rolling hash algorithms that could be implemented are the 
Fletcher's checksum algorithms (Fletcher-16/32/64 
<https://en.wikipedia.org/wiki/Fletcher's_checksum>), or the Adler-32 
algorithm (which, albeit slightly modified, is used in rsync).  (Of 
course, these algorithms do not provide particularly strong or 
cryptographically secure hashing but, as far as I understood, it is not 
really necessary to provide that for the purpose given.)

I think my idea is worthy of consideration as a solution to the 
presented problem, and I look forward to its acceptance.

P. S. I sent you a mail because it was mentioned on Ceph's GSoC 
organization page that students willing to participate should do so to 
foster better communication with the mentors.

-- 
Regards,
   Radoslav

