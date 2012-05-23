From: Mandell Degerness <mandell@pistoncloud.com>
Subject: write-through cache
Date: Wed, 23 May 2012 16:44:44 -0700
Message-ID: <CA+jddaPW1YpHqo667dD6_9ce8iRhQLOX911-dWKT+XRFMR3YGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52002 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab2EWXop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 19:44:45 -0400
Received: by vbbff1 with SMTP id ff1so5064616vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 16:44:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I would like to test the effect of using the new write-through cache
on RBD volumes mounted to Openstack VMs.  What, precisely, are the
changes I need to make to the volume XML in order to do so?

-Mandell
