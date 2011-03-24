From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: a question about laggy mds
Date: Thu, 24 Mar 2011 10:54:22 +0800
Message-ID: <AANLkTi=HNeQNb+kGFro8EnW+n99yOzKP3R+1ScwpybHs@mail.gmail.com>
References: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
	<AANLkTimecWXyouv-0R8RuZampTyf=zQq3-UBBvJZ=axE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35296 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab1CXCyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 22:54:23 -0400
Received: by fxm17 with SMTP id 17so7932106fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:54:22 -0700 (PDT)
In-Reply-To: <AANLkTimecWXyouv-0R8RuZampTyf=zQq3-UBBvJZ=axE@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: huang jun <hjwsm1989@gmail.com>, ceph-devel@vger.kernel.org

> The MDS gets marked laggy if it goes too long without sending a
> "beacon" to the monitors. This generally happens if the MDS gets
> overloaded by client requests for some reason -- or if it simply
> crashes. Your config looks okay so either your MDS doesn't have the

There seems to be another circumstance that the MDS would be marked
laggy: If the monitor got laggy, the MDS would not be able to receive
the ack of beacon in time. Then, the MDS would think itself busy, but
actually it's not. Thus, you may want to check if the monitor gets
laggy as well.

-- 
Henry
