From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: radosgw
Date: Wed, 23 Jan 2013 18:56:55 +0100
Message-ID: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:55484 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab3AWR45 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 12:56:57 -0500
Received: by mail-we0-f181.google.com with SMTP id u7so2406876wey.26
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 09:56:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to configure RadosGW but actually, radosgw doesn't start.

I've followed this guide:
http://ceph.com/docs/master/radosgw/config/

Apache configuration is OK and i've added the following configuration
to my ceph.conf:

[client.radosgw.gateway]
        host = {host-name}
        keyring = /etc/ceph/keyring.radosgw.gateway
        rgw socket path = /tmp/radosgw.sock
        log file = /var/log/ceph/radosgw.log


i've copied ceph.conf to all servers, even on radosgw.

Then, on radosgw node, i've run:

mkdir -p /var/lib/ceph/radosgw/ceph-radosgw.gateway
ceph-authtool --create-keyring /etc/ceph/keyring.radosgw.gateway
chmod +r /etc/ceph/keyring.radosgw.gateway
ceph-authtool /etc/ceph/keyring.radosgw.gateway -n
client.radosgw.gateway --gen-key
ceph-authtool -n client.radosgw.gateway --cap osd 'allow rwx' --cap
mon 'allow r' /etc/ceph/keyring.radosgw.gateway
ceph -k /etc/ceph/ceph.keyring auth add client.radosgw.gateway -i
/etc/ceph/keyring.radosgw.gateway

but after that, radosgw doesn't start:

# radosgw
radosgw: must specify 'rgw socket path' to run as a daemon


but "rgw socket path" is already present in ceph.conf
