From: Gregory Farnum <greg@inktank.com>
Subject: Re: crc32 for erasure code
Date: Mon, 23 Sep 2013 09:59:17 -0700
Message-ID: <CAPYLRzib=_3JdtZdrAr0xHbAXCcR--ZJHX1cMR1oRvADBwpCWA@mail.gmail.com>
References: <523FFD1B.4030801@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:53439 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab3IWQ7T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 12:59:19 -0400
Received: by mail-we0-f181.google.com with SMTP id p61so3206845wes.26
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 09:59:17 -0700 (PDT)
In-Reply-To: <523FFD1B.4030801@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 1:34 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Unless I'm mistaken, ceph_crc32() is currently used in master via the crc32c() method of bufferlist to:
>
> * encode_with_checksum/decode_with_checksum a PGLog entry
> * Message::decode_message/Message::encode_message a message via calc_*_crc
> * FileJournal::do_read_entry/FileJournal::prepare_single_write a journal entry
> * for information in the report monitory command ( Monitor.cc )
>
> Erasure coded chunks ( i.e. files ) will need checksums. Should this be implemented as an optional feature in ceph/src/os/FileStore.{h,cc} ? If the underlying filesystem does not provide this feature, FileStore would call ceph_crc32 each time the object is modified. A verification method would be exposed and used when scrubbing erasure coded pools.

You mean should checksums be optional in the FileStore, or should we
provide a plugin framework for using things other than crc32, or...?
:)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
