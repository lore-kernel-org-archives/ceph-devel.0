From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Monitor issue
Date: Mon, 29 Oct 2012 18:48:34 +0400
Message-ID: <508E9742.8040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:52157 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2J2Osi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 10:48:38 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3819374lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 07:48:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have 3 monitors on different nodes and when 'mon.a' was stopped whole  
cluster stopped work too.
My conf: http://pastebin.com/hT3qEhUF

Could someone explain how to fix such kind of failure?
-- 
Kind regards,
R. Alekseev
