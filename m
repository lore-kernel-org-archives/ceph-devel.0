From: Allen <allen.lkml@gmail.com>
Subject: Re: [Y2038] [PATCH] ceph: use ktime_get_real_seconds()
Date: Thu, 21 Jun 2018 11:11:15 +0530
Message-ID: <CAOMdWSLtRLE4OnZGjXy+d7i5kO7CRPv0U=yM6dWjR1-iiJ09aw@mail.gmail.com>
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com> <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: arnd@arndb.de
Cc: netdev@vger.kernel.org, y2038@lists.linaro.org, ceph-devel@vger.kernel.org, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>
> I have done a similar patch and will post it soon along with the rest of the
> ceph y2038 series. Please have a look at "ceph: use timespec64 in for
> keepalive" and comment if you see something that I missed.
>

Oh Okay. Thank you Arnd.
