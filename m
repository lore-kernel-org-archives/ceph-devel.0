From: Sage Weil <sweil@redhat.com>
Subject: msg/async question
Date: Mon, 12 Jun 2017 18:46:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706121845530.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbdFLSqt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 14:46:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomai@xsky.com
Cc: ceph-devel@vger.kernel.org

Hi Haomai,

Ticket http://tracker.ceph.com/issues/20230 is about a busy loop in 
AsyncConnection::handle_connect_msg(). Can you take a look?  I don't 
understand what that block of code is trying to do.

Thanks!
sage

