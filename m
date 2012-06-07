From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Recovery from loss of monitors
Date: Thu, 7 Jun 2012 16:34:43 -0700
Message-ID: <CA+jddaPdk3=Q1W4vftRB+H9fLzSZxJJPGJRtKTephtmSDdWV+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60684 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253Ab2FGXep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 19:34:45 -0400
Received: by bkcji2 with SMTP id ji2so1129561bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 16:34:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am thinking about data reliability issues and I'd like to know if we
can recover a cluster if we have most of the OSD data intact (i.e.
there are enough copies of all of the PGs), but we have lost all of
the monitor data.
