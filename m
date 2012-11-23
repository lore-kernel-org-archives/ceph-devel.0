From: Martin Gerhard Loschwitz <martin.loschwitz@hastexo.com>
Subject: Debian/Ubuntu packages for ceph-deploy
Date: Fri, 23 Nov 2012 01:29:35 +0100
Message-ID: <50AEC36F.9050807@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:49399 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2KWA3k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 19:29:40 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so3394274eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 16:29:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

I figured it might be a cool thing to have packages of ceph-deploy for
Debian and Ubuntu 12.04; I took the time and created them (along with
packages of python-pushy, which ceph-deploy needs but which was not
present in the Debian archive and thus in the Ubuntu archive either).

They are available from http://people.debian.org/~madkiss/ceph-deploy/

I did upload python-pushy to the official Debian unstable repository
already, but I didn't do so just yet with ceph-deploy. Also, I don't
want to step on somebody's toes - if there were secret plans to start
ceph-deploy packaging anyway, I'm more than happy to hand over what
I have got to the responsible person.

Any feedback is highly appreciated (esp. with regards to the question
if it's already okay to upload ceph-deploy).

Best regards
Martin G. Loschwitz

-- 
Martin Gerhard Loschwitz
Chief Brand Officer, Principal Consultant
hastexo Professional Services

CONFIDENTIALITY NOTICE: This e-mail and/or the accompanying documents
are privileged and confidential under applicable law. The person who
receives this message and who is not the addressee, one of his employees
or an agent entitled to hand it over to the addressee, is informed that
he may not use, disclose or reproduce the contents thereof. Should you
have received this e-mail (or any copy thereof) in error, please let us
know by telephone or e-mail without delay and delete the message from
your system. Thank you.
