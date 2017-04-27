From: yiming xie <platoxym@gmail.com>
Subject: Help! how to set iscsi.conf of SPDK iscsi target when  using ceph rbd
Date: Thu, 27 Apr 2017 11:37:16 +0800
Message-ID: <7A593874-D5EF-4E90-B5BC-87E3ADBA58EA@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34991 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbdD0Dj0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Apr 2017 23:39:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id a188so5368679pfa.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Apr 2017 20:39:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Ceph Users <ceph-users@lists.ceph.com>

I want to use the ceph rbd as storage backend of SPDK iscsi target,
but I start the iscsi_tgt failed!

I don't know how to specifiy backend storage type and some parrameters =
about ceph rbd
Please show me the example of iscsi.conf about how to use ceph rbd if =
you know.
Tanks!=20


./app/iscsi_tgt/iscsi_tgt -c ./test/iscsi_tgt/rbd/new.conf
coredown:
lib/env_dpkg/init.c:
rc =3D rte_eal_init(argcount, dpdk_args);


new.conf:

[Global]
=20
[iSCSI]
  # node name (not include optional part)
  # Users can optionally change this to fit their environment.
  NodeBase "iqn.2016-06.io.spdk"

  AuthFile /usr/local/etc/spdk/auth.conf

  MinConnectionsPerCore 4
=20
  MinConnectionIdleInterval 5000

  # Socket I/O timeout sec. (0 is infinite)
  Timeout 30
 # authentication information for discovery session
  DiscoveryAuthMethod Auto

  #MaxSessions 128
  #MaxConnectionsPerSession 2

  # iSCSI initial parameters negotiate with initiators
  # NOTE: incorrect values might crash
  DefaultTime2Wait 2
  DefaultTime2Retain 60

  ImmediateData Yes
  ErrorRecoveryLevel 0

[Rpc]
  # Defines whether to enable configuration via RPC.
  # Default is disabled.  Note that the RPC interface is not
  # authenticated, so users should be careful about enabling
  # RPC in non-trusted environments.
  Enable No
  # Listen address for the RPC service.
  # May be an IP address or an absolute path to a Unix socket.
  Listen 127.0.0.1

[PortalGroup1]
  Portal DA1 172.16.121.131:3260


[InitiatorGroup1]
  InitiatorName ALL
  Netmask 172.16.121.0/24

[Ioat]
  Disable Yes
  Whitelist 00:04.0
  Whitelist 00:04.1

[AIO]

[Ceph]
  Ceph rbd foo 512

[TargetNode1]
  TargetName test-targetname
  TargetAlias "alias-test-targetname"
  Mapping PortalGroup1 InitiatorGroup1
  #AuthMethod Auto
  #AuthGroup AuthGroup1
  # Enable header and data digest
  # UseDigest Header Data
  #UseDigest Auto
  # Use the first malloc target
  LUN0 Ceph0
  QueueDepth 128


