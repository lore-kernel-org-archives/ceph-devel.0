From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5] Ceph: Punch hole support for kernel client
Date: Tue, 27 Aug 2013 16:35:55 -0700
Message-ID: <20130827163555.99ef8be3dacd5bd5eadcac8c@linux-foundation.org>
References: <1376538704-6659-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376538704-6659-1-git-send-email-liwang@ubuntukylin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, 15 Aug 2013 11:51:44 +0800 Li Wang <liwang@ubuntukylin.com> wrote:

> This patch implements fallocate and punch hole support for Ceph kernel client.

i386 allmodconfig:

ERROR: "__divdi3" [fs/ceph/ceph.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2


Due to a 64-bit divide in ceph_zero_objects()
