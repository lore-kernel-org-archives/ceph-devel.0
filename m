From: Franck Marchand <fmarchand@agaetis.fr>
Subject: Re: Removed directory is back in the Ceph FS
Date: Tue, 13 Nov 2012 12:23:36 +0100
Message-ID: <CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
References: <CAOGW2pyKcL=vs7p2i3yDNCC1Vxoh6cx053vECVCm=Twt7H4M5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35995 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2KMLXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 06:23:37 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so7198971vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 03:23:36 -0800 (PST)
In-Reply-To: <CAOGW2pyKcL=vs7p2i3yDNCC1Vxoh6cx053vECVCm=Twt7H4M5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have a weird pb. I remove a folder using a mounted fs partition. I
did it and it worked well.
I checked later to see if I had all my folders in ceph fs ... : the
folder I removed was back and I can't remove it ! Here is the error
message I got :

rm -rf 2012-11-10/
rm cannot remove `2012-11-10': Directory not empty

This folder is empty ...
So anybody had the same pb ? Am I doing something wrong ?

Thx
