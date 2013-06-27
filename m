From: Kevin Jones <k.j.jonez@gmail.com>
Subject: Wireshark
Date: Thu, 27 Jun 2013 11:22:50 +0100
Message-ID: <51CC127A.3090701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:41662 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab3F0KW6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 06:22:58 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so287692eek.35
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jun 2013 03:22:57 -0700 (PDT)
Received: from [192.168.0.128] (0546e7d0.skybroadband.com. [5.70.231.208])
        by mx.google.com with ESMTPSA id w43sm2930847eez.6.2013.06.27.03.22.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 03:22:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have done some work on a version of the Wireshark plugin to 
re-structure it so it may be possible to push upstream at some point. At 
the moment it handles connection establishment, setting up some 
conversational state tracking and decoding a few of the message types. 
Supporting other message types is now fairly straight forward but will 
take some time to work through to double check the decoding logic is up 
to date and change to a new decoding style.

At this point I was thinking maybe would be better to check-in as an 
alternative to the existing plugin so there is a base to work 
incrementally towards the upstream goal. Sound like a good approach?

Regards
Kev

