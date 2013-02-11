From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Client can't reboot when rbd volume is mounted.
Date: Mon, 11 Feb 2013 09:25:44 +0400
Message-ID: <511880D8.1000306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:38586 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKFZs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 00:25:48 -0500
Received: by mail-la0-f48.google.com with SMTP id fq13so5349308lab.7
        for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 21:25:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When I try to reboot a client server  without unmounting of rbd volume 
manually
its services stop working but server doesn't reboot completely and show 
the following logs in KVM console:

[235618.0202207] libceph: connect 192.168.0.19:6789 error -101

I understand that it wait for IO operation but we don't need every time 
unmount/unmap rbd volume manually to accomplish restarting operation.

OS: Debian Wheezy kernel 3.6.10
ceph version 0.56.1

Please point me how to resolve this situation.

Thanks in advance.

-- 
Kind regards,

R. Alekseev

