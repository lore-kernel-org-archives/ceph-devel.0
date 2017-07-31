From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Mon stats in luminous rc
Date: Mon, 31 Jul 2017 16:49:37 +0000
Message-ID: <D5A4AD67.949E8%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:29968
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750947AbdGaQtl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 31 Jul 2017 12:49:41 -0400
Content-Language: en-US
Content-ID: <09C8E528331BE44A938E79F5BE4D63AD@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

The ceph status -f json command has changed quite a bit in luminous RC. I
see the following expected change with the health messages.
https://github.com/ceph/ceph/pull/15643

And in the pending release notes there is a new command for
time-sync-status.

However, I can't find what happened with the mon stats in the
health_services section. Where can I find them? In 12.1.0 they were there,
but not seeing them now in 12.1.1.

$ ceph health -f json| jq
{
  "health": {
    "health_services": [
      {
        "mons": [
          {
            "name": "mon0",
            "kb_total": 16888216,
            "kb_used": 2345480,
            "kb_avail": 13553604,
            "avail_percent": 80,
            "last_updated": "2017-07-31 15:43:49.107186",
            "store_stats": {
              "bytes_total": 1486739,
              "bytes_sst": 1504,
              "bytes_log": 1476780,
              "bytes_misc": 8455,
              "last_updated": "0.000000"
            },
            "health": "HEALTH_OK"
          },

=8A

Thanks!
Travis

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at
https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.kern=
el
.org%2Fmajordomo-info.html&data=3D02%7C01%7Ctravis.nielsen%40quantum.com%7C=
86
e91360dc5542e9dba208d4d7f80ede%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7
C636370907795181110&sdata=3DLFsTcjNkSpFMjVrfdLpO6m8fdsOD3wB3wlCFmMWI0bg%3D&=
re
served=3D0


