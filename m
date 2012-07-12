From: Ross Turk <ross@inktank.com>
Subject: Encryption w/ Object Classes
Date: Wed, 11 Jul 2012 18:23:44 -0700
Message-ID: <6AAE89828F4A44DA8AA34F1D17B01E7C@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51983 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab2GLBXr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 21:23:47 -0400
Received: by pbbrp8 with SMTP id rp8so2864093pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 18:23:46 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>
Cc: davi@flyingpenguin.com


Hi, all!

A few weeks ago at the Structure conference, I had a chat with Davi (CCed) about using RADOS object classes to provide encryption capabilities.

The general idea is that RADOS would encrypt objects before storing them. Because the encryption could be done by the OSDs themselves, applications wouldn't require a middleware layer to do it. That might be compelling for some, but it does raise a few concerns:

1) Where would the OSDs store keys? If the keys are stored within RADOS, how can the system prevent those who want to steal data from stealing the keys as well?

2) Would the encryption work be too demanding? Could it affect an OSD's ability to serve requests or perform replication tasks?

3) How could the system deal with multiple keys? Some situations might call for a separate key for each application (or even rgw bucket).

4) How could the system prevent eavesdropping and tampering, given that the data isn't encrypted until it reaches the OSD?  Maybe this is most practical when combined with RGW+SSL.

I'm sure that there are answers to these questions (and lots more questions as well).

Davi and I are interested to know if anyone's explored along these lines. If you haven't given this thought before now and you find it interesting, we'd like to know that too!

Cheers,
Ross

--
Ross Turk
Ceph Community Guy
@rossturk @inktank @ceph

