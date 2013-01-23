From: Cesar Mello <cmello@gmail.com>
Subject: Installing Rados Gateway from sources
Date: Wed, 23 Jan 2013 17:53:43 -0200
Message-ID: <CAJVE5RV6t53XEANN_wmOPsKyq-x70VO0PMpZRugCrYJFLNGTjA@mail.gmail.com>
References: <CAJVE5RXPPpcpuin3ZwXo9Q9_+y1Orz2SrtUriSFLKRGwn6MFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:53282 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3AWTxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 14:53:44 -0500
Received: by mail-vb0-f49.google.com with SMTP id s24so6509397vbi.22
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 11:53:43 -0800 (PST)
In-Reply-To: <CAJVE5RXPPpcpuin3ZwXo9Q9_+y1Orz2SrtUriSFLKRGwn6MFFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Sorry if this question is too off-topic. I am a Windows guy with no much
knowledge about Linux.

I have successfully installed a Rados Gateway through apt-get in a virtual
machine. Now I would like to build and install from the sources in order to
play and debug the latest stuff, in my ubuntu workstation.

After building ceph, I run 'make install'. After following the instructions
from docs I have 0.56-395-g371e6fb running nicely.

Now I'm trying to setup radosgw. But this doesn't work:

sudo /etc/init.d/radosgw start


I don't find any file called radosgw. Can someone please help?

Thank you very much for the attention!

Best regards
Mello
