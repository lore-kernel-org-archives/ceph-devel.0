From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: rbd image association
Date: Mon, 03 Jun 2013 10:52:14 +0400
Message-ID: <51AC3D1E.2000800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47224 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3FCGwR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 02:52:17 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so3396189lbi.4
        for <ceph-devel@vger.kernel.org>; Sun, 02 Jun 2013 23:52:16 -0700 (PDT)
Received: from [192.168.1.116] ([81.195.203.34])
        by mx.google.com with ESMTPSA id i2sm1685271lah.5.2013.06.02.23.52.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 23:52:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is it possible to associate certain rbd device with the appropriate rbd 
image (for example : image1 > /dev/rbd0)?
We always need to map image1 to /dev/rbd0, image2 to /dev/rbd1 etc. 
Because I'm using /dev/rbd* in some configuration files.

Thanks

-- 
Kind regards,

R. Alekseev

