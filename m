From: =?iso-2022-jp?B?GyRCNTUwZj9OO1YbKEIgLyBLQU1FSRskQiEkGyhCSElUT1NISQ==?=
        <hitoshi.kamei.xm@hitachi.com>
Subject: RE: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Date: Thu, 22 Mar 2018 11:58:38 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B39FFD@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA69E.2050007@hitachi.com>
 <20180320151510.GA13059@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320151510.GA13059@infradead.org>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

> The normal storage term would be fully provisioned, not 'thick'

The rbd command, which is user mode program, uses "thick-provision".
If the kernel rbd driver uses "fully provisioned", then the rbd command
should use "fully provisioned" too. 

What do you think, Jason?

Regards,

-- 
Hitoshi Kamei
