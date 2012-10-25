From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Can't copy folder with data to ceph storage.
Date: Thu, 25 Oct 2012 10:24:10 +0400
Message-ID: <5088DB0A.4040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:64762 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab2JYGYO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 02:24:14 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1016193lag.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 23:24:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've  simple  installation of ceph on Debian server with the
following configuration:
************************
[global]
      debug ms = 0
[osd]
      osd journal size = 1000
      filestore xattr use omap = true

[mon.a]

      host = serv1
      mon addr = 192.168.0.10:6789

[osd.0]
       host = serv1

[mds.a]
      host = serv1
************************

So, I've mounted ceph storage on another server (mount -t ceph 
192.168.0.10:6789:/ /mnt/mycephfs2/)
and begun copying process (size of folder is 1.9Gb) , this process has 
not been finished over 12 hours and I'm not able to kill this process at 
all, only way  to do that restart server.  Kindly help me to find the 
reason of this problem. Thanks.

-- 
Kind regards,

R. Alekseev

