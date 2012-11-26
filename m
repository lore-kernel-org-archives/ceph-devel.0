From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Mon, 26 Nov 2012 14:20:31 +0100
Message-ID: <50B36C9F.80107@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42773 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab2KZNUe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 08:20:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Dan Mick <dan.mick@inktank.com>

Hello list,

i know branch wip-rbd-export-stdout is work in progress but it is more 
than useful ;-)

When i try to import an image i get:

# gzip -dc vm-101-disk-1.img.gz | rbd import --format=2 
--size=42949672960 - kvmpool1/vm-101-disk-1
rbd: error reading file: (29) Illegal seek
Importing image: 0% complete...failed.
rbd: import failed: (29) Illegal seek

Anything i've tried wrong?

Greets,
Stefan
