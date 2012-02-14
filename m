From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Best plan for recovery if disk holding monitor data dies
Date: Mon, 13 Feb 2012 17:38:58 -0800
Message-ID: <CA+jddaOUL1z-3JfS-ixAHthCU6k9zpCB55rmj9BO-tB92vvTHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64837 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2BNBi7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 20:38:59 -0500
Received: by vcge1 with SMTP id e1so3563656vcg.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2012 17:38:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

What would you recommend as the best recovery strategy when the disk
holding the monitor data for a given monitor fails?

Should I recover from a periodic back up and re-start the monitor or
should I treat it as a new monitor being added to the cluster?  I
suspect the former, but i'd like confirmation.  Any information on
gotcha's would be useful as well.

Regards,
Mandell Degerness
