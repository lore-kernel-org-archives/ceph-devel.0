From: Cesar Mello <cmello@gmail.com>
Subject: RadosGW performance and disk space usage
Date: Thu, 24 Jan 2013 13:27:32 -0200
Message-ID: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:36382 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3AXP1f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 10:27:35 -0500
Received: by mail-ve0-f178.google.com with SMTP id oz10so1525077veb.9
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 07:27:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I have successfully prototyped read/write access to ceph from Windows
using the S3 API, thanks so much for the help.

Now I would like to do some prototypes targeting performance
evaluation. My scenario typically requires parallel storage of data
from tens of thousands of loggers, but scalability to hundreds of
thousands is the main reason for investigating ceph.

My tests using a single laptop running ceph with 2 local OSDs and
local radosgw allows writing in average 2.5 small objects per second
(100 objects in 40 seconds). Is this the expected performance? It
seems to be I/O bound because the HDD led keeps on during the
PutObject requests. Any suggestion or documentation pointers for
profiling are very appreciated.

I am afraid the S3 API is not good for my scenario, because there is
no way to append data to existing objects (so I won't be able to model
a single object for each data collector). If this is the case, then I
would need to store billions of small objects. I would like to know
how much disk space each object instance requires other than the
object content length.

If the S3 API is not well suited to my scenario, then my effort should
be better directed to porting or writing a native ceph client for
Windows. I just need an API to read and write/append blocks to files.
Any comments are really appreciated.

Thank you a lot for the attention!

Best regards
Mello
