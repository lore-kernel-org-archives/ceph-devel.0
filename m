From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/8] libceph: implement cursor for outgoing data items
Date: Sun, 10 Mar 2013 14:06:38 -0500
Message-ID: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42124 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3CJTGm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:06:42 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so3883351ieb.17
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:06:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series makes the four distinct data items in a message (the
pages array, the pagelist, the bio, and the trail) take a generic
form, and then arranges for them all to be handled using a common
set of cursor routines that determine what data needs to be sent
next for a message.  There is more consolidation of this code
coming, but for now I'm leaving this series at 8 patches, which
includes the definition of cursor code for the three types of
data item.

					-Alex

[PATCH 1/8] libceph: define ceph_msg_has_*() data macros
[PATCH 2/8] libceph: be explicit about message data representation
[PATCH 3/8] libceph: abstract message data
[PATCH 4/8] libceph: start defining message data cursor
[PATCH 5/8] libceph: prepare for other message data item types
[PATCH 6/8] libceph: use data cursor for message pagelist
[PATCH 7/8] libceph: implement bio message data item cursor
[PATCH 8/8] libceph: implement pages array cursor
