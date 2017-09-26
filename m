From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Single MDS cephx key
Date: Tue, 26 Sep 2017 23:09:33 +0000
Message-ID: <D5F02A0B.9B73A%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0073.outbound.protection.outlook.com ([104.47.34.73]:27520
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935447AbdIZXJg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 26 Sep 2017 19:09:36 -0400
Content-Language: en-US
Content-ID: <D6E52F8F23BA6E438233780CA5C0DA26@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Is it possible to use the same cephx key for all instances of MDS or do
they each require their own? Mons require the same keyring so I tried
following the same pattern by creating a keyring with "mds.", but the MDS
is complaining about not being authorized when it tries to start. Am I
missing something or is this not possible for MDS keys? If I create a
unique key for each MDS instance it works fine, but it would simplify my
scenario if I could use the same key. I'm running on Luminous.

The key was generated with this:
ceph auth get-or-create-key mds. osd allow * mds allow mon allow profile
mds



The keyring contents are:
[mds.]
key =3D AQD62spZw3zRGhAAkHHVokP3BDf8PEy4+vXGMg=3D=3D


I run the following with that keyring:
ceph-mds --foreground --name=3Dmds.mymds -i mymds

And I see the error:
2017-09-26 22:55:55.973047 7fb004459200 -1 mds.mds81c2n ERROR: failed to
authenticate: (22) Invalid argument



Thanks,
Travis


