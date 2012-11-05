From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: recommanded cache setting for rbd image
Date: Mon, 05 Nov 2012 15:53:17 +0100
Message-ID: <5097D2DD.2000006@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55969 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546Ab2KEOxU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 09:53:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

right now i'm testing rbd block devices with kvm using Default cache (no 
cache).

Is there any recommanded value for RBD? (i don't wanna loose data)

Stefan

