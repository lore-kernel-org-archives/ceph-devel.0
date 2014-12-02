From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: LTTng tracing: ReplicatedPG::log_operation
Date: Tue, 2 Dec 2014 19:17:58 +0100
Message-ID: <20141202191758.5eded52c@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:20500 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbaLBSSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 13:18:02 -0500
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id sB2IJDvL011709
	for <ceph-devel@vger.kernel.org>; Tue, 2 Dec 2014 19:19:13 +0100
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id 6A5C213F02
	for <ceph-devel@vger.kernel.org>; Tue,  2 Dec 2014 19:10:04 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

during code profiling using LTTng, I encounter that during
processing of write requests to the cluster, the ceph-osd
spends a lot of time in the ReplicatedPG::log_operation
before the the actual writes to journal and object
in the FileStore are triggered.

This happens in ReplicatedBackend::submit_transaction.

What I wonder is
  - what is the purpose of the log_operation?
    If I am not mistaken, then it is neither the write-to-journal
    nor the write-to-object; both of these are triggered from 
    the queue_operation following that log_operation.

  - can the sequence between the log_operation and
    the actual queue_operation be reversed in
    ReplicatedBackend::submit_transaction?

   

Regards

Andreas Bluemle





-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
