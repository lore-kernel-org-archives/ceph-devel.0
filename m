From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Reliability metrics in ceph-tools
Date: Tue, 24 Jun 2014 15:52:06 +0200
Message-ID: <CACUN8h1G4Fy-vk6D0Pu6VFa3VJSr_5bEWpX+R-E3vWE=8xYauQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:51357 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaFXNwH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 09:52:07 -0400
Received: by mail-ig0-f196.google.com with SMTP id h18so132375igc.11
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jun 2014 06:52:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am implementing the erasure code support for the reliability model
tool (GSoC14 project). These are some comments/questions regarding the
blocks recovery:

1)In Loic's code
(https://github.com/ceph/ceph/blob/master/src/erasure-code/ErasureCodeInterface.h)
some coded chunks are more expensive than others. What means "more
expensive"? Is it the time to download? Does it change the repairing
costs?

The explanation says that the semantic of the cost is defined by the
caller. It adds that retrieving two chunks with cost 6+6 may be less
expensive than two chunks with cost 1+9. I imagine that the logic is
that two chunks can be download in parallel and then 6<9. For
simplicity, I will assume that the cost of fetching is the same for
any block.

2) RadosRely.py uses the following rebuild_time formula:

seconds = float(self.disk.size * self.full) / (speed * self.pgs)
with self.pgs(declustered factor)= number of PGs in OSD and
speed=expected recovery rate (bytes/second)

I think that the assumption is not realistic in large deployments with
multiple failing nodes. Typically the replication bandwidth will reach
a limit when too many nodes are recovering in parallel. I assume,
however, that ignore that problem is enough to start. Do you agree?

3) The above formula doesn't say anything about the replication
latency, the cost of encoding, etc. For the case of erasure, such
values are significant. Furthermore, repairing means read k chunks and
store again k+m chunks. What happen with previous chunks that are
still available? Only the missing chunk is replaced? I wonder how to
adapt the previous formula with the k and m.   I add the factor 2
because the k chunks how to be fetch from somewhere else to do the
re-coding and then k+m chunks have to be stored again.
seconds = float(self.disk.size * self.full *(2k+m)) / (speed * self.pgs) ??

4) Declustering: I am not sure if I understand how it works. From the
reliability model "The number of OSDs read-from and written-to is
assumed to be equal to the
specified declustering factor, with each of those transfers happening
at the specified recovery speed."  I also read sth written by Sage in
https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
But I am confused. Not clear for me how to use self.pgs (in the
context of the tool) and k&m in the formula above.


koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema
