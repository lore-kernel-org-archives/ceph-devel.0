From: Nick Bartos <nick@pistoncloud.com>
Subject: Kernel crash bug status
Date: Tue, 29 May 2012 17:46:25 -0700
Message-ID: <CAPud5_6-PgcxG-WDZ8DXapfJXe=hwZOwW5SAh9nLAF3O9JdMTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52997 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab2E3Aq0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 20:46:26 -0400
Received: by dady13 with SMTP id y13so6164975dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 17:46:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are still seeing a crash on 0.47.2 with 3.2.18, which seems to be this bug:

http://tracker.newdream.net/issues/2260

Any one else seeing this problem, and/or have any ideas how to fix or
work around it?
