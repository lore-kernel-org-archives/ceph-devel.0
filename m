From: Dennis Chen <xschen@tnsoft.com.cn>
Subject: question about ceph and FC SAN LUN data IO path
Date: Mon, 13 May 2013 20:24:35 +0800
Message-ID: <5190DB83.9010007@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbg297.qq.com ([184.105.67.100]:54203 "HELO smtpbg297.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251Ab3EMMWo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 May 2013 08:22:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dennis Chen <xschen@tnsoft.com.cn>

Hi,

If I have an OSD attached by a FC SAN device with the connection like this:
OSD HBA-->FC Switch-->SAN storage device.

Then Map a LUN in the SAN to the OSD as its only disk device to save 
data. if I have a client also has an HBA and the topology diagram looks 
like:

                   osd                                         client
         -------        -------                            -------     
-------
        | HBA |      | NIC |  <---------------> | NIC |   | HBA |
         ---+---      --------                            ------- -------
\                                                            /
                   \ /
                        \                                   /
                               \    --------------
                                   | FC Switch |
                                    --------------
                                           |
                                        SAN

Suppose the created LUN above for OSD can be accessed by both osd and 
client though FC I/F, the question is:
if I create a rbd block device in osd and map it to client, make a file 
system and mount it in client side, then create a file in the mounted 
FS. The read/write operation followed for this file will transfer data 
though ethernet path or FC path?

BRs,
Dennis

