From: kefu chai <tchaikov@gmail.com>
Subject: upgrade from v0.94.6 or lower and 'failed to encode map X with
 expected crc'
Date: Tue, 4 Oct 2016 15:18:40 +0800
Message-ID: <CAJE9aONFauhy7v6n9bT11Sga+e0Qgi8hWu=gr-zoxuAq5Yv+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35562 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbcJDHSl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 03:18:41 -0400
Received: by mail-oi0-f47.google.com with SMTP id d132so24205068oib.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Oct 2016 00:18:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi ceph users,

If user upgrades the cluster from a prior release to v0.94.7 or up by
following the steps:

1. upgrade the monitors first,
2. and then the OSDs.

It is expected that the cluster log will be flooded with messages like:

2016-07-12 08:42:42.1234567 osd.1234 [WRN] failed to encode map e4321
with expected crc

Because we changed[1] the encoding of OSDMap in v0.94.7. And the
monitors start sending the incremental OSDMaps with the new encoding
to the OSDs once the quorum members are all at the new version. But
the OSDs at the old version still re-encode the osdmaps with the old
encoding, then compare the resulting CRC with the one carried by the
received incremental maps. And, they don't match! So the OSDs will ask
the monitors for the full map in this case.

For a large Ceph cluster, there are several consequences of the CRC mismatch:
1. monitor being flooded by this clog
2. monitor burdened by the sending the fullmaps.
3. the network saturated by the osdmap messages carrying the requested fullmaps
3. slow requests observed if the updated osdmaps are delayed by the
saturated network.

as reported[2,3,4,5] by our users.

The interim solution for those who are stuck in the middle of an upgrade is:

1. revert all the monitors back to the previous version,
2. upgrade the OSDs to the version you want to upgrade.
3. upgrade the monitors to the version you want to upgrade.

And for users who plan to upgrade from a version prior to v0.94.7 to
v0.94.7 or up, please
1. upgrade the OSDs to the version you want to upgrade
2. upgrade the monitors to the version you want to upgrade.

For users preferring upgrading from a version prior to v0.94.7 to
jewel, it is suggested to upgrade to the latest hammer first by
following the steps above, if the scale of your cluster is relatively
large.

And in the short term, we are preparing a fix[6] for hammer, so the
monitors will send osdmap encoded with lower version encoding.

In the long term, we won't use the new release feature bit in the
cluster unless allowed explicitly[7].


@ceph developers,

so if we want to bump up the encoding version of OSDMap or its
(sub)fields, I think it would be desirable to match the encoder with
the new major release feature bit. For instance, if a new field named
"foo" is added to `pg_pool_t` in kraken, and `map<int64_t,pg_pool_t>
pools` is in turn a field of `OSDMap`, then we need to be careful when
updating `pg_pool_t::encode()`, like

void pg_pool_t::encode(bufferlist& bl, uint64_t features) const {
  // ...
  if ((features & CEPH_FEATURE_SERVER_KRAKEN) == 0) {
    // encode in the jewel way
    return;
  }
  // encode in the kraken way
}

Because,

- it would be difficult for the monitor to send understandable osdmaps
for all osds.
- we disable/enable the new encoder by excluding/including the major
release feature bit in [7].

--
[1] sha1 039240418060c9a49298dacc0478772334526dce
[2] https://www.mail-archive.com/ceph-users@lists.ceph.com/msg30783.html
[3] http://www.spinics.net/lists/ceph-users/msg28296.html
[4] http://ceph-users.ceph.narkive.com/rPGrATpE/v0-94-7-hammer-released
[5] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-September/013189.html
[6] http://tracker.ceph.com/issues/17386
[7] https://github.com/ceph/ceph/pull/11284

-- 
Regards
Kefu Chai
