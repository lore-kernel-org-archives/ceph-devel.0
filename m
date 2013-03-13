From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: get rid of ceph_msg_pos
Date: Tue, 12 Mar 2013 20:08:08 -0500
Message-ID: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42870 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab3CMBIM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:08:12 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so503829obc.12
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:08:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Previously a ceph_msg_pos structure contained information
for iterating through the data in a message.  Now we use
information in a data item's cursor for that purpose.
This series completes the switchover to use of the cursor
and then eliminates that definition of ceph_msg_pos and
the functions that support it.

					-Alex

[PATCH 1/4] libceph: use cursor resid for loop condition
[PATCH 2/4] libceph: kill most of ceph_msg_pos
[PATCH 3/4] libceph: kill last of ceph_msg_pos
[PATCH 4/4] libceph: use only ceph_msg_data_advance()
