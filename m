From: AnnyRen <annyren6@gmail.com>
Subject: How to test HA(HighAvailability) of MDS
Date: Mon, 11 Apr 2011 23:35:44 +0800
Message-ID: <BANLkTiknehGsu-2UE65j8QM=zRsJnG6AYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44122 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1DKPfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 11:35:45 -0400
Received: by ewy4 with SMTP id 4so1748644ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:35:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I want to test the reliability of MDS in Ceph File System,
there are three MONs, two MDSes and three OSD in my test environment.

With "ceph -s", I saw the MDS's status is
2011-04-11 23:30:38.001177   mds e5: 1/1/1 up {0=up:active}, 1 up:standby

Could you tell me how to set the standby MDS to active? What is the
instruction? ^_^
and how can I test the reliability of MDS ?
May I turn off the active one and see the standby MDS takes over?

Could you tell me how to verify the HA (High Availability) of MDS.
Thanks for your helping. ^__^


Best Regards,
Anny
