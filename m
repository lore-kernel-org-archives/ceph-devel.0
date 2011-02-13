From: Daniel Friesen <lists@nadir-seen-fire.com>
Subject: Removing an OSD?
Date: Sun, 13 Feb 2011 09:57:22 -0800
Message-ID: <4D581B82.4090507@nadir-seen-fire.com>
Reply-To: daniel@nadir-seen-fire.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33872 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab1BMR5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Feb 2011 12:57:08 -0500
Received: by pzk35 with SMTP id 35so717328pzk.19
        for <ceph-devel@vger.kernel.org>; Sun, 13 Feb 2011 09:57:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I read through most of the documentation on the wiki, though there is 
one thing I couldn't find.
The OSD cluster expansion/contraction page lists information on adding a 
node, but nothing about removing one.
In particular there are two things I'm curious about.

Firstly, when you want to remove a node (decommissioning the hardware, 
etc...) how do you mark it so that ceph will start migrating data away 
from it onto other OSDs?
Secondly, how does removing an osd interact with the sequential ids of 
OSDs? The importance of that, including not skipping numbers was 
underlined strongly on another page.

-- 
~Daniel Friesen (Dantman, Nadir-Seen-Fire) [http://daniel.friesen.name]

