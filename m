From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH] ceph: use ktime_get_real_seconds()
Date: Wed, 20 Jun 2018 17:47:38 +0200
Message-ID: <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Allen Pais <allen.lkml@gmail.com>
Cc: Networking <netdev@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, ceph-devel <ceph-devel@vger.kernel.org>, David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jun 20, 2018 at 12:00 PM, Allen Pais <allen.lkml@gmail.com> wrote:
> Use ktime_get_real_seconds() as get_seconds() is deprecated.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

I have done a similar patch and will post it soon along with the rest of the
ceph y2038 series. Please have a look at "ceph: use timespec64 in for
keepalive" and comment if you see something that I missed.

       Arnd
