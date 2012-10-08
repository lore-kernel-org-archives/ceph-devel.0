From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Problem with "ceph osd create <uuid>"
Date: Mon, 8 Oct 2012 11:13:11 -0700
Message-ID: <CA+jddaOBZ2cm-R2uQnOCa_yMN+2DDOMAZMB6uNMo4XwFUfYouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42146 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2JHSNM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Oct 2012 14:13:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so311814iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Oct 2012 11:13:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,

I've run into a bit of a weird error and I'm hoping that you can tell
me what is going wrong.  There seems to be a race condition in the way
I am using "ceph osd create <uuid>" and actually creating the OSD's.
The log from one of the servers is at:

https://gist.github.com/528e347a5c0ffeb30abd

The process I am trying to follow (for the OSDs) is:

1) Create XFS file system on disk.
2) Use FS UUID as source to get a new OSD id #.
'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
(Returns 2.)
3) Pass the UUID and OSD id to the create osd command

ceph-osd -c /etc/ceph/ceph.conf --fsid
e61c1b11-4a1c-47aa-868d-7b51b1e610d3 --osd-uuid
32895846-ca1c-4265-9ce7-9f2a42b41672 -i 2 --mkfs --osd-journal-size
8192
4) Start the OSD, as part of the start process, I verify that the
whoami and osd fsid agree (in case this disk came from a previous
cluster, somehow) - should be just a sanity check
'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
(Returns 1!)

This is clearly a race condition because we have several cluster
creations without this happening and then this happens about once
every 8 times or so.  Thoughts?

Regards,
Mandell Degerness
