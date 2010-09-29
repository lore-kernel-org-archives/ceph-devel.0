From: "Colin P. McCabe" <colinm@hq.newdream.net>
Subject: cluster-optimized network transports
Date: Wed, 29 Sep 2010 11:27:58 -0700
Message-ID: <AANLkTikw2sOcMzLE8ur4Zdr_Px8KT-+Zw1rci2LmTeWN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0I2S2A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Sep 2010 14:28:00 -0400
Received: by fxm4 with SMTP id 4so142017fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 11:27:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Ceph relies on TCP for inter-node communication. One thing that might
be interesting is to use a cluster-optimized network transport
protocol for Ceph.

For example, TIPC provides the same sockets interface, and can provide
reliable delivery. But unlike TCP, TIPC was optimized for cluster
environments where packet loss is low, bandwidth is high, etc.
Ericsson uses it for cluster applications. (See
http://tipc.sourceforge.net/ )

There are some papers out there that benchmark TCP vs. TIPC and other
protocols. Basically TCP has a lot of mechanisms that were created to
work well on the open internet, which is kind of a risky place. But
dropping them can result in better latency and bandwidth in a closed
cluster. TIPC uses a different acknowledgement mechanism, doesn't
checksum packets since it assumes that the hardware does that, avoids
the overhead of the 3-way handshake, etc.

There is apparently a native interface and a sockets interface to
TIPC. I'm not sure what the advantages of the native interface are
versus sockets. Ideally this would be a drop-in replacement.

Just a random idea.

cheers,
Colin McCabe
