From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 23 Nov 2014 06:08:48 -0800
Message-ID: <5471ea705303b_37c98993383436b@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:55197 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKWOIt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Nov 2014 09:08:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
2 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1255885:  Ignoring number of bytes read  (CHECKED_RETURN)
/msg/async/Event.cc: 42 in C_handle_notify::do_request(int)()


________________________________________________________________________________________________________
*** CID 1255885:  Ignoring number of bytes read  (CHECKED_RETURN)
/msg/async/Event.cc: 42 in C_handle_notify::do_request(int)()
36     
37     class C_handle_notify : public EventCallback {
38      public:
39       C_handle_notify() {}
40       void do_request(int fd_or_id) {
41         char c[100];
>>>     CID 1255885:  Ignoring number of bytes read  (CHECKED_RETURN)
>>>     "read(int, void *, size_t)" returns the number of bytes read, but it is ignored.
42         assert(read(fd_or_id, c, 100));
43       }
44     };
45     
46     int EventCenter::init(int n)
47     {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



