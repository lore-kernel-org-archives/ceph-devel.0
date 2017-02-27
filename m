From: Pietari =?iso-8859-1?Q?Hyv=E4rinen?= <pietari.hyvarinen@csc.fi>
Subject: v0.94.10 Hammer release rpm signature issue
Date: Mon, 27 Feb 2017 16:30:27 +0200 (EET)
Message-ID: <1580591456.339414.1488205827058.JavaMail.zimbra@csc.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.csc.fi ([86.50.27.145]:49642 "EHLO smtp1.csc.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbdB0PIN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Feb 2017 10:08:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: abhishek@suse.com
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Hi! 

I have still some servers running hammer release and now new packages are not signed at all. yum update will fail on these new packages. I have seen attack vectors against systems with nonsigned packages.

 rpm -qp --queryformat %{SIGPGP} http://download.ceph.com/rpm-hammer/el7/x86_64/ceph-0.94.10-0.el7.x86_64.rpm
(none)

Previous hammer packages are signed. 

rpm -qp --queryformat %{SIGPGP} http://download.ceph.com/rpm-hammer/el7/x86_64/ceph-0.94.9-0.el7.x86_64.rpm
warning: http://download.ceph.com/rpm-hammer/el7/x86_64/ceph-0.94.9-0.el7.x86_64.rpm: Otsikko V4 RSA/SHA1 Signature, key ID 460f3994: NOKEY
89021c040001020006050257c5b9ab000a0910e84ac2c0460f39943f5b0ffe37aada0b3ec344dac9a2fc0d859d1d151e243f51592212327a29463d329d8156830cfca2bd53d69bdc8241d46697728b4b0a496e707aa895b8930da06b849ede1a9cd12d60bc3d70e77a88ba4edb429cd0f5e567864cb1e05c7b99b77cc0b60d25642ca522f37fecbfae562f7adbed0fa5e1780515790c0a3fa3a6ad4ea057813ac1ce28aa1611578665244be0cb8b4f6e8f4c34f29003d4a1bc2a2f161a357dd6bba7ac0783baae897c74fddd8c65b5dd9ac763c6534f2aa4485dbbbd46545b1f4d6cf890e7185460aab63bc9f318dda6b66b632254386b95fe338583c62b7fbe64444966dd3722f416ef3ca8c4e10555fa50ac88da4976acea6d4317020974fbd550a4e9361214490d5df13ad7e3066d146a733de6c684fc596c58c8f50d9fe72fbe9f584d5eb49b5702a96bc8fb71d92144c54a9d6c16008b4c7e2326f2336a02dc4aac8e788716f196f955562ec99d4c91072cee8f02779d09b60e5992420419875ff655efe02e01458d4637055be3
 44e377f594329a64324e0cb73b0eee0b7135433a1d313b643f71eff988995993f300ee10bc2076f44b663d28a536a5b6ba3c1b0a940a924af9c7b7508e5f2d0debe7445280d39737be18806d5fc710e241cc2e93a4d6a08481b8d054e5ac49a0876dceeb233c8c02c2dd012ea5d79e8b0b5bcae8b7e11d08da999dcc69e9ab19b34f80e7a0da81825439d08fa10e8d

ps. SHA1...

-- 
Pietari Hyvärinen
Storage Platforms
CSC - IT Center for Science Ltd.
