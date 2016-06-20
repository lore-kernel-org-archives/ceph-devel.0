From: Jeff Layton <jlayton@redhat.com>
Subject: determining client and server on a connection
Date: Mon, 20 Jun 2016 07:21:09 -0400
Message-ID: <1466421669.4297.13.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33052 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcFTLVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 07:21:13 -0400
Received: by mail-yw0-f170.google.com with SMTP id v77so14675931ywg.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 04:21:12 -0700 (PDT)
Received: from ceres.poochiereds.net ([2606:a000:1125:4074:1a5e:fff:fe12:8671])
        by smtp.gmail.com with ESMTPSA id b7sm31717747ywf.45.2016.06.20.04.21.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jun 2016 04:21:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi! I'm just getting started working with ceph, and decided to tackle
fixing up the wireshark dissector which isn't working properly when you
use the kernel's fs client.

This page says that the server always sends its banner first:

    http://docs.ceph.com/docs/master/dev/network-protocol/?highlight=protocol

...but that's not true with the Linux kernel client. The client and
server send their banners and addresses concurrently, and the client
often gets there first. The wireshark dissector relies on the server
sending its banner first however, so it quickly mixes the two up and
things go south from there.

Given the way the protocol works, the only way I can see to reliably
determine client and server is to read enough bytes to get to the
client's address when the server sends it, and see whether it matches
the receiver's address/port.

Is there a simpler way to do this that I'm missing?

Also, it looks like this shouldn't be a problem for the msgr2 protocol
since the initial exchange doesn't involve sending addresses. Is that
the case?

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>

