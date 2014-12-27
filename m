From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 27 Dec 2014 06:13:20 -0800
Message-ID: <549ebe8058e0c_64e685d3388867e@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:62941 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaL0ONV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Dec 2014 09:13:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1260497:  Extra sizeof expression  (SIZEOF_MISMATCH)
/msg/async/Event.cc: 123 in EventCenter::create_file_event(int, int, std::tr1::shared_ptr<EventCallback>)()


________________________________________________________________________________________________________
*** CID 1260497:  Extra sizeof expression  (SIZEOF_MISMATCH)
/msg/async/Event.cc: 123 in EventCenter::create_file_event(int, int, std::tr1::shared_ptr<EventCallback>)()
117         }
118         FileEvent *new_events = static_cast<FileEvent *>(realloc(file_events, sizeof(FileEvent)*new_size));
119         if (!new_events) {
120           lderr(cct) << __func__ << " failed to realloc file_events" << cpp_strerror(errno) << dendl;
121           return -errno;
122         }
>>>     CID 1260497:  Extra sizeof expression  (SIZEOF_MISMATCH)
>>>     Adding "40UL /* sizeof (EventCenter::FileEvent) */ * this->nevent" to pointer "this->file_events" of type "EventCenter::FileEvent *" is suspicious because adding an integral value to this pointer automatically scales that value by the size, 40 bytes, of the pointed-to type, "EventCenter::FileEvent".  Most likely, the multiplication by "sizeof (EventCenter::FileEvent)" in this expression is extraneous and should be eliminated.
123         memset(file_events+sizeof(FileEvent)*nevent, 0, sizeof(FileEvent)*(new_size-nevent));
124         file_events = new_events;
125         nevent = new_size;
126       }
127     
128       EventCenter::FileEvent *event = _get_file_event(fd);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

