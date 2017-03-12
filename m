From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Linux 4.9: libceph: use BUG() instead of BUG_ON(1)
Date: Sun, 12 Mar 2017 20:38:24 +0100
Message-ID: <74bce114-8471-cdec-8fae-2108930648e9@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: ceph-devel.vger.kernel.org

Dear Greg,

could you, please, consider the following patch for the next Linux 4.9
release to avoid a build failure with gcc 4.9:

d24cdcd3e40a6825135498e11c20c7976b9bf545
libceph: use BUG() instead of BUG_ON(1)

Best regards

Heinrich Schuchardt
