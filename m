From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: =?Big5?Q?Re=3A_=B5=AA=CE=60=3A_The_installation=3A_When_we_start_Ceph=2C_th?=
	=?Big5?Q?e_system_stops_running=2E?=
Date: Wed, 6 Apr 2011 10:58:55 +0800
Message-ID: <BANLkTi=0FeCcW4T14k7cbixRoitK31b6WA@mail.gmail.com>
References: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
	<000001cbf047$332925b0$997b7110$@com>
	<BANLkTi=cGkuCS_X_PLL8k_JNPZNxZf7-bA@mail.gmail.com>
	<BANLkTimGBT6dVz9cS4YAzLLGvpvvt8sqWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39355 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab1DFC64 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 22:58:56 -0400
Received: by vws1 with SMTP id 1so797185vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 19:58:55 -0700 (PDT)
In-Reply-To: <BANLkTimGBT6dVz9cS4YAzLLGvpvvt8sqWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
  what():  buffer::end_of_buffer
bash: line 1: 24409 Segmentation fault      (core dumped)
/usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135
failed: 'ssh Ceph4  /usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135 '
