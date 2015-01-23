From: Mykola Golub <mgolub@mirantis.com>
Subject: msg: fixup for 2ffacbe (crc configuration in messenger)
Date: Fri, 23 Jan 2015 14:50:46 +0200
Message-ID: <20150123125045.GA12920@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:38272 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbAWMv0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 07:51:26 -0500
Received: by mail-la0-f41.google.com with SMTP id gm9so7130943lab.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 04:51:25 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Casey Bodley <casey@linuxbox.com>, Matt Benjamin <matt@cohortfs.com>, Sage Weil <sage@redhat.com>

Hi,

It looks like the following commit introcuded a regression:

commit 2ffacbe6efae05f5c426cae34882b3351a5ccfbe
Author: Casey Bodley <casey@linuxbox.com>
Date:   Wed Sep 3 12:29:17 2014 -0400

    msg: crc configuration in messenger
    
    Add new header_crc and data_crc configuration booleans, and use
    them consistently to govern whether CRC is performed in the
    Message encode, decode, and transit paths.
    
    Remove ms_nocrc, changes per Sage.
    Mimimally adapt AsyncMessenger for crcflags.
    
    Signed-off-by: Casey Bodley <casey@linuxbox.com>
    Signed-off-by: Matt Benjamin <matt@cohortfs.com>

I faced problems with forwarding messages from older monitors: after
changing the signature of Message::encode(), not all calls were
updated, as a result route messages sent by a new monitor have crc for
data not calculated, while the old monitor expects it calculated.

Also, in Message::encode() crc for data is calculated when MSG_CRC_DATA
is set, but in decode_message(), Pipe::read/write_message() crc for
data is calculated when MSG_CRC_HEADER is set. This looks wrong to me.

Please rewiew the fixup:

https://github.com/ceph/ceph/pull/3473

Also, the behavior of Pipe::read_message/write_message() has been
changed: previously the method always calculated crc, now they
calculate it only if crc is enabled in the config. This means crc can
not be disabled if there are monitors of older version in the
cluster. I suppose we can't fix this, but it might worth documenting
in the release report?

-- 
Mykola Golub
