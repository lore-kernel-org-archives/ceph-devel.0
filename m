From: Mark Nelson <mark.nelson@inktank.com>
Subject: Ceph Performance Part 2
Date: Fri, 09 Nov 2012 07:22:37 -0600
Message-ID: <509D039D.7040200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51968 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab2KINWb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 08:22:31 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5836336iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 05:22:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Guys,

The second instalment of our investigation into Ceph performance is 
live!  This time we are looking at write performance on the same set of 
controllers as in the first article, but using 8 spinning disks and 
putting both the data and SSDs on those drives.  Hope you enjoy!

http://t.co/exwXJOVV

Mark
