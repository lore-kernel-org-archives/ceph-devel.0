From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 09:51:52 -0700 (PDT)
Message-ID: <1411370147.27209.1312217512178.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:49885 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab1HAQvw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:51:52 -0400
In-Reply-To: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

----- Original Message -----
> From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Monday, August 1, 2011 10:24:50 AM
> Subject: JSON generation in C/C++

> 
> j = StreamingJSONObject(fd)
> j.dump(key, value)
> j.dump(key2, value2)
> j.close()

You may also be interested in BSON (Binary JSON), a JSON-like binary
serialization format, most notably used by mongodb.

   http://bsonspec.org/

-Noah
