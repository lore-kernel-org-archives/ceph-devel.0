From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Nova on RBD Device
Date: Tue, 7 Feb 2012 11:01:05 -0800
Message-ID: <CA+jddaPFD5qVmUFVygW-HgWbCCvhM6A+_2BCann7NuZgmwgRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45612 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab2BGTBG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 14:01:06 -0500
Received: by vbjk17 with SMTP id k17so4835825vbj.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2012 11:01:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Can anyone point me in the right direction for setting up Nova so that
it allocates disk space on RBD device(s) rather than on local disk as
defined in the --instances_path flag?

I've already got nova-volume working with RBD.

I suspect that I need to modify _cache_image and _create_image in
nova/virt/libvirt/connection.py.

Regards,
Mandell Degerness
