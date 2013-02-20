From: Jaime Melis <jmelis@opennebula.org>
Subject: Ceph support in OpenNebula
Date: Wed, 20 Feb 2013 12:59:05 +0100
Message-ID: <CA+HrgRowreiBM-isY+bW3VFe94yKQCb7YdShXEVW6OEBW+b9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:32823 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935047Ab3BTL72 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Feb 2013 06:59:28 -0500
Received: from homiemail-a3.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a3.g.dreamhost.com (Postfix) with ESMTP id 08A21284082
	for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 03:59:28 -0800 (PST)
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com [209.85.212.177])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jmelis@opennebula.org)
	by homiemail-a3.g.dreamhost.com (Postfix) with ESMTPSA id AFE94284071
	for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 03:59:27 -0800 (PST)
Received: by mail-wi0-f177.google.com with SMTP id hm14so6091487wib.4
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 03:59:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone,

I'm an OpenNebula [1] developer. We've been working on integrating
OpenNebula with native Ceph drivers (using libvirt). The integration
is now complete, ready for testing. You can find more information
about its usage here [2].

We will maintain these drivers officially and extend its features, so
if you have any questions, comments or suggestions, please let me
know.

I would be very happy to write an OpenNebula page in Ceph's documentation.

[1] http://opennebula.org
[2] http://opennebula.org/documentation:rel4.0:ceph_ds

Cheers,
Jaime

--
Jaime Melis
Project Engineer
OpenNebula - The Open Source Toolkit for Cloud Computing
www.OpenNebula.org | jmelis@opennebula.org
