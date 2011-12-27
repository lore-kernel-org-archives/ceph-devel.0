From: Florian Haas <florian@hastexo.com>
Subject: Trivial patch to fix init script LSB compliance
Date: Tue, 27 Dec 2011 11:43:46 +0100
Message-ID: <1324982627-9520-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39013 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab1L0KoF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2011 05:44:05 -0500
Received: by eekc4 with SMTP id c4so11561042eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Dec 2011 02:44:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

please consider merging the following trivial patch that makes the
ceph init script return the proper LSB exit code (3) for the status
action if the service is gracefully stopped, and only return 1 (as
before) if the service has died and left its PID file hanging around.

Who cares about the exit code? Pacemaker does
(http://www.clusterlabs.org). Pacemaker is a high-availability
resource manager that can be used for monitoring and recovering
resources in-place, and as per a brief discussion in #ceph that I had
with Greg before the holidays, no such in-place recovery currently
exists within Ceph itself. Integrating init script based services with
Pacemaker is trivial if the script complies with the exit codes that
the LSB spec specifies.

Feedback on this is much appreciated. Hope this is useful.

Cheers,
Florian

[PATCH] init script: be LSB compliant for exit code on status
