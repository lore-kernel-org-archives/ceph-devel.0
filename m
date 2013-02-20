From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: ceph keyring
Date: Wed, 20 Feb 2013 10:01:22 +0100
Message-ID: <CAJH6TXgQ2Z_k=Prs625bbX1TWEwUmQRY8wsHhxM5OOU73fiWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:61175 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3BTJBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 04:01:24 -0500
Received: by mail-we0-f175.google.com with SMTP id x8so6546059wey.34
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 01:01:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to configure RGW following this guide:
http://ceph.com/docs/master/radosgw/config/

I have some questions about keyring. Should keyring files copied on
each cluster node?
For example, these commands:

sudo ceph-authtool --create-keyring /etc/ceph/keyring.radosgw.gateway
sudo chmod +r /etc/ceph/keyring.radosgw.gateway
sudo ceph-authtool /etc/ceph/keyring.radosgw.gateway -n
client.radosgw.gateway --gen-key
sudo ceph-authtool -n client.radosgw.gateway --cap osd 'allow rwx'
--cap mon 'allow r' /etc/ceph/keyring.radosgw.gateway
sudo ceph -k /etc/ceph/ceph.keyring auth add client.radosgw.gateway -i
/etc/ceph/keyring.radosgw.gateway

on which node should be ran and the generated keyfile, should be
synced on each node?
