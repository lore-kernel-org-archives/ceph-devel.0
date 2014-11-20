From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 20 Nov 2014 06:20:26 -0800
Message-ID: <546df8aa3b172_789d8993383433d@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:57690 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaKTOU1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 09:20:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1255369:  Copy into fixed size buffer  (STRING_OVERFLOW)
/common/blkdev.cc: 34 in block_device_support_discard(const char *)()


________________________________________________________________________________________________________
*** CID 1255369:  Copy into fixed size buffer  (STRING_OVERFLOW)
/common/blkdev.cc: 34 in block_device_support_discard(const char *)()
28     bool block_device_support_discard(const char *devname)
29     {
30       bool can_trim = false;
31       char *p = strstr((char *)devname, "sd");
32       char name[32] = {0};
33     
>>>     CID 1255369:  Copy into fixed size buffer  (STRING_OVERFLOW)
>>>     You might overrun the 32 byte fixed-size string "name" by copying "p" without checking the length.
34       strcpy(name, p);
35       for (unsigned int i = 0; i < strlen(name); i++) {
36         if(isdigit(name[i])) {
37           name[i] = 0;
38           break;
39         }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



