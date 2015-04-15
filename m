From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Few CEPH questions.
Date: Wed, 15 Apr 2015 15:08:57 -0700
Message-ID: <CAKKTCLWv1+pqW5_yj5d1T_6sDx+M1axev4T1We52vUmAytmRZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36224 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477AbbDOWJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 18:09:40 -0400
Received: by qku63 with SMTP id 63so107700615qku.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2015 15:09:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All, I am new to this mailing list.
I have few basic questions on the CEPH, hope someone can answer me.
Thanks in advance.!!


I would like to understand more the the placement policy, especially
on the failure path.

1. Machines going up and down is fairly common in a data center.
     How often does the cluster map change?
     Every machine bounce causes an update/distribution of cluster map?
     and affect the CRUSH? Does it cause cluster network too chatty?

2. Ceph mainly depends on the primary OSD in a given PG.
    What happens in the read/write path if that OSD is down at that moment?
    There can be cases, OSD is down but cluster map is not up to date.
    When the write/read fail, does the client retry it after
populating clustermap?

3. Whenever the cluster map changes, it may not propagate to the entire cluster.
    Some clients may be running with old map, and may end-up in wrong OSD.
    Do we depend on peering to take care of this situation?

4. If a OSD becomes too full, which may take reads, but no writes anymore. Does
    CRUSH() take that into account? Does it generate different maps
for reads vs writes?
     or this case is handled by distributing(moving) data off of the OSD?

6. Does CRUSH() takes OSD size into consideration?

7. Does CEPH support quorum writes? (2 out of 3 is a success. )

--
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
